//
//  LZTestTableViewController.m
//  lzbluetooth-mini-ui-ios
//
//  Created by tanjian on 2021/11/17.
//

#import "LZTestTableViewController.h"
#import "LZTestTableViewCell.h"
#import "LZDialManagerViewController.h"

#import <LZSkip/LZSkip.h>
#import <LZBox/LZBox.h>
#import <LZCavosmart/LZCavosmart.h>


@import LZGlucose;



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
    
LZUISettingTypeCVBP = 0x0901,  // 实时血压
LZUISettingTypeCVBPSwitch = 0x0902, // 血压显示
LZUISettingTypeCVTemp = 0x0903,  // 实时温度
LZUISettingTypeCVTempSwitch = 0x0904,  // 温度显示
LZUISettingTypeCVClock = 0x0905,  // 闹钟
LZUISettingTypeCVDial = 0x0906,  // 表盘
LZUISettingTypeCVEncourage = 0x0907,  // 鼓励目标
LZUISettingTypeCVHRSwich = 0x0908,  // 心率开关
LZUISettingTypeCVLanguage = 0x0909,  // 语言
LZUISettingTypeCVLongSit = 0x090a,  // 久坐
LZUISettingTypeCVMsgRemind = 0x090b,  // 消息提醒开关
LZUISettingTypeCVRaise = 0x090c,  // 抬腕亮屏
LZUISettingTypeCVSyncData = 0x090d,  // 同步数据
LZUISettingTypeCVTimeFormat = 0x090e,  // 时间格式
LZUISettingTypeCVUserInfo = 0x0910,  // 同步用户信息
    
 
LZUISettingTypeG3ReadCount = 0x0a01, // 获取历史数据
LZUISettingTypeG3Delete = 0x0a02,   // 删除历史数据
    
 // common
LZUISettingTypeOta = 0xf0001,            // Ota
    
};

@interface LZTestTableViewController ()

@property (nonatomic, strong) NSArray *list;

@property (nonatomic, strong) NSMutableDictionary *cacheDic;

@end

