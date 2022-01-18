//
//  LZTestTableViewController.m
//  lzbluetooth-mini-ui-ios
//
//  Created by tanjian on 2021/11/17.
//

#import "LZTestTableViewController.h"
#import "LZTestTableViewCell.h"
#import "LZDialManagerViewController.h"



typedef NS_ENUM(NSUInteger, LZUISettingType) {
    // 手环
LZUISettingTypeHeartRateWarning = 1,    // M6心率检测
LZUISettingTypeSleepOximetry = 2,       // M6睡眠血氧检测
LZUISettingTypeSedentaryRemind = 3,     // M6久坐提醒

LZUISettingTypeSleepRemind = 4,         // M6睡眠提醒
LZUISettingTypeEventRemind = 5,         // 闹钟
LZUISettingTypeNightMode = 6,           // 夜间模式
LZUISettingTypeVibrationLevel = 7,      // 震动强度
LZUISettingTypeTimeFormat = 8,          // 24小时制
LZUISettingTypeDialManager = 9,         // 表盘管理
LZUISettingTypeCustomScreen = 10,        // 屏幕设置
LZUISettingTypeRestart = 11,            // 重启
LZUISettingTypeReset = 12,              // 恢复出厂设置
LZUISettingTypeUnbind = 13,             // 解绑
LZUISettingTypeRighteSwipeDisplay = 14,  // 右滑显示屏幕
LZUISettingTypeSportHrWarniing = 15,    // 运动心率

LZUISettingTypeTarget = 16,               // 目标设置
LZUISettingTypeMsgRemind = 17,            // 消息提醒设置
LZUISettingTypeHeartRateDuration = 18,        // 检测间隔
LZUISettingTypeFemaleHealth = 19,       // 女性健康
LZUISettingTypePeriodReminder = 20,     // 经期提醒
LZUISettingTypePeirod2Reminder = 21,       // 易孕期提醒
LZUISettingTypeWeather = 22,              // 天气

LZUISettingTypeSedentaryRemind2 = 23,     // 手表的勿扰模式
LZUISettingTypeSportHeartRateSection = 24,  // 运动区间设置


LZUISettingTypeHeartRateSwitch = 26,      // 心率开关
LZUISettingTypeSleepRemind2 = 27,         // 新的睡眠提醒

LZUISettingTypeMsgSend = 25,              // 消息发送
LZUISettingTypeCallMsgSend = 28,          // 来电提醒

LZUISettingTypeCallRemove = 33,     // 清除状态

LZUISettingTypeSyncTime = 34,     // 同步时间

LZUISettingTypeSyncData = 35,   // 同步数据

LZUISettingTypeSyncAllData = 36,  // 同步所有数据


LZUISettingTypeDrinkReminder = 37,  // 喝水提醒

LZUISettingTypeEncourageTarget = 38,  // 目标提醒
    
LZUISettingTypeRealtimeHROpen = 40, // 实时心率开
LZUISettingTypeRealtimeHRClose = 41,   // 实时心率关
    
LZUISettingTypeMioBeginJump = 0x0701,  // 开始跳绳
LZUISettingTypeMioEndJump = 0x0702,  // 结束跳绳
    
LZUISettingTypeMcuBoxTiming = 0x0801,  // 药盒设置时间
LZUISettingTypeMcuBoxSyncData = 0x0802,  // 药盒获取信息
LZUISettingTypeMcuBoxFind = 0x0803,     // 发现药盒
    
 // common
LZUISettingTypeOta = 0xf0001,            // Ota
    

};

@interface LZTestTableViewController ()

@property (nonatomic, strong) NSArray *list;

@end

