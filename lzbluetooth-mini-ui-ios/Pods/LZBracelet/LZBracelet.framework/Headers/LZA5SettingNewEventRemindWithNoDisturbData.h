//
//  LZA5SettingNewEventRemindWithNoDisturbData.h
//  LZBluetooth
//
//  Created by tanjian on 2021/11/12.
//  4.4.45 APP push提醒设置(带勿扰设置)到蓝牙手环（0xFE）




#import <LZBracelet/LZA5SettingData.h>

NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM(NSUInteger, LZReminderType) {
    LZReminderTypeClock = 0,          // 闹钟
    LZReminderTypeDrink = 1,          // 喝水
    LZReminderTypeDinner = 2,         // 加餐
    LZReminderTypeSleep = 3,          // 睡觉
    LZReminderTypeSedentary = 4,      // 久坐提醒
    LZReminderTypeThinking = 5,       // 冥想提醒
    LZReminderTypeHeartRate = 6,      // 心率提醒
    LZReminderTypeTargetFinish = 7,   // 目标完成
};

@interface LZRemindData : NSObject

// 序号
  @property (nonatomic, assign) UInt32 index;

    // 开关
@property (nonatomic, assign) BOOL enable;

    // 提醒开始时间
@property (nonatomic, assign) UInt32 startHour;
@property (nonatomic, assign) UInt32 startMinute;

    // 提醒结束时间
@property (nonatomic, assign) UInt32 endHour;
@property (nonatomic, assign) UInt32 endMinute;

    // 0x00：定时 0x01：周期
@property (nonatomic, assign) UInt32 reminderMode;

    // 当提醒方式为定时的时候 需要设置提醒时间
@property (nonatomic, assign) UInt32 reminderHour;
@property (nonatomic, assign) UInt32 reminderMinute;

    // 周期 每间隔多少分钟提醒一次
@property (nonatomic, assign) UInt32 frequency;

    // 参考 RepeatTime
@property (nonatomic, assign) UInt32 repeatTime;
    // 参考 VibrationType
@property (nonatomic, assign) UInt32 vibrationType;
    // 表示提醒持续总时长，最大值60s
@property (nonatomic, assign) UInt32 vibrationTime;
    // 共分10 级。0~9
@property (nonatomic, assign) UInt32 vibrationLevel1;
    // 共分10 级。0~9当震动方式为持续震动时，该字段无效，但需留位
@property (nonatomic, assign) UInt32 vibrationLevel2;

    // 勿扰开关
@property (nonatomic, assign) BOOL noDisturbEnable;

    // 勿扰开始时间
@property (nonatomic, assign) UInt32 noDisturbStartHour;
@property (nonatomic, assign) UInt32 noDisturbStartMinute;

    // 勿扰结束时间
@property (nonatomic, assign) UInt32 noDisturbEndHour;
@property (nonatomic, assign) UInt32 noDisturbEndMinute;

@end

@interface LZA5SettingNewEventRemindWithNoDisturbData : LZA5SettingData

@property (nonatomic, assign) BOOL enable;

@property (nonatomic, assign) LZReminderType reminderType;

@property (nonatomic, strong) NSArray <LZRemindData *> *list;

@end

NS_ASSUME_NONNULL_END
