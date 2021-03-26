//
//  LZWifiSettingViewController.m
//  lzbluetooth-mini-ui-ios
//
//  Created by tanjian on 2021/2/1.
//

#import "LZWifiSettingViewController.h"
#import "LZInputStringTableViewCell.h"
#import "UIViewController+MBProgressHUD.h"

@interface LZWifiSettingViewController () <LZDeviceDelegate, LZInputStringTableViewCellDelegate>

@property (nonatomic, strong) NSMutableDictionary *wifiMap;
@property (nonatomic, strong) NSMutableArray <LZWifiData *> *dataSource;
@property (nonatomic, strong) NSMutableArray <LZBaseSetCellModel *> *modelArray;

@property (nonatomic, strong) LZWifiData *selectData;

@end

@implementation LZWifiSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *scanItem = [[UIBarButtonItem alloc] initWithTitle:@"scan" style:UIBarButtonItemStylePlain target:self action:@selector(scanItemClicked:)];
    UIBarButtonItem *stopItem = [[UIBarButtonItem alloc] initWithTitle:@"status" style:UIBarButtonItemStylePlain target:self action:@selector(stopItemClicked:)];
    UIBarButtonItem *resetItem = [[UIBarButtonItem alloc] initWithTitle:@"reset" style:UIBarButtonItemStylePlain target:self action:@selector(resetItemClicked:)];
    self.navigationItem.rightBarButtonItems = @[scanItem, stopItem, resetItem];
    
    [self.tableView registerClass:[LZInputStringTableViewCell class] forCellReuseIdentifier:NSStringFromClass(LZInputStringTableViewCell.class)];
}

#pragma mark - Event
- (void)scanItemClicked:(id)sender {
    LZWifiScanData *wifiScanData = [[LZWifiScanData alloc] init];
    wifiScanData.scanType = 1;
    wifiScanData.showHidden = YES;
    __weak typeof(self) weakSelf = self;
    [self showActivityIndicatorHUDWithMessage:nil];
    [self.deviceManager sendDataModel:wifiScanData macString:self.device.macAddress completion:^(LZBluetoothErrorCode result, id resp) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf hideActivityIndicatorHUD];
            if (result == LZBluetoothErrorCodeSuccess) {
                [weakSelf.dataSource removeAllObjects];
                [weakSelf.modelArray removeAllObjects];
                if ([resp isKindOfClass:[NSArray class]]) {
                    NSArray *list = resp;
                    [list enumerateObjectsUsingBlock:^(LZWifiData *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        LZBaseSetCellModel *model = [self modelWithWifiData:obj];
                        model.setType = self.dataSource.count;
                        [weakSelf.dataSource addObject:obj];
                        [weakSelf.modelArray addObject:model];
                    }];
                }
                [weakSelf.tableView reloadData];
                [weakSelf showHintMessage:@"设置成功" duration:1];
            } else {
                [weakSelf showHintMessage:@"设置失败" duration:1];
            }
            [weakSelf updateUIWithResult:result];
        });
    }];
}

- (void)stopItemClicked:(id)sender {
    __weak typeof(self) weakSelf = self;
    LZWifiStatus *wifiScanData = [[LZWifiStatus alloc] init];
    [self.device sendDataModel:wifiScanData completion:^(LZBluetoothErrorCode result, id resp) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf hideActivityIndicatorHUD];
            if (result == LZBluetoothErrorCodeSuccess) {
                [weakSelf.dataSource removeAllObjects];
                [weakSelf.modelArray removeAllObjects];
                if ([resp isKindOfClass:[LZWifiData class]]) {
                    LZBaseSetCellModel *model = [self modelWithWifiData:resp];
                    model.setType = self.dataSource.count;
                    [weakSelf.dataSource addObject:resp];
                    [weakSelf.modelArray addObject:model];
                }
                [weakSelf.tableView reloadData];
                [weakSelf showHintMessage:@"设置成功" duration:1];
            } else {
                [weakSelf showHintMessage:@"设置失败" duration:1];
            }
            [weakSelf updateUIWithResult:result];
        });
    }];
}

- (void)resetItemClicked:(id)sender {
    LZWifiReset *data = [[LZWifiReset alloc] init];
    [self showActivityIndicatorHUDWithMessage:nil];
    __weak typeof(self) weakSelf = self;
    [self.deviceManager sendDataModel:data macString:self.device.macAddress completion:^(LZBluetoothErrorCode result, id resp) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf hideActivityIndicatorHUD];
            if (result == LZBluetoothErrorCodeSuccess) {
                [weakSelf showHintMessage:@"设置成功" duration:1];
            } else {
                [weakSelf showHintMessage:@"设置失败" duration:1];
            }
            [weakSelf updateUIWithResult:result];
        });
    }];
}

#pragma mark - LZInputStringTableViewCellDelegate
- (void)inputTableViewCellDidInputString:(NSString *)string cellModle:(LZBaseSetCellModel *)cellModel {
    LZWifiData *data = self.dataSource[cellModel.setType];
    data.password = string;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LZInputStringTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(LZInputStringTableViewCell.class) forIndexPath:indexPath];
    LZBaseSetCellModel *model = self.modelArray[indexPath.row];
    cell.delegate = self;
    [cell updateCellWithModel:model];
    cell.textField.placeholder = @"请输入密码";
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectData = self.dataSource[indexPath.row];
    if (self.selectData.password.length >= 8 && self.selectData.password.length <= 63) {
        [self sendData:self.selectData];
    } else {
        [self showWithTime:1.5 title:@"密码格式不对"];
    }
}

#pragma mark - Private

- (LZBaseSetCellModel *)modelWithWifiData:(LZWifiData *)data {
    LZBaseSetCellModel *model = [[LZBaseSetCellModel alloc] initModelWithSetType:0 cellStyle:DEVICESETCELLSTYLE_RIGHT_SELECTIMAGE titleStr:data.ssid subStr:data.password];
    return model;
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (NSMutableArray<LZBaseSetCellModel *> *)modelArray {
    if (!_modelArray) {
        _modelArray = [NSMutableArray array];
    }
    return _modelArray;
}

@end
