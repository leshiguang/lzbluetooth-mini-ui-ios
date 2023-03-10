//
//  LZCVCommonDefine.h
//  LZCavosmart
//
//  Created by tanjian on 2022/8/16.
//

#import <Foundation/Foundation.h>




/// 运动模式
typedef NS_ENUM(NSUInteger, LZCVSportMode) {
    /// 户外跑步
    LZCVSportModeRun        = 0x01,
    /// 健走
    LZCVSportModeWalk       = 0x02,
    /// 骑行
    LZCVSportModeCycling    = 0x03,
    /// 室内跑
    LZCVSportModeRunInDoor  = 0x07,
    /// 自由训练
    LZCVSportModeFreeSport  = 0x19,
    /// 平板支撑
    LZCVSportModePlank      = 0x65,
};

/// 获取设置类型
typedef NS_ENUM(NSUInteger, LZCVGetSettingType) {
    /// 久坐提醒
    LZCVGetSettingTypeSedentaryReminderSetting = 2,
    /// 闹钟
    LZCVGetSettingTypeEventReminderSetting = 4,
    /// 24小时制
    LZCVGetSettingTypeTimeFormatSetting = 5,
    /// 表盘设置
    LZCVGetSettingTypeDialTypeSetting = 6,
    /// 24小时心率开关
    LZCVGetSettingTypeHeartRateSwitachSetting = 18,
    /// 血压开关
    LZCVGetSettingTypeBloodPressureDisplaySwitch = 22,
    /// 温度开关
    LZCVGetSettingTypeTemperatureDisplaySwitch = 23,
    /// 转腕开关
    LZCVGetSettingTypeRaiseSwitch = 24,
    /// 语言
    LZCVGetSettingTypeLanguage = 25,
};

typedef NS_ENUM(NSUInteger, LZCVDataType) {
    /// 心率数据 参考 LZCVHeartRate
    LZCVDataTypeHR              = 0x0510,
    /// 睡眠数据 参考 LZCVSleep
    LZCVDataTypeSleep           = 0x0503,
    /// 运动数据 参考 LZCVSport
    LZCVDataTypeSport           = 0x0516,
    /// 实时数据 参考 LZCVStep
    LZCVDataTypeStep            = 0x050c,
    /// 历史步数数据 参考 LZCVStepHistory
    LZCVDataTypeStepHistory     = 0x0502,
    /// 充电状态数据 参考 LZCVChargingData
    LZCVDataTypeCharging        = 0x0406,
    /// 血压数据 参考 LZCVBPData
    LZCVDataTypeBP              = 0x0513,
};


/// 闹钟重复时间
typedef NS_ENUM(NSUInteger, LZCVRepeatTime) {
    /// 不重复
    LZCVRepeatTimeNone = 0,
    /// 星期一
    LZCVRepeatTimeMon = 1 << 0,
    /// 星期二
    LZCVRepeatTimeTue = 1 << 1,
    /// 星期三
    LZCVRepeatTimeWed = 1 << 2,
    /// 星期四
    LZCVRepeatTimeThu = 1 << 3,
    /// 星期五
    LZCVRepeatTimeFri = 1 << 4,
    /// 星期六
    LZCVRepeatTimeSat = 1 << 5,
    /// 星期日
    LZCVRepeatTimeSun = 1 << 6,
    
    /// 工作日
    LZCVRepeatTimeWorkDay   = 0b0011111,
    /// 周末
    LZCVRepeatTimeWeekend   = 0b1100000,
    /// 每天
    LZCVRepeatTimeAll       = 0b1111111,
};