@implementation LZTestTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _cacheDic = [NSMutableDictionary dictionary];
    
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
            
        }
        else {
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
    } else if (self.device.deviceType == LZDeviceTypeCavo) {
        self.list = @[
            @(LZUISettingTypeCVBP),
            @(LZUISettingTypeCVBPSwitch),
            @(LZUISettingTypeCVTemp),
            @(LZUISettingTypeCVTempSwitch),
            @(LZUISettingTypeCVClock),
            @(LZUISettingTypeCVDial),
            @(LZUISettingTypeCVEncourage),
            @(LZUISettingTypeCVHRSwich),
            @(LZUISettingTypeCVLanguage),
            @(LZUISettingTypeCVLongSit),
            @(LZUISettingTypeCVMsgRemind),
            @(LZUISettingTypeCVRaise),
            @(LZUISettingTypeCVSyncData),
            @(LZUISettingTypeCVTimeFormat),
            @(LZUISettingTypeCVUserInfo),
        ];

    } else if (self.device.deviceType == LZDeviceTypeG3) {
        self.list = @[
            @(LZUISettingTypeG3ReadCount),
            @(LZUISettingTypeG3Delete)
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
            temp.syncDataType = LZA5SyncDataTypeMeasureData;
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

//        case LZUISettingTypeMioEndJump: {
//            LZMioEndToJumpSetting *temp = [LZMioEndToJumpSetting new];
//            setting = temp;
//            break;
//        }
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
//        case LZUISettingTypeMcuBoxFind: {
//            LZMcuFindBoxSetting *temp = [LZMcuFindBoxSetting new];
//            setting = temp;
//            break;
//        }
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
            
        case LZUISettingTypeCVBP: {
            LZCVBloodPressureSetting *cache = self.cacheDic[@(settingType)];
            LZCVBloodPressureSetting *temp = [[LZCVBloodPressureSetting alloc] init];
            temp.enable = !cache.enable;
            setting = temp;
            break;
        }
            
        case LZUISettingTypeCVTemp: {
            LZCVTemperatureSetting *cache = self.cacheDic[@(settingType)];
            LZCVTemperatureSetting *temp = [LZCVTemperatureSetting new];
            temp.enable = !cache.enable;
            setting = temp;
            break;
        }
            
        case LZUISettingTypeCVBPSwitch: {
            LZCVBloodPressureDisplaySwitchSetting *cache = self.cacheDic[@(settingType)];
            LZCVBloodPressureDisplaySwitchSetting *temp = [LZCVBloodPressureDisplaySwitchSetting new];
            temp.enable = !cache.enable;
            setting = temp;
            break;
        }
    
        case LZUISettingTypeCVTempSwitch: {
            LZCVTemperatureDisplaySetting *cache = self.cacheDic[@(settingType)];
            LZCVTemperatureDisplaySetting *temp = [LZCVTemperatureDisplaySetting new];
            temp.enable = !cache.enable;
            setting = temp;
            break;
//            0xab000005c5cdba8b 0500100000
        }
        case LZUISettingTypeCVClock: {
            LZCVClockSetting *temp = [LZCVClockSetting new];
            LZCVClockInfo *info = [LZCVClockInfo new];
            NSDate *date = [NSDate date];
            info.index = 1;
            info.hour = date.lz_hour;
            info.minute = date.lz_minute + 1;
            info.repeatTime = LZCVRepeatTimeAll;
            temp.events = @[info];
            setting = temp;
            break;
        }
        case LZUISettingTypeCVDial: {
            LZCVDialSetting *temp = [LZCVDialSetting new];
            temp.index = 2;
            setting = temp;
            break;
        }
        case LZUISettingTypeCVHRSwich: {
            LZCVHRSwitchSetting *cache = self.cacheDic[@(settingType)];
            LZCVHRSwitchSetting *temp = [LZCVHRSwitchSetting new];
            temp.enable = !cache.enable;
            setting = temp;
            break;
        }
    
        case LZUISettingTypeCVLongSit: {
            LZCVLongSitSetting *temp = [LZCVLongSitSetting new];
            temp.enable = YES;
            temp.repeatTime = LZCVRepeatTimeAll;

            temp.duration = 60;

            temp.startHour = 8;
            temp.endHour = 24;
            setting = temp;
            break;
        }
            
        case LZUISettingTypeCVTimeFormat: {
            LZCVTimeFormatSetting *cache = self.cacheDic[@(settingType)];
            LZCVTimeFormatSetting *temp = [LZCVTimeFormatSetting new];
            temp.timeFormat = !cache.timeFormat;
            setting = temp;
            break;
        }
            
        case LZUISettingTypeCVMsgRemind: {
            LZCVMsgReminderSwitchSetting *temp = [LZCVMsgReminderSwitchSetting new];
            temp.msgType = LZCVMsgTypeCall;
            temp.enable = YES;
            setting = temp;
            break;
        }
            
        case LZUISettingTypeCVEncourage: {
            LZCVEncourageSetting *temp = [LZCVEncourageSetting new];
            temp.targetType = LZCVTargetTypeStep;
            temp.value = 100;
            setting = temp;
            break;
        }
            
        case LZUISettingTypeCVRaise: {
            LZCVRaiseSetting *cache = self.cacheDic[@(settingType)];
            LZCVRaiseSetting *temp = [LZCVRaiseSetting new];
            temp.enable = !cache.enable;
            setting = temp;
            break;
        }
        case LZUISettingTypeCVSyncData: {
            LZCVSyncData *temp = [LZCVSyncData new];
            setting = temp;
            break;
        }
        case LZUISettingTypeCVLanguage: {
            LZCVLanguageSetting *cache = self.cacheDic[@(settingType)];
            LZCVLanguageSetting *temp = [LZCVLanguageSetting new];
            temp.languageType = cache.languageType == LZCVLanguageTypeSimpleChinese ? LZCVLanguageTypeEng : LZCVLanguageTypeSimpleChinese;
            setting = temp;
            break;
        }

        case LZUISettingTypeG3ReadCount: {
            LZGLReadRecord *temp = [LZGLReadRecord new];
            setting = temp;
            break;
        }
        case LZUISettingTypeG3Delete: {
            LZGLDeleteSetting *temp = [LZGLDeleteSetting new];
            temp.isAll = YES;
            setting = temp;
            break;
        }

            
        default:
            break;
    }
    if (setting) {
        self.cacheDic[@(settingType)] = setting;
        [self.device sendDataModel:setting completion:^(LZBluetoothErrorCode result, id  _Nullable response) {
            NSLog(@"sendDataModel %@ %@", @(result), response);
            if (result == LZBluetoothErrorCodeSuccess) {
                NSLog(@"发送成功");
            }
        }];
    }
}

