//
//  LZWeatherViewController.m
//  lzbluetooth-mini-ui-ios
//
//  Created by tanjian on 2021/1/19.
//

#import "LZWeatherViewController.h"
#import "LZSetPickerViewController.h"
#import "LZPickerAnimator.h"
#import "UIViewController+MBProgressHUD.h"

@interface LZWeatherViewController () <LZSetPickerDelegate>

@property (nonatomic, strong) LZWeatherData *data;
@property (nonatomic, strong) NSArray <LZBaseSetCellModel *> *models;

@property (nonatomic, strong) LZPickerAnimator *pickerAnimotor;

@end

@implementation LZWeatherViewController

@dynamic data;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"天气设置";
    self.data.updateTime = [[NSDate date] timeIntervalSince1970];
    UIBarButtonItem *requestItem = [[UIBarButtonItem alloc] initWithTitle:@"请求" style:UIBarButtonItemStylePlain target:self action:@selector(requestItemClicked:)];
    
    UIBarButtonItem *okItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(okItemClicked:)];
    self.navigationItem.rightBarButtonItems = @[requestItem, okItem];
    [self updateUI];
}

- (void)updateUI {
    LZBaseSetCellModel *model0 = self.models[0];
    LZBaseSetCellModel *model1 = self.models[1];
    LZBaseSetCellModel *model2 = self.models[2];
    LZBaseSetCellModel *model3 = self.models[3];
    
    LZWeatherDayData *contentData = self.data.weatherFutures.firstObject;
    if (contentData == nil) {
        contentData = [LZWeatherDayData new];
        self.data.weatherFutures = @[contentData];
    }
    
    model0.subStr = [self stringWithWeatherCode:contentData.weatherState];
    model1.subStr = [NSString stringWithFormat:@"%@ 摄氏度", @(contentData.temperature1)];
    model2.subStr = [NSString stringWithFormat:@"%@ 摄氏度" , @(contentData.temperature2)];
    model3.subStr = [NSString stringWithFormat:@"%@", @(contentData.aqi)];
    
    [self.tableView reloadData];
    
}

#pragma mark - LZSetPickerDelegate
- (void)pickerViewControllerDidSelect:(LZSetPickerViewController *)vc {
    NSInteger index = self.tableView.indexPathForSelectedRow.row;
    NSInteger row = [vc selectedRowInComponent:0];
    
    LZWeatherDayData *contentData = self.data.weatherFutures.firstObject;
    
    switch (index) {
        case 0:
            contentData.weatherState = row;
            break;
        case 1:
            contentData.temperature1 = row - 100;
            break;
        case 2:
            contentData.temperature2 = row - 100;
            break;
        case 3:
            contentData.aqi = row;
            break;
            
        default:
            break;
    }
    
    [self updateUI];
    
    [vc dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Event
- (void)requestItemClicked:(id)sender {
    double latitude = 31.209086100260418;
    double longitude = 121.40808648003473;
    __weak typeof(self) weakSelf = self;
    [self showActivityIndicatorViewWithTitle:@""];
    [LZBluetooth requestWeatherWithLng:longitude lat:latitude adcode:@"310105" completion:^(NSInteger code, NSString * _Nonnull msg, LZWeatherData * _Nonnull data) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf hideActivityIndicatorHUD];
            [weakSelf showHintMessage:msg duration:1.5];
            if (data) {
                weakSelf.data = data;
                [weakSelf updateUI];
            }
        });
    }];
}

- (void)okItemClicked:(id)sender {
    /// 这里测试，暂时就发送一个数据
    [self sendData:self.data];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.models.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LZBaseSetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(LZBaseSetTableViewCell.class) forIndexPath:indexPath];
    LZBaseSetCellModel *model = self.models[indexPath.row];
    [cell updateCellWithModel:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LZSetPickerViewController *vc = [[LZSetPickerViewController alloc] init];
    vc.modalPresentationStyle = UIModalPresentationCustom;
    self.pickerAnimotor = [[LZPickerAnimator alloc] initWithPresentedViewController:self presentingViewController:vc];
    vc.transitioningDelegate = self.pickerAnimotor;
    vc.delegate = self;
    
    switch (indexPath.row) {
        case 0:
            vc.dataSoureAry = @[[self weatherCode]];
            break;
        case 1:
            vc.dataSoureAry = @[[self tempArray]];
            break;
        case 2:
            vc.dataSoureAry = @[[self tempArray]];
            break;
        case 3:
            vc.dataSoureAry = @[[self aqiArray]];
            break;
            
        default:
            break;
    }
    
    [self presentViewController:vc animated:YES completion:nil];
}

