//
//  LZBraceletInfoViewController.m
//  LSBluetoothUI_iOS
//
//  Created by wm on 2020/12/2.
//

#import "LZBraceletInfoViewController.h"
#import <Masonry/Masonry.h>
#import "LZSettingTableViewCell.h"
#import "LZSettingCellModel.h"

#import "LZScreenContentViewController.h"
#import "LZDialSetViewController.h"
#import "LZGoalSetViewController.h"
#import "LZEventToRemindViewController.h"
#import "LZHeartRataWarningViewController.h"
#import "LZMessageToRemindViewController.h"
#import "LZNightModeViewController.h"
#import "LZDndModeViewController.h"
#import "LZScreenOrientationViewController.h"
#import "LZSportTypeViewController.h"
#import "LZTimeFormatViewController.h"
#import "LZWearingHabitsViewController.h"



@interface LZBraceletInfoViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray <LZSettingCellModel *> * dataSourceAry;

@property (nonatomic, assign) BOOL callRemindingIsOpen;
@property (nonatomic, assign) BOOL hearRateMonitorIsOpen;
@end

@implementation LZBraceletInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设备详情";
    self.view.backgroundColor = [UIColor whiteColor];
    [self createUI];
    [self reloadData];
}

- (void)createUI {
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)reloadData {
    
    NSMutableArray *mAry = [self.dataSourceAry mutableCopy];
    LZSettingCellModel *deviceNameModel = mAry[0];
    deviceNameModel.subStr = self.device.name;
    
    LZSettingCellModel *macModel = mAry[1];
    macModel.subStr = self.device.mac;
    
    LZSettingCellModel *cellRemindingModel = mAry[2];
    cellRemindingModel.switchIsOpne = self.callRemindingIsOpen;
    
    LZSettingCellModel *heartRateMonitorModel = mAry[7];
    heartRateMonitorModel.switchIsOpne = self.hearRateMonitorIsOpen;
    
    self.dataSourceAry = [mAry copy];
    [self.tableView reloadData];
}

#pragma mark - LZSettingTableViewCellDelegate
- (void)unbindClick:(LZSettingCellModel *)cellModel {
//    __weak typeof(self) weakSelf = self;
    [self.deviceManager deleteMonitorDeviceWithMacString:self.device.mac];
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - cell select
- (void)cellSelect:(LZSettingCellModel *)model {
    NSString *className = nil;
    switch (model.setType) {
        case DEVICESETTYPE_UNBIND:
            [self unbindClick:model];
            break;
        case LZBraceletSettingTypeDial: {
            className = @"LZDialSetViewController";
        }
            break;
        case LZBraceletSettingTypeTargetEncourage: {
            className = @"LZGoalSetViewController";
        }
            break;
        case LZBraceletSettingTypeEventReminder: {
            className = @"LZEventToRemindViewController";
        }
            break;
        case LZBraceletSettingTypeCustomSportHrReminder: {
            className = @"LZHeartRataWarningViewController";
        }
            break;
        case LZBraceletSettingTypeCallReminder: {
            className = @"LZMessageToRemindViewController";
        }
            break;
        case LZBraceletSettingTypeNightMode: {
            className = @"LZNightModeViewController";
        }
            break;
        case LZBraceletSettingTypeNoDisturb: {
            className = @"LZDndModeViewController";
        }
            break;
        case LZBraceletSettingTypeScreenDirection: {
            className = @"LZScreenOrientationViewController";
        }
            break;
        case LZBraceletSettingTypeTimeMode: {
            className = @"LZTimeFormatViewController";
        }
            break;
        case LZBraceletSettingTypeWristHabit: {
            className = @"LZWearingHabitsViewController";
        }
            break;
        case LZBraceletSettingTypeCustomScreen: {
            className = @"LZScreenContentViewController";
        }
            break;

        default:
            break;
    }
    
    if (className) {
        LZDeviceManagerViewController *vc = [[NSClassFromString(className) alloc] init];
        if (vc) {
            vc.device = self.device;
            vc.settingType = model.setType;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == self.dataSourceAry.count-1) {
        return 100;
    }
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    LZSettingCellModel *model = self.dataSourceAry[indexPath.row];
    [self cellSelect:model];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSourceAry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LZSettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LZSettingTableViewCell class])];
    [cell updateCellWithModel:self.dataSourceAry[indexPath.row]];
    return cell;
}

#pragma mark - getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[LZSettingTableViewCell class] forCellReuseIdentifier:NSStringFromClass([LZSettingTableViewCell class])];
    }
    return _tableView;
}

- (NSArray<LZSettingCellModel *> *)dataSourceAry {
    if (!_dataSourceAry) {
        _dataSourceAry = [[NSArray alloc] init];
        _dataSourceAry = [LZSettingCellModel cellModelList];
    }
    return _dataSourceAry;
}

@end