- (void)getButtonClicked:(UIButton *)sender {
    LZUISettingType settingType = sender.tag;

    NSUInteger type = 0;
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
            
//            LZCVGetSettingTypeSedentaryReminderSetting = 2,         // 久坐提醒
//            LZCVGetSettingTypeEventReminderSetting = 4,             // 闹钟
//            LZCVGetSettingTypeTimeFormatSetting = 5,                // 24小时制
//            LZCVGetSettingTypeDialTypeSetting = 6,                  // 表盘设置
//            LZCVGetSettingTypeHeartRateSwitachSetting = 18,         // 24小时心率开关
//            LZCVGetSettingTypeBloodPressureDisplaySwitch = 22,      // 血压开关
//            LZCVGetSettingTypeTemperatureDisplaySwitch = 23,        // 温度开关

            
        case LZUISettingTypeCVBPSwitch:
            type = LZCVGetSettingTypeBloodPressureDisplaySwitch;
            break;
    
        case LZUISettingTypeCVTempSwitch:
            type = LZCVGetSettingTypeTemperatureDisplaySwitch;
            break;
        case LZUISettingTypeCVClock:
            type = LZCVGetSettingTypeEventReminderSetting;
            break;
        case LZUISettingTypeCVDial:
            type = LZCVGetSettingTypeDialTypeSetting;
            break;
        
        case LZUISettingTypeCVHRSwich:
            type = LZCVGetSettingTypeHeartRateSwitachSetting;
            break;
    
        case LZUISettingTypeCVLongSit:
            type = LZCVGetSettingTypeSedentaryReminderSetting;
            break;
            
        case LZUISettingTypeCVTimeFormat:
            type = LZCVGetSettingTypeTimeFormatSetting;
            break;
        case LZUISettingTypeCVRaise:
            type = LZCVGetSettingTypeRaiseSwitch;
            break;
        case LZUISettingTypeCVLanguage:
            type = LZCVGetSettingTypeLanguage;
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
            
//            LZUISettingTypeCVBP = 0x0901,  // 实时血压
//            LZUISettingTypeCVBPSwitch = 0x0902, // 血压显示
//            LZUISettingTypeCVTemp = 0x0903,  // 实时温度
//            LZUISettingTypeCVTempSwitch = 0x0904,  // 温度显示
//            LZUISettingTypeCVClock = 0x0905,  // 闹钟
//            LZUISettingTypeCVDial = 0x0906,  // 表盘
//            LZUISettingTypeCVEncourage = 0x0907,  // 鼓励目标
//            LZUISettingTypeCVHRSwich = 0x0908,  // 心率开关
//            LZUISettingTypeCVLanguage = 0x0909,  // 语言
//            LZUISettingTypeCVLongSit = 0x090a,  // 久坐
//            LZUISettingTypeCVMsgRemind = 0x090b,  // 消息提醒开关
//            LZUISettingTypeCVRaise = 0x090c,  // 抬腕亮屏
//            LZUISettingTypeCVSyncData = 0x090d,  // 同步数据
//            LZUISettingTypeCVTimeFormat = 0x090e,  // 时间格式
//            LZUISettingTypeCVUserInfo = 0x0910,  // 同步用户信息
        case LZUISettingTypeCVBP:
            return @"实时血压(只能设置)";
        case LZUISettingTypeCVBPSwitch:
            return @"血压显示";
        case LZUISettingTypeCVTemp:
            return @"温度(只能设置)";
        case LZUISettingTypeCVTempSwitch:
            return @"温度显示";
        case LZUISettingTypeCVClock:
            return @"闹钟";
        case LZUISettingTypeCVDial:
            return @"表盘";
        case LZUISettingTypeCVEncourage:
            return @"鼓励目标";
        case LZUISettingTypeCVHRSwich:
            return @"心率开关";
        case LZUISettingTypeCVLanguage:
            return @"语言";
        case LZUISettingTypeCVLongSit:
            return @"久坐";
        case LZUISettingTypeCVMsgRemind:
            return @"消息提醒开关(只能设置)";
        case LZUISettingTypeCVRaise:
            return @"抬腕";
        case LZUISettingTypeCVSyncData:
            return @"同步数据(只能设置)";
        case LZUISettingTypeCVTimeFormat:
            return @"时间格式";
        case LZUISettingTypeCVUserInfo:
            return @"用户信息(只能设置)";

        case LZUISettingTypeG3ReadCount:
            return @"获取历史数据";
        case LZUISettingTypeG3Delete:
            return @"删除历史数据";
            
        default:
            break;
    }
    return @"";
    
}


@end