- (NSArray<LZBaseSetCellModel *> *)models {
    if (!_models) {
        LZBaseSetCellModel *model0 = [[LZBaseSetCellModel alloc] initModelWithSetType:0 cellStyle:DEVICESETCELLSTYLE_RIGHT_SUBTITLE titleStr:@"天气气象代码" subStr:@""];
        LZBaseSetCellModel *model1 = [[LZBaseSetCellModel alloc] initModelWithSetType:1 cellStyle:DEVICESETCELLSTYLE_RIGHT_SUBTITLE titleStr:@"温度范围1" subStr:@""];
        LZBaseSetCellModel *model2 = [[LZBaseSetCellModel alloc] initModelWithSetType:2 cellStyle:DEVICESETCELLSTYLE_RIGHT_SUBTITLE titleStr:@"温度范围2" subStr:@""];
        LZBaseSetCellModel *model3 = [[LZBaseSetCellModel alloc] initModelWithSetType:3 cellStyle:DEVICESETCELLSTYLE_RIGHT_SUBTITLE titleStr:@"AQI" subStr:@""];
        _models = @[model0, model1, model2, model3];
    }
    return _models;
}

- (NSString *)stringWithWeatherCode:(UInt8)weatherCode {
    switch (weatherCode) {
        case 0x00:
            return @"晴(白天)";
        case 0x01:
            return @"晴(夜晚)";
        case 0x02:
            return @"多云";
        case 0x03:
            return @"晴间多云(白天)";
        case 0x04:
            return @"晴间多云(夜晚)";
        case 0x05:
            return @"大部多云(白天)";
        case 0x06:
            return @"大部多云(夜晚)";
        case 0x07:
            return @"阴";
        case 0x08:
            return @"阵雨";
        case 0x09:
            return @"雷阵雨";
        case 0x0a:
            return @"冰雹或雷阵雨伴有冰雹";
       
        case 0x0b:
            return @"小雨";
        case 0x0c:
            return @"中雨";
        case 0x0d:
            return @"大雨";
        case 0x0e:
            return @"暴雨";
        case 0x0f:
            return @"大暴雨";
        case 0x10:
            return @"特大暴雨";
        case 0x11:
            return @"冻雨";
        case 0x12:
            return @"雨夹雪";
        case 0x13:
            return @"阵雪";
        case 0x14:
            return @"小雪";
            
        case 0x15:
            return @"中雪";
        case 0x16:
            return @"大雪";
        case 0x17:
            return @"暴雪";
        case 0x18:
            return @"浮尘";
        case 0x19:
            return @"扬沙";
        case 0x1a:
            return @"沙尘暴";

        case 0x1b:
            return @"强沙尘暴";
        case 0x1c:
            return @"雾";
        case 0x1d:
            return @"霾";
        case 0x1e:
            return @"风";
        case 0x1f:
            return @"大风";
        case 0x20:
            return @"飓风";
        case 0x21:
            return @"热带风暴";
        case 0x22:
            return @"龙卷风";
        default:
            break;
    }
    
    return @"";
}

- (NSArray *)tempArray {
    NSMutableArray *array = [NSMutableArray array];
    for (int i = -100; i <= 100; i += 1) {
        [array addObject:[NSString stringWithFormat:@"%d", i]];
    }
    return array;
}

- (NSArray *)weatherCode {
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i <= 0x22; i += 1) {
        [array addObject:[self stringWithWeatherCode:i]];
    }
    return array;
}

- (NSArray *)aqiArray {
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i <= 0x100; i += 1) {
        [array addObject:[NSString stringWithFormat:@"%d", i]];
    }
    return array;
}

@end
