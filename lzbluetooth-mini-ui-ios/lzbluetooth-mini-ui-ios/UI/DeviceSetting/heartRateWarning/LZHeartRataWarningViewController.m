//
//  LZHeartRataWarningViewController.m
//  LSBluetoothUI_iOS
//
//  Created by wm on 2020/12/8.
//

#import "LZHeartRataWarningViewController.h"
#import <Masonry/Masonry.h>
#import "LZPickerAnimator.h"
#import "LZSetPickerViewController.h"

static int minHr = 20;
static int maxHr = 300;

typedef NS_ENUM(NSUInteger, LZHearRateWarningStyle) {
    LZHearRateWarningStyleSwitch,
    LZHearRateWarningStyleZone,
};

@interface LZHeartRataWarningViewController () < LZBaseSetTableViewCellDelegate, LZSetPickerDelegate>
@property (nonatomic, copy) NSArray <LZBaseSetCellModel *> *modelAry;
@property (nonatomic, copy) NSArray *hearRateValueAry;

@property (nonatomic, strong) LZA5SettingCustomSportHRSectionReminderData *data;
@end

@implementation LZHeartRataWarningViewController

@dynamic data;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"心率预警";
    self.view.backgroundColor = [UIColor whiteColor];
    [self updateUI];
}

- (void)updateUI {
    LZBaseSetCellModel *model1 = self.modelAry[0];
    model1.switchIsOpne = self.data.enable;
    LZBaseSetCellModel *model2 = self.modelAry[1];
    model2.subStr = [NSString stringWithFormat:@"%@~%@", @(self.data.minHr), @(self.data.maxHr)];
   
    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self handleCellClickWithModel:self.modelAry[indexPath.row]];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LZBaseSetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LZBaseSetTableViewCell class]) forIndexPath:indexPath];
    [cell updateCellWithModel:self.modelAry[indexPath.row]];
    cell.delegate = self;
    return cell;
}

#pragma mark - LZHeartRateWarningCellDelegate
- (void)switchOn:(BOOL)isOn cellModle:(LZBaseSetCellModel *)cellModel {
    self.data.enable = isOn;
    [self sendData:self.data];
}

- (void)pickerViewControllerDidSelect:(LZSetPickerViewController *)vc {
    self.data.minHr = [vc selectedRowInComponent:0] + minHr;
    self.data.maxHr = [vc selectedRowInComponent:1] + maxHr;
    
    [vc dismissViewControllerAnimated:YES completion:^{
            
    }];
    [self updateUI];
}

#pragma mark - Private Methods

- (void)handleCellClickWithModel:(LZBaseSetCellModel *)model {
    if (model.setType == LZHearRateWarningStyleZone) {
        LZSetPickerViewController *vc = [[LZSetPickerViewController alloc] init];
        vc.modalPresentationStyle = UIModalPresentationCustom;
        LZPickerAnimator *pickerAnimotor = [[LZPickerAnimator alloc] initWithPresentedViewController:self presentingViewController:vc];
        vc.transitioningDelegate = pickerAnimotor;
        vc.delegate = self;
//        self.currentPickerType = model.setType;
        vc.dataSoureAry = @[self.hearRateValueAry, self.hearRateValueAry];
        [self presentViewController:vc animated:YES completion:nil];
    }
}

#pragma mark - getter
- (NSArray<LZBaseSetCellModel *> *)modelAry {
    if (!_modelAry) {
        NSMutableArray *mAry = [[NSMutableArray alloc] init];
        LZBaseSetCellModel *model1 = [[LZBaseSetCellModel alloc] initModelWithSetType:LZHearRateWarningStyleSwitch cellStyle:DEVICESETCELLSTYLE_RIGHT_SWITCH titleStr:@"预警开关" subStr:nil];
        [mAry addObject:model1];
        
        LZBaseSetCellModel *model2 = [[LZBaseSetCellModel alloc] initModelWithSetType:LZHearRateWarningStyleZone cellStyle:DEVICESETCELLSTYLE_RIGHT_IMG_SUBTITLE titleStr:@"心率区间" subStr:@"20~30"];
        [mAry addObject:model2];
        _modelAry = mAry;
    }
    return _modelAry;
}

- (NSArray *)hearRateValueAry {
    if (!_hearRateValueAry) {
        _hearRateValueAry = [[NSArray alloc] init];
        NSMutableArray *mAry = [[NSMutableArray alloc] init];
        for (int i = minHr; i <= maxHr; i++) {
            [mAry addObject:[NSString stringWithFormat:@"%@%d",i<10 ? @"0": @"",i]];
        }
        _hearRateValueAry = [mAry copy];
    }
    return _hearRateValueAry;
}

@end
