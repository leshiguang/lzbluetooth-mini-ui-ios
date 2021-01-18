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



@interface LZBraceletInfoViewController () <UITableViewDelegate, UITableViewDataSource, LZSettingTableViewCellDelegate>
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
    [self initSetSwitchState];
    
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

#pragma mark - Private Methods
- (void)initSetSwitchState {
    
    
}

#pragma mark - LZSettingTableViewCellDelegate

- (void)unbindClick:(LZSettingCellModel *)cellModel {
//    __weak typeof(self) weakSelf = self;
    [self.deviceManager deleteMonitorDeviceWithMacString:self.device.mac];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)switchOn:(BOOL)isOn cellModle:(LZSettingCellModel *)cellModel {
    if (cellModel.setType == DEVICESETTYPE_PHONE_CALL_REMINDING) {
        //来电提醒

        LZA5SettingCallReminderData *data = [[LZA5SettingCallReminderData alloc] init];
        data.reminderType = LZA5CallReminderTypeDefault;
        data.enable = isOn;
        [self sendData:data];
    } else if (cellModel.setType == DEVICESETTYPE_HEART_RATE__MONITOR) {
        //心率监测
        LZA5SettingSmartHRDetectionData *data = [[LZA5SettingSmartHRDetectionData alloc] init];
        data.mode = isOn;
        [self sendData:data];
    }
}

- (void)setFail {
    [self reloadData];
}

#pragma mark - cell select
- (void)cellSelect:(LZSettingCellModel *)model {
    switch (model.setType) {
        case DEVICESETTYPE_DIAL_SET: {
            LZDialSetViewController *vc = [[LZDialSetViewController alloc] init];
            vc.device = self.device;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case DEVICESETTYPE_GOAL_SETTING: {
            LZGoalSetViewController *vc = [[LZGoalSetViewController alloc] init];
            vc.device = self.device;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case DEVICESETTYPE_EVENT_TO_REMIND: {
            LZEventToRemindViewController *vc = [[LZEventToRemindViewController alloc] init];
            vc.device = self.device;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case DEVICESETTYPE_HEART_RATE_WARNING: {
            LZHeartRataWarningViewController *vc = [[LZHeartRataWarningViewController alloc] init];
            vc.device = self.device;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case DEVICESETTYPE_MESSAGE_TO_REMIND: {
            LZMessageToRemindViewController *vc = [[LZMessageToRemindViewController alloc] init];
            vc.device = self.device;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case DEVICESETTYPE_NIGHT_MODE: {
            LZNightModeViewController *vc = [[LZNightModeViewController alloc] init];
            vc.device = self.device;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case DEVICESETTYPE_DND_MODE: {
            LZDndModeViewController *vc = [[LZDndModeViewController alloc] init];
            vc.device = self.device;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case DEVICESETTYPE_SCREEN_ORIENTATION: {
            LZScreenOrientationViewController *vc = [[LZScreenOrientationViewController alloc] init];
            vc.device = self.device;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case DEVICESETTYPE_SPORT_TYPE: {
            LZSportTypeViewController *vc = [[LZSportTypeViewController alloc] init];
            vc.device = self.device;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case DEVICESETTYPE_TIME_FORMAT: {
            LZTimeFormatViewController *vc = [[LZTimeFormatViewController alloc] init];
            vc.device = self.device;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case DEVICESETTYPE_WEARING_HABITS: {
            LZWearingHabitsViewController *vc = [[LZWearingHabitsViewController alloc] init];
            vc.device = self.device;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case DEVICESETTYPE_SCREEN_CONTENT: {
            LZScreenContentViewController *vc = [[LZScreenContentViewController alloc] init];
            vc.device = self.device;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;

        default:
            break;
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
    cell.delegate = self;
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
