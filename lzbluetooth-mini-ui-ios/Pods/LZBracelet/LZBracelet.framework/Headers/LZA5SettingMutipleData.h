//
//  LZA5SettingMutipleData.h
//  LZBluetooth
//
//  Created by tanjian on 2021/11/12.
//




#import <LZBracelet/LZA5SettingData.h>
#import <LZBluetooth/LZMeasurementDataProtocol.h>


NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, LZSettingTag) {

        /** 温度  value 0-摄氏度 1-华氏度 */
    LZSettingTagTemperature = 0x01,
        /** 震动强度 value 0-低 1-中 2-高 */
    LZSettingTagVibration = 0x02,
        /** 亮度  value 值范围：0<  n(整数)< 11，比如5表示亮度50% */
    LZSettingTagBrightness = 0x03,
        /** 表盘页面右划显示页面设置 */
    LZSettingTagRightSwipeDisplay = 0x04,
        /** 距离/体重/身高单位设置 */
    LZSettingTagDistanceWeightHeightUnit = 0x05,
    LZSettingTagDistanceUint = 0x06,
        /** 体重单位设置 */
    LZSettingTagWeightUint = 0x07,
        /** 高度单位设置 */
    LZSettingTagHeightUint = 0x08,
        /** 星期开始日设置 */
    LZSettingTagWeekFirstDay = 0x09,
        /** 表盘显示设置 */
    LZSettingTagDialDisplay = 0x0a,
        /** 时间设置 */
    LZSettingTagTime = 0x0b,
        /** 浅睡眠唤醒设置 */
    LZSettingTagLightSleepAwake = 0x0c,
        /** 走路步长设置 */
    LZSettingTagWalkStepLength = 0x0d,
        /** 跑步步长设置 */
    LZSettingTagRunStepLength = 0x0e,
        /** 运动主目标 指定三个目标中某个目标为主要目标。value 0：无主目标 1：步数；2：距离；3：卡路里 */
    LZSettingTagSportMainTarget = 0x0f,
        /** 运动步数目标 */
    LZSettingTagSportStepTarget = 0x10,
        /** 运动距离目标（米） */
    LZSettingTagSportDistanceTarget = 0x11,
        /** 运动卡路里 0.1Kcal (精度) */
    LZSettingTagSportCaloriesTarget = 0x12,
        /** 夜间模式（睡眠提醒） */
    LZSettingTagNightMode = 0x13,
        /** 勿扰模式 */
    LZSettingTagNoDisturb = 0x14,
        /** 心率预警开关 （LS437不支持通过FB命令设置，支持通过66命令获取）*/
    LZSettingTagHeartRateWarning = 0x15,
        /** 久坐提醒 （LS437不支持通过FB命令设置，支持通过66命令获取） */
    LZSettingTagSedentaryReminder = 0x16,
        /** 语言设置 （LS437不支持通过FB命令设置，支持通过66命令获取） */
    LZSettingTagLanguage = 0x17,
        /** 只能心率开关 （LS437支持通过0x76命令设置，支持通过66命令获取） */
    LZSettingTagSmartHeartRate = 0x18,
        /** 用户信息（LS437不支持通过FB命令设置，支持通过66命令获取） */
    LZSettingTagUserInfo = 0x19,
        /** 连续血氧测试开关 0x00：关闭 0x01：允许 0x02：血氧点测开启 0x03：血氧5分钟检测模式 */
    LZSettingTagBloodOxygen = 0x20,
        /** 提醒开关 */
    LZSettingTagRemind = 0x21,
    LZSettingTagMusic = 0x22,
    LZSettingTagDrinkRemind = 0x23,
    LZSettingTagMeditationRemind = 0x24,
        /** 24小时心率检测开关 */
    LZSettingTagHeartRateEnable = 0x25,
        /** 目标提醒开关 */
    LZSettingTagTargetRemind = 0x26,
    LZSettingTagSleepRespiratoryQuality = 0x27,
        // 女性健康  参考 type = FemaleHealth
    LZSettingTagFemaleHealth = 0x28,
        /** 经期提醒开关 参考 type = PeriodReminder */
    LZSettingTagPeriodReminder = 0x29,
        /** 易孕期提醒开关 参考 type = PeriodReminder */
    LZSettingTagPeriod2Reminder = 0x2a,
        /** 运动目标 */
    LZSettingTagSportTarget = 0x2b,
        /** 锻炼分钟数目标 */
    LZSettingTagExerciseMinuteTarget = 0x2c,
        /** 活跃小时目标设置 */
    LZSettingTagActiveHourTarget = 0x2d,
        /** 自定义屏幕 */
    LZSettingTagCustomPage = 0x30,

        /** 一级界面排序 */
    LZSettingTagMainPage = 0x31,

        /** 删除 */
    LZSettingTagDeleteDial = 0x34,

        /** 睡眠计划 */
    LZSettingTagSleepPlan = 0x35,

        /** 运动时长 */
    LZSettingTagSportTimeTarget = 0x36,
        /** 运动心率 */
    LZSettingTagSportHrWarning = 0x37,
        /** 时间显示格式 */
    LZSettingTagTimeFormat = 0x38,
        /** 入睡提醒 */
    LZSettingTagSleepRemind = 0x39,
        /** 心率监测周期和心率区间 */
    LZSettingTagHeartRateDetection = 0x3a,

};

/// 设置项的基础类，一般只有一个参数的可以使用这个类
@interface LZMSetting : NSObject

@property (nonatomic, assign) LZSettingTag tag;
@property (nonatomic, assign) UInt32 len;
@property (nonatomic, assign) int value;

@end