@implementation LZTestTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *model = self.device.deviceInfo[kLZBluetoothDeviceInfoKeyModelName];
    
    if (self.device.deviceType == LZDeviceTypeBracelet) {
        if ([model containsString:@"456"] || [model containsString:@"437"]) {
            // HR6 || 小方表
            self.list = @[
                @(LZUISettingTypeHeartRateWarning),
                @(LZUISettingTypeSportHrWarniing),
                @(LZUISettingTypeRighteSwipeDisplay),
                @(LZUISettingTypeSleepOximetry),
                @(LZUISettingTypeSedentaryRemind),
                @(LZUISettingTypeSleepRemind),
                @(LZUISettingTypeEventRemind),
                @(LZUISettingTypeTimeFormat),
                @(LZUISettingTypeDialManager),
                @(LZUISettingTypeCustomScreen),
                @(LZUISettingTypeNightMode),
                @(LZUISettingTypeTarget),
                @(LZUISettingTypeSyncData),
            ];
        } else if ([model containsString:@"460"]) {
            // 大方表
            self.list = @[
                @(LZUISettingTypeHeartRateWarning),
                @(LZUISettingTypeSportHrWarniing),
                @(LZUISettingTypeSleepOximetry),
                @(LZUISettingTypeSedentaryRemind),
                @(LZUISettingTypeSleepRemind),
                @(LZUISettingTypeEventRemind),
                @(LZUISettingTypeTimeFormat),
                @(LZUISettingTypeDialManager),
                @(LZUISettingTypeCustomScreen),
                @(LZUISettingTypeNightMode),
                @(LZUISettingTypeTarget),
                @(LZUISettingTypeSyncData),
            ];
            
        } else if ([model containsString:@"431"]) {
            // memboHR2
            self.list = @[
                @(LZUISettingTypeHeartRateWarning),
                @(LZUISettingTypeSedentaryRemind),
                @(LZUISettingTypeEventRemind),
                @(LZUISettingTypeTimeFormat),
                @(LZUISettingTypeCustomScreen),
                @(LZUISettingTypeNightMode),
                @(LZUISettingTypeTarget),
                @(LZUISettingTypeRealtimeHROpen),
                @(LZUISettingTypeRealtimeHRClose),
                @(LZUISettingTypeMsgSend),
                @(LZUISettingTypeHeartRateSwitch),
                @(LZUISettingTypeCallMsgSend),
            ];
            
        } else {
            NSAssert(NO, @"不支持的设备");
        }
        
    } else if (self.device.deviceType == LZDeviceTypeMio) {
        self.list = @[
            @(LZUISettingTypeMioBeginJump),
            @(LZUISettingTypeMioEndJump),
        ];
    } else if (self.device.deviceType == LZDeviceTypeMcu) {
        self.list = @[
            @(LZUISettingTypeMcuBoxTiming),
            @(LZUISettingTypeMcuBoxSyncData),
            @(LZUISettingTypeMcuBoxFind)
        ];
    }
    
    [self.tableView registerNib:[UINib nibWithNibName:@"LZTestTableViewCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass(LZTestTableViewCell.class)];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LZTestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(LZTestTableViewCell.class) forIndexPath:indexPath];
    LZUISettingType settingType = [self.list[indexPath.row] integerValue];
    cell.textLabel.text = [self titleWithType:settingType];
    cell.setButton.tag = settingType;
    cell.getButton.tag = settingType;
    [cell.setButton addTarget:self action:@selector(setButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [cell.getButton addTarget:self action:@selector(getButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void)setButtonClicked:(UIButton *)sender {
    LZUISettingType settingType = sender.tag;
    id<LZDeviceSettingProtocol> setting = nil;
    switch (settingType) {
        case LZUISettingTypeHeartRateWarning:
        case LZUISettingTypeSportHrWarniing: {
            LZA5SettingCustomSportHRSectionReminderData *temp = [LZA5SettingCustomSportHRSectionReminderData new];
            temp.enable = YES;
            temp.minHr = 60;
            temp.maxHr = 120;
            temp.sportEnable = YES;
            temp.sportMaxHr = 160;
            temp.sportMinHr = 120;
            setting = temp;
            break;
        }

        case LZUISettingTypeRighteSwipeDisplay: {
            LZA5SettingMutipleData *temp = [LZA5SettingMutipleData new];
            LZMSetting *obj = [[LZMSetting alloc] init];
            obj.tag = LZSettingTagRightSwipeDisplay;
            obj.value = 2; // 参考自定义表盘类型
            temp.settings = @[obj];
            setting = temp;
            break;
        }

        case LZUISettingTypeSleepOximetry: {
            LZA5SettingMutipleData *temp = [LZA5SettingMutipleData new];
            LZMSetting *obj = [[LZMSetting alloc] init];
            obj.tag = LZSettingTagBloodOxygen;
            obj.value = 1;
            temp.settings = @[obj];
            setting = temp;
            break;
        }

        case LZUISettingTypeSedentaryRemind: {
            LZA5SettingSedentaryReminderData *temp = [[LZA5SettingSedentaryReminderData alloc] init];
            setting = temp;
            break;
        }

        case LZUISettingTypeSleepRemind: {
            LZA5SettingNewEventRemindData *temp = [LZA5SettingNewEventRemindData new];
            setting = temp;
            break;
        }
            
        case LZUISettingTypeEventRemind: {
            for (int i = 1; i < 10; i++) {
                LZA5SettingEventRemindData *temp = [LZA5SettingEventRemindData new];
                temp.index = i;
                temp.des = [NSString stringWithFormat:@"发发%d", i];
                temp.hour = 8;
                temp.minute = 10;
                temp.lightSleepEnable = YES;
                temp.lightSleepAlertTime = 10;
                temp.napEnable = YES;
                temp.napAlertTime = 15;
                [self.device sendDataModel:temp completion:^(LZBluetoothErrorCode result, id  _Nullable response) {
                                    
                }];
            }
            
            return;
        }
            
        case LZUISettingTypeTimeFormat: {
            static BOOL enable = YES;
            LZA5SettingTimeModeData *temp = [[LZA5SettingTimeModeData alloc] init];
            temp.timeMode = enable ? LZA5TimeMode12 : LZA5TimeMode24;
            setting = temp;
            enable = !enable;
            break;
        }
            
        case LZUISettingTypeDialManager: {
            LZDialManagerViewController *vc = [LZDialManagerViewController new];
            vc.device = self.device;
            [self.navigationController pushViewController:vc animated:YES];
            return;
        }
            
        case LZUISettingTypeCustomScreen: {
            LZA5SettingCustomScreenData *temp = [[LZA5SettingCustomScreenData alloc] init];
            temp.listPage = @[@(12), @(0), @(255), @(2), @(1), @(7), @(16)];
            setting = temp;
            break;
        }
            
        case LZUISettingTypeNightMode: {
            LZA5SettingMutipleData *temp = [LZA5SettingMutipleData new];
            LZMNightModeInfo *obj = [[LZMNightModeInfo alloc] init];
            obj.tag = LZSettingTagNightMode;
            obj.enableImmediately = YES;
            obj.enable = YES;
            obj.startHour = 8;
            obj.startMinute = 0;
            obj.endHour = 12;
            obj.endHour = 1;
            temp.settings = @[obj];
            setting = temp;
            break;
        }
            
        case LZUISettingTypeTarget: {
            LZA5SettingMutipleData *temp = [LZA5SettingMutipleData new];
            LZMSetting *obj = [[LZMSetting alloc] init];
            obj.tag = LZSettingTagSportStepTarget;
            obj.value = 4000;
            temp.settings = @[obj];
            setting = temp;
            break;
        }
            
        case LZUISettingTypeSyncData: {
            LZA5SettingSyncData *temp = [LZA5SettingSyncData new];
            temp.syncDataType = LZA5SyncDataTypeAll;
            setting = temp;
            break;
        }
            
        case LZUISettingTypeMioBeginJump: {
            LZMioBeginToJumpSetting *temp = [LZMioBeginToJumpSetting new];
            temp.jumpMode = LZMioJumpModeNumberCountdown;
            temp.settingContent = 11;
            temp.utc = (UInt32)([NSDate date].timeIntervalSince1970);
            temp.numberOfCountdown = 4;
            setting = temp;
            break;
        }
            
        case LZUISettingTypeMioEndJump: {
            LZMioEndToJumpSetting *temp = [LZMioEndToJumpSetting new];
            setting = temp;
            break;
        }
        case LZUISettingTypeMcuBoxTiming: {
            LZMcuTimingSetting *temp = [LZMcuTimingSetting new];
            temp.index = 1;
            LZMcuTimeData *time = [LZMcuTimeData new];
            
            NSCalendar *calendar = [NSCalendar currentCalendar];
            NSDateComponents *comp = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute fromDate:[NSDate date]];
            time.hour = (UInt32)comp.hour;
            time.min = (UInt32)comp.minute + 1;
            time.sec = 0;
            time.week = 127;
            temp.times = @[time];
            setting = temp;
            break;
        }
        case LZUISettingTypeMcuBoxSyncData: {
            LZMcuSyncData *temp = [LZMcuSyncData new];
            setting = temp;
            break;
        }
        case LZUISettingTypeMcuBoxFind: {
            LZMcuFindBoxSetting *temp = [LZMcuFindBoxSetting new];
            setting = temp;
            break;
        }
        case LZUISettingTypeRealtimeHROpen: {
            LZA5SettingRealTimeHeartRateSwitchData *temp = [LZA5SettingRealTimeHeartRateSwitchData new];
            temp.enable = YES;
            setting = temp;
            break;
        }
        case LZUISettingTypeRealtimeHRClose: {
            LZA5SettingRealTimeHeartRateSwitchData *temp = [LZA5SettingRealTimeHeartRateSwitchData new];
            temp.enable = NO;
            setting = temp;
            break;
        }
            
        default:
            break;
    }
    if (setting) {
        [self.device sendDataModel:setting completion:^(LZBluetoothErrorCode result, id  _Nullable response) {
            NSLog(@"sendDataModel %@ %@", @(result), response);
        }];
    }
}

- (void)getButtonClicked:(UIButton *)sender {
    LZUISettingType settingType = sender.tag;
    LZA5GetSettingType type = 0;
    if (self.device.deviceType != LZDeviceTypeBracelet || [self.device.deviceInfo[kLZBluetoothDeviceInfoKeyModelName] containsString:@"456"]) {
        NSLog(@"不支持");
        return;
    }
    switch (settingType) {
        case LZUISettingTypeHeartRateWarning:
            type = LZA5GetSettingTypeHeartRateWarningSetting;
            break;
            
        case LZUISettingTypeSportHrWarniing:
            type = LZA5GetSettingTypeSportHrWarnigSetting;
            break;
            
        case LZUISettingTypeRighteSwipeDisplay:
            type = LZA5GetSettingTypeRightSwipDisplaySetting;
            break;
            
        case LZUISettingTypeSleepOximetry:
            type = LZA5GetSettingTypeSleepBloodOxygenSetting;
            break;
        
        case LZUISettingTypeSedentaryRemind:
            type = LZA5GetSettingTypeSedentaryReminderSetting;
            break;
            
        case LZUISettingTypeSleepRemind:
            type = LZA5GetSettingTypeSleepReminderSetting;
            break;
            
        case LZUISettingTypeEventRemind:
            type = LZA5GetSettingTypeEventReminderSetting;
            break;
        case LZUISettingTypeTimeFormat:
            type = LZA5GetSettingTypeTimeFormatSetting;
            break;
            
        case LZUISettingTypeDialManager:
            type = LZA5GetSettingTypeDialTypeSetting;
            break;
        case LZUISettingTypeCustomScreen:
            type = LZA5GetSettingTypeCustomPagesSetting;
            break;
            
        case LZUISettingTypeNightMode:
            type = LZA5GetSettingTypeNightModeSetting;
            break;
            
        case LZUISettingTypeTarget:
            type = LZA5GetSettingTypeTargetSetting;
            break;
        
        default:
            break;
    }
    [self.device getSettingsWithSyncType:type completion:^(LZBluetoothErrorCode result, id  _Nullable response) {
        NSLog(@"result %@ %@", @(result), response);
    }];
}


- (NSString *)titleWithType:(LZUISettingType)settingType {
    switch (settingType) {
        case LZUISettingTypeHeartRateWarning:
            return @"心率检测";
        case LZUISettingTypeSportHrWarniing:
            return @"运动心率检测";
        case LZUISettingTypeRighteSwipeDisplay:
            return @"快捷显示";
        case LZUISettingTypeSleepOximetry:
            return @"血氧开关";
        case LZUISettingTypeSedentaryRemind:
            return @"久坐提醒";
        case LZUISettingTypeSleepRemind:
            return @"睡眠提醒";
        case LZUISettingTypeEventRemind:
            return @"事件提醒";
        case LZUISettingTypeTimeFormat:
            return @"时间格式";
        case LZUISettingTypeDialManager:
            return @"表盘管理";
        case LZUISettingTypeCustomScreen:
            return @"自定义屏幕";
        case LZUISettingTypeNightMode:
            return @"夜间模式";
        case LZUISettingTypeTarget:
            return @"目标";
        case LZUISettingTypeSyncData:
            return @"拉取数据";
            
        case LZUISettingTypeMioBeginJump:
            return @"开始跳绳";
        case LZUISettingTypeMioEndJump:
            return @"结束跳绳";
            
        case LZUISettingTypeMcuBoxSyncData:
            return @"获取药盒数据";
        case LZUISettingTypeMcuBoxTiming:
            return @"设置定时时间";
        case LZUISettingTypeMcuBoxFind:
            return @"发现药盒";
        case LZUISettingTypeRealtimeHROpen:
            return @"实时心率开";
        case LZUISettingTypeRealtimeHRClose:
            return @"实时心率关";
        default:
            break;
    }
    return @"";
    
}


@end