///夜间模式
@interface LZMNightModeInfo : LZMSetting
@property (nonatomic, assign) BOOL enableImmediately;
@property (nonatomic, assign) BOOL enable;
@property (nonatomic, assign) UInt32 startHour;
@property (nonatomic, assign) UInt32 startMinute;
@property (nonatomic, assign) UInt32 endHour;
@property (nonatomic, assign) UInt32 endMinute;
@end

/// 时间信息
@interface LZMTimeInfo : LZMSetting

@property (nonatomic, assign) UInt32 utc;
@property (nonatomic, assign) UInt32 timezone;

@end


/// 心率检测信息
@interface LZMHeartRateWarningInfo : LZMSetting
/// 上限
@property (nonatomic, assign) UInt32 max;
/// 下限
@property (nonatomic, assign) UInt32 min;
/// 开关
@property (nonatomic, assign) BOOL enable;
/// 下限开关 （460）
@property (nonatomic, assign) BOOL minEnable;

@end


/// 表盘信息
@interface LZMDialInfo : LZMSetting

/// 表盘位置
@property (nonatomic, assign) UInt32 index;
/// 表盘类型
@property (nonatomic, assign) UInt32 dialType;

@end


/// 女性健康
@interface LZMFemaleHealth : LZMSetting
/** 经期长度 */
@property (nonatomic, assign) UInt32 length;
    /** 经期周期 */
@property (nonatomic, assign) UInt32 period;
@property (nonatomic, assign) UInt32 lastBeginYear;
@property (nonatomic, assign) UInt32 lastBeginMonth;
@property (nonatomic, assign) UInt32 lastBeginDay;
@property (nonatomic, assign) UInt32 lastEndYear;
@property (nonatomic, assign) UInt32 lastEndMonth;
@property (nonatomic, assign) UInt32 lastEndDay;

    /** 开关 */
@property (nonatomic, assign) UInt32 enable;

@end

/**
 * 经期提醒开关或者易孕期提醒开关
 */
@interface LZMPeriodReminder : LZMSetting
/** 开关 */
@property (nonatomic, assign) BOOL enable;
    /** 提前提醒天数 */
@property (nonatomic, assign) UInt32 dayOfWarning;
    /** 提醒时间小时 */
@property (nonatomic, assign) UInt32 hour;
    /** 提醒时间分钟 */
@property (nonatomic, assign) UInt32 minute;

@end

/// 睡眠计划
@interface LZMSleepPlan : LZMSetting

/** 计划入睡时间 */
@property (nonatomic, assign) UInt32 sleepTimeHour;
@property (nonatomic, assign) UInt32 sleepTimeMinute;

    /** 计划起床时间 */
@property (nonatomic, assign) UInt32 awakeTimeHour;
@property (nonatomic, assign) UInt32 awakeTimeMinute;

    /** 计划睡眠时长 单位（min） */
@property (nonatomic, assign) UInt32 duration;

@end

@interface LZMsgReminderObj : NSObject

@property (nonatomic, assign) UInt32 reminderType;
@property (nonatomic, assign) BOOL enable;

@end

/// 提醒开关
@interface LZMMsgReminderList : LZMSetting
@property (nonatomic, strong) NSArray <LZMsgReminderObj *> *list;
@end

/// 久坐提醒 或者 喝水提醒
@interface LZMReminder : LZMSetting

@property (nonatomic, assign) BOOL enable;
@property (nonatomic, assign) UInt32 startHour;
@property (nonatomic, assign) UInt32 startMinute;
@property (nonatomic, assign) UInt32 endHour;
@property (nonatomic, assign) UInt32 endMinute;
@property (nonatomic, assign) UInt32 frequency;
@property (nonatomic, assign) LZA5RepeatTimeFlag repeatTime;
@property (nonatomic, assign) BOOL noDisturbEnable;
@property (nonatomic, assign) UInt32 noDisturbStartHour;
@property (nonatomic, assign) UInt32 noDisturbStartMinute;
@property (nonatomic, assign) UInt32 noDisturbEndHour;
@property (nonatomic, assign) UInt32 noDisturbEndMinute;

@end

/// 睡眠提醒
@interface LZMSleepReminder : LZMSetting

@property (nonatomic, assign) BOOL enable;
@property (nonatomic, assign) UInt32 hour;
@property (nonatomic, assign) UInt32 minute;
@property (nonatomic, assign) LZA5RepeatTimeFlag repeatTime;

@end

/// 心率预警
@interface LZMHeartRateDetection : LZMSetting

@property (nonatomic, assign) UInt32 duration;       // 心率监测周期（间隔）（分钟）代表实时心率监测模式
@property (nonatomic, assign) UInt32 level0;         // 心率区间阈值L0
@property (nonatomic, assign) UInt32 level1;         // 心率区间阈值L1
@property (nonatomic, assign) UInt32 level2;         // 心率区间阈值L2
@property (nonatomic, assign) UInt32 level3;         // 心率区间阈值L3
@property (nonatomic, assign) UInt32 level4;         // 心率区间阈值L4

@end

/// 页面
@interface LZMUIPage : LZMSetting

/// 当前设备的页面及排序
@property (nonatomic, strong) NSArray <NSNumber *> *pages;
/// 当前设备支持的一些页面
@property (nonatomic, strong) NSArray <NSNumber *> *supportPages;

@end


@interface LZMDialInfoObj : NSObject

@property (nonatomic, assign) UInt32 index;
@property (nonatomic, assign) UInt32 dialType;

@end


@interface LZMDeleteDialInfo : LZMSetting

@property (nonatomic, strong) NSArray <LZMDialInfoObj *> *list;

@end


@interface LZA5SettingMutipleData : LZA5SettingData <LZMeasurementDataProtocol>

@property (nonatomic, strong) NSArray <LZMSetting *> *settings;

- (void)parseData:(NSData *)data;

@end

NS_ASSUME_NONNULL_END
