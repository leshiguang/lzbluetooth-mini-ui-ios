//
//  LZA5CommonDefine.h
//  LZBluetooth
//
//  Created by tanjian on 2020/10/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, LZDeviceSettingTypeBracelet) {
    /// 消息提醒
    LZDeviceSettingTypeMsgReminder = 0xb6,
    /// 自动识别
    LZDeviceSettingTypeAutoRecognitionSport = 0xA2,
    /// 闹钟
    LZDeviceSettingTypeAlarmClock = 0x69,
    /// 表盘
    LZDeviceSettingTypeDial = 0xa1,
    /// 佩戴方式
    LZDeviceSettingTypeScreenDirection = 0x7d,
    /// 事件提醒（带标签的闹钟提醒）
    LZDeviceSettingTypeEventReminder = 0xa3,
    /// 自定义运动心率区间提醒（心率预警）
    LZDeviceSettingTypeCustomSportHrReminder = 0xa8,
    /// 心率区间
    LZDeviceSettingTypeHrSection = 0x74,
    /// 智能心率检测开关设置
    LZDeviceSettingTypeSmartHrDetection = 0x76,
    /// 心率开关
    LZDeviceSettingTypeHrDetection = 0x6d,
    /// 语言
    LZDeviceSettingTypeLanguage = 0xaa,
    /// 久坐提醒
    LZDeviceSettingTypeSedentaryRemainder = 0x6e,
    /// 防丢
    LZDeviceSettingTypeLost = 0x6f,
    /// 夜间模式
    LZDeviceSettingTypeNightMode = 0x77,
    /// 自定义屏幕
    LZDeviceSettingTypeCustomScreen = 0x7e,
    /// 勿扰模式
    LZDeviceSettingTypeNoDisturb = 0xb3,
    /// 运动控制
    LZDeviceSettingTypeSportControl = 0xaf,
    /// 运动心率区间
    LZDeviceSettingTypeSportHrSection = 0x71,
    /// 运动设置（配速与距离设置）
    LZDeviceSettingTypePaceAndDistance = 0xab,
    /// 步数目标
    LZDeviceSettingTypeStepEncourage = 0x70,
    /// 游泳
    LZDeviceSettingTypeSwiming = 0xac,
    /// 目标设置
    LZDeviceSettingTypeTargetEncourage = 0xa5,
    /// 时间模式
    LZDeviceSettingTypeTimeMode = 0x79,
    /// 佩戴方式
    LZDeviceSettingTypeWristHabit = 0x7a,
    /// 天气
    LZDeviceSettingTypeWeather = 0xa6,
    /// 单位
    LZDeviceSettingTypeUnit = 0x78,

    /// 实时心率
    LZDeviceSettingTypeRealtimeHR = 0xfff9,
};

typedef NS_ENUM(NSUInteger, LZBraceletMeasurementDataType) {
    /// 每天测量数据 参考 LZA5DayData
    LZBraceletMeasurementDataTypeDay = 0x51,
    /// 睡眠压缩数据 参考 LZA5SleepData
    LZBraceletMeasurementDataTypeSleep = 0x52,
    /// 心率数据 参考 LZA5HeartRateData
    LZBraceletMeasurementDataTypeHeartRate = 0x53,
    /// 每小时数据 参考 LZA5DayData
    LZBraceletMeasurementDataTypeHour = 0x57,
    /// 跑步状态数据 参考 LZA5RunStateData
    LZBraceletMeasurementDataTypeRunState = 0x72,
    /// 跑步心率数据 参考 LZA5HeartRateData
    /// 跑步心率
//    LZBraceletMeasurementDataTypeRunHeartRate = 0x73,
    /// 心率统计 参考 LZA5HeatrateSectionData
    LZBraceletMeasurementDataTypeHrSection = 0x75,
    /// 跑步卡路里数据 参考 LZA5SportCaloriesData
    LZBraceletMeasurementDataTypeRunCalories = 0x7f,
    /// 运动模式状态 参考 LZA5SportStatusData
    LZBraceletMeasurementDataTypeSportStatus = 0xe1,
    /// 运动报告 参考 LZA5SportReportData
    LZBraceletMeasurementDataTypeSportReport = 0xe2,
    /// 运动配速 参考 LZA5SportPaceData
    LZBraceletMeasurementDataTypeSportPace = 0xe4,
    /// 运动心率 参考 LZA5HeartRateData
    LZBraceletMeasurementDataTypeSportHeartRate = 0xe5,
    /// 运动卡路里 参考 LZA5SportCaloriesData
    LZBraceletMeasurementDataTypeSportCalories = 0xe6,
    /// 实时心率 参考 LZA5HeartRateData
    LZBraceletMeasurementDataTypeRealTimeHR = 0xfff9,

    /// 456 add
    /// 闹钟开关数据
    LZBraceletMeasurementDataTypeClockSwitch = 0xff01,
    /// 闹钟提醒
    LZBraceletMeasurementDataTypeEventReminder = 0xff02,
    /// 睡眠报告
    LZBraceletMeasurementDataTypeEventSleepreport = 0xff82,
    /// 血氧数据
    LZBraceletMeasurementDataTypeBloodOxygen = 0xff03,
    /// 结束符
    LZBraceletMeasurementDataTypeFinish = 0xff04,
    /// 设置数据
    LZBraceletMeasurementDataTypeMutipleSetting = 0xff05,
    /// 静息心率 LZA5RestingHeartRateData
    LZBraceletMeasurementDataTypeRestingHeartRateData = 0xff06,
};

/// 运动模式类型
typedef NS_ENUM(NSUInteger, LZA5SportMode) {
    /// 未指定
    LZA5SportModeUnknow = 0,
    /// 跑步
    LZA5SportModeRun = 0x01,
    /// 健走
    LZA5SportModeWalk = 0x02,
    /// 骑行
    LZA5SportModeCycling = 0x03,
    /// 游泳
    LZA5SportModeSwim = 0x04,
    /// 力量训练 （旧称 健身）
    LZA5SportModeKeepfit = 0x05,
    /// 新版跑步
    LZA5SportModeNewRun = 0x06,
    /// 室内跑（旧称 跑步机）
    LZA5SportModeRunInDoor = 0x07,
    /// 椭圆机
    LZA5SportModeElliptical = 0x08,
    /// 有氧运动
    LZA5SportModeAerobicWorkout = 0x09,
    /// 篮球
    LZA5SportModeBasketball = 0x0a,
    /// 足球
    LZA5SportModeFootball = 0x0b,
    /// 羽毛球
    LZA5SportModeBadminton = 0x0c,
    /// 排球
    LZA5SportModeVolleyball = 0x0d,
    /// 乒乓球
    LZA5SportModeTableTennis = 0x0e,
    /// 瑜伽
    LZA5SportModeYoga = 0x0f,
    /// 电竞
    LZA5SportModeGame = 0x10,
    /// 有氧能力测试12分钟跑
    LZA5SportMode12MinutesRun = 0x11,
    /// 有氧能力测试6分钟走
    LZA5SportMode6MinutesWalk = 0x12,
    /// 健身舞
    LZA5SportModeGymDance = 0x13,
    /// 太极拳
    LZA5SportModeTaiji = 0x14,
    
    // m6新增
    LZA5SportModecricket = 0x15,             // 板球
    LZA5SportModerowingMachine = 0x16,       // 划船机
    LZA5SportModespinning = 0x17,            // 动感单车
    LZA5SportModecyclingInDoor = 0x18,       // 室内骑行
    LZA5SportModefreeSport = 0x19,           // 自由运动
    LZA5SportModeskippingRope = 0x1b,        // 跳绳
    LZA5SportModemountaineering = 0x1c,      // 登山
    LZA5SportModehockey = 0x1d,              // 曲棍球
    LZA5SportModetennis = 0x1e,              // 网球
    LZA5SportModehilt = 0x1f,                // HILT
    LZA5SportModewalkIndoor = 0x20,          // 室内步行
    LZA5SportModeridingHorse = 0x21,         // 骑马
    LZA5SportModeshuttlecock = 0x22,         // 毽球
    LZA5SportModeboxing = 0x23,              // 拳击
    LZA5SportModesuvs = 0x24,                // 越野跑
    LZA5SportModeski = 0x25,                 // 滑雪
    LZA5SportModegymnastics = 0x26,          // 体操
    LZA5SportModeicehockey = 0x27,           // 冰球
    LZA5SportModetaekwondo = 0x28,           // 跆拳道
    LZA5SportModewalkingMachine = 0x29,      // 漫步机
    LZA5SportModeonFoot = 0x2a,              // 徒步
    LZA5SportModedance = 0x2b,               // 跳舞
    LZA5SportModeAthletics = 0x2c,           // 田径
    LZA5SportModeLumbarAbdomenTraining = 0x2d,        // 腰腹训练
    LZA5SportModekarate = 0x2e,              // 空手道
    LZA5SportModeoverallRelaxation = 0x2f,   // 整体放松
    LZA5SportModeCrossTraining = 0x30,       // 交叉训练
    LZA5SportModePilates = 0x31,             // 普拉提
    LZA5SportModecrossMatch = 0x32,          // 交叉配合
    LZA5SportModeFunctionalTraining = 0x33,  // 功能性训练
    LZA5SportModePhysicalRraining = 0x34,    // 体能训练
    LZA5SportModearchery = 0x35,             // 射箭
    LZA5SportModeflexibility = 0x36,         // 柔韧度
    LZA5SportModeMixedAerobic = 0x37,        // 混合有氧
    LZA5SportModeLatinDance = 0x38,          // 拉丁舞
    LZA5SportModestreetDance = 0x39,         // 街舞
    LZA5SportModefreeSparring = 0x3a,        // 自由搏击
    LZA5SportModeballet = 0x3b,              // 芭蕾舞
    LZA5SportModeAustralianRulesFootball = 0x3c,       // 澳式足球
    LZA5SportModeMartialArts = 0x3d,         // 武术
    LZA5SportModestairs = 0x3e,              // 爬楼
    LZA5SportModehandball = 0x3f,            // 手球
    LZA5SportModebaseball = 0x40,            // 棒球
    LZA5SportModebowlingBall = 0x41,         // 保龄球
    LZA5SportModesquash = 0x42,              // 壁球
    LZA5SportModecurling = 0x43,             // 冰壶
    LZA5SportModeHunting = 0x44,             // 打猎
    LZA5SportModesnowboarding = 0x45,        // 单板滑雪
    LZA5SportModeLeisureSports = 0x46,       // 休闲运动
    LZA5SportModeAmericanFootball = 0x47,    // 美式橄榄球
    LZA5SportModeTheKrankcycle = 0x48,       // 手摇车
    LZA5SportModefishing = 0x49,             // 钓鱼
    LZA5SportModefrisbee = 0x4a,             // 飞盘运动
    LZA5SportModerugby = 0x4b,               // 橄榄球
    LZA5SportModegolf = 0x4c,                // 高尔夫
    LZA5SportModestrength = 0x4d,            // 民族舞
    LZA5SportModeAlpineSkiing = 0x4e,        // 高山滑雪
    LZA5SportModeSnowSports = 0x4f,          // 雪上运动
    LZA5SportModeSoothingMeditationExercises = 0x50,    // 舒缓冥想类运动
    LZA5SportModeCoreTraining = 0x51,        // 核心训练
    LZA5SportModeskating = 0x52,             // 滑冰
    LZA5SportModeFitnessGame = 0x53,         // 健身游戏
    LZA5SportModeSettingUpExercise = 0x54,   // 健身操
    LZA5SportModegroupCallisthenics = 0x55,  // 团体操
    LZA5SportModeboxingCallisthenics = 0x56, // 搏击操
    LZA5SportModelacrosse = 0x57,            // 长曲棍球
    LZA5SportModerelaxedfoamedAxis = 0x58,   // 泡沫轴筋膜放松
    LZA5SportModewrestling = 0x59,           // 摔跤
    LZA5SportModefencing = 0x5a,             // 击剑
    LZA5SportModesoftball = 0x5b,            // 垒球
    LZA5SportModehorizontalBar = 0x5c,       // 单杠
    LZA5SportModeparallelBars = 0x5d,        // 双杠
    LZA5SportModerollerSkating = 0x5e,       // 轮滑
    LZA5SportModehulaHoop = 0x5f,            // 呼啦圈
    LZA5SportModedarts = 0x60,               // 飞镖
    LZA5SportModepeakBall = 0x61,            // 匹克球
    LZA5SportModesetUps = 0x62,              // 仰卧起坐
    LZA5SportModestepTraining = 0x63,        // 踏步训练
    LZA5SportModeswimmingInDoor = 0x64,      // 室内游泳
};

/// 获取设备信息列表
typedef NS_ENUM(NSUInteger, LZA5SettingInfoType) {
    /// 读取flash信息
    LZA5SettingInfoTypeFlash,
    /// 用户信息
    LZA5SettingInfoTypeUser,
    /// 闹钟设置信息
    LZA5SettingInfoTypeClock = 2,
    /// 来电提醒设置信息
    LZA5SettingInfoTypeReminderCall = 3,
    /// 心率检测设置信息
    LZA5SettingInfoTypeHrDetection = 4,
    /// 久不动提醒设置信息
    LZA5SettingInfoTypeSedentaryRemindder = 5,
    /// 防丢设置信息
    LZA5SettingInfoTypeLost = 6,
    /// 闹钟
    LZA5SettingInfoEventReminder = 0x0a,
    /// mutipleSetting
    LZA5SettingInfoTLVData = 0x0b,
    /// 闹钟开关通知
    LZA5SettingInfoClockSwitch = 0x0e,
    
};

/// 运动子模块
typedef NS_ENUM(NSUInteger, LZA5SportSubMode) {
    /// 手动进入
    LZA5SportSubModeManual = 0,
    /// 自动进入
    LZA5SportSubModeAutomatic = 1,
    /// 轨迹跑，有gps确认通知
    LZA5SportSubModeTrailrunHasGpsNotify = 2,
    /// 轨迹跑，无gps确认通知
    LZA5SportSubModeTrailrunNoGpsNotify = 3
};

/// 目标类型
typedef NS_ENUM(UInt8, LZA5TargetType) {
    /// 步数类型
    LZA5TargetTypeStep = 1,
    /// 卡路里
    LZA5TargetTypeCalories = 2,
    /// 路程
    LZA5TargetTypeDistance = 3,
    /// 运动量
    LZA5TargetTypeExerciseAmount = 4
};

/// 震动类型
typedef NS_ENUM(NSUInteger, LZA5VibrationType) {
    /// 持续震动
    LZA5VibrationTypeAlways = 0x00,
    /// 间歇震动，震动强度不变
    LZA5VibrationTypeInterval,
    /// 间歇震动，震动强度由小变大
    LZA5VibrationTypeIntervalS2L,
    /// 间歇震动，震动强度由大变小
    LZA5VibrationTypeIntervalL2S,
    /// 间歇震动，震动强度大小循环
    LZA5VibrationTypeIntervalLoop,
};

/// 重复时间
typedef NS_ENUM(UInt32, LZA5RepeatTimeFlag) {
    /// 无
    LZA5RepeatTimeFlagNon = 0,
    
    /// 星期一
    LZA5RepeatTimeFlagMon = 1 << 0,
    /// 星期二
    LZA5RepeatTimeFlagTue = 1 << 1,
    /// 星期三
    LZA5RepeatTimeFlagWed = 1 << 2,
    /// 星期四
    LZA5RepeatTimeFlagThu = 1 << 3,
    /// 星期五
    LZA5RepeatTimeFlagFri = 1 << 4,
    /// 星期六
    LZA5RepeatTimeFlagSat = 1 << 5,
    /// 星期日
    LZA5RepeatTimeFlagSun = 1 << 6,
    
    /// 全部
    LZA5RepeatTimeFlagAll = 0b1111111,
};

typedef NS_ENUM(NSUInteger, LZA5SyncDataType) {
    LZA5SyncDataTypeHeartRate = 0x01,               // 常规心率记录
    LZA5SyncDataTypeSleepDetail = 0x02,             // 睡眠明细记录
    LZA5SyncDataTypeSportPace = 0x03,               // 运动配速记录
    LZA5SyncDataTypeSportHeartRate = 0x04,          // 运动心率记录
    LZA5SyncDataTypeSportCalories = 0x05,           // 运动卡洛里记录
    LZA5SyncDataTypeSilenceHeartRate = 0x06,        // 静息心率记录
    LZA5SyncDataTypeGeneralStepDetail = 0x07,       // 常规计步明细记录
    LZA5SyncDataTypeDailyGeneralStepDetail = 0x08,  // 当天常规计步明细记录
    LZA5SyncDataTypeDailyGeneralHrDetail = 0x09,    // 当天常规心率明细记录电
    LZA5SyncDataTypeLastCharging = 0x0a,            // 最后一次充电记录
    LZA5SyncDataTypeBrightness = 0x0b,              // 当前亮度设定
    LZA5SyncDataTypeDialData = 0x0c,                // 表盘数据记录
    LZA5SyncDataTypeSportStepFreq = 0x0d,           // 运动步频记录
    LZA5SyncDataTypeSportPaceIn = 0x0e,             // 运动配速记录（英制）
    LZA5SyncDataTypeSectionHr = 0x0f,               // 区间心率数据

    LZA5SyncDataTypeDailyHour = 0x81,               // 每小时报告
    LZA5SyncDataTypeDailyDay = 0x82,                // 每天报告
    LZA5SyncDataTypeSportReport = 0x83,             // 运动报告
    LZA5SyncDataTypeBloodOxygen = 0x84,             // 血氧测量报告（点测）
    LZA5SyncDataTypeMeditation = 0x85,              // 冥想测量报告
    LZA5SyncDataTypeSleepQuality = 0x86,            // 睡眠质量报告
    LZA5SyncDataTypeDailyBloodOxygen = 0x87,        // 当天血氧测量报告
    LZA5SyncDataTypeStatusHeartRate = 0x88,         // 状态心率数据
    LZA5SyncDataTypeContinuousBloodOxygen = 0x89,   // 连续血氧报告
    LZA5SyncDataTypeSleepRespiratoryQuality = 0x8a, // 睡眠呼吸质量报告
    LZA5SyncDataTypePressureTest = 0x8b,            // 压力测试报告
    LZA5SyncDataTypeHearRateTest = 0x8c,            // 点测心率数据报告
    LZA5SyncDataTypeStand = 0x8d,                   // 站立数据

    LZA5SyncDataTypeBurialPointData = 0xf0,         // 埋点数据记录（参见0x5B）
    LZA5SyncDataTypeBurialPointDataStatistics = 0xf1,// 埋点数据统计（参见0x11）

    LZA5SyncDataTypeMeasureData = 0xfe,             // 全部测量数据
    LZA5SyncDataTypeAll = 0xff,                     // 以上所有数据
};

/// 获取设置类型
typedef NS_ENUM(NSUInteger, LZA5GetSettingType) {
    LZA5GetSettingTypeHeartRateWarningSetting = 0,        // 心率设置
    LZA5GetSettingTypeSleepBloodOxygenSetting = 1,        // 睡眠血氧检测
    LZA5GetSettingTypeSedentaryReminderSetting = 2,       // 久坐提醒
    LZA5GetSettingTypeSleepReminderSetting = 3,          // 睡眠提醒
    LZA5GetSettingTypeEventReminderSetting = 4,           // 闹钟
    LZA5GetSettingTypeTimeFormatSetting = 5,              // 24小时制
    LZA5GetSettingTypeDialTypeSetting = 6,                // 表盘管理
    LZA5GetSettingTypeCustomPagesSetting = 7,             // 自定义界面
    LZA5GetSettingTypeNightModeSetting = 8,               // 夜间模式
    LZA5GetSettingTypeRightSwipDisplaySetting = 9,        // 右滑显示屏幕
    LZA5GetSettingTypeSportHrWarnigSetting = 10,          // 运动心率预警
    LZA5GetSettingTypeTargetSetting = 11,                 // 目标设置
    LZA5GetSettingTypeMsgRemindSetting = 12,              // 消息提醒
    LZA5GetSettingTypeHeartRateSectionSetting = 13,       // 心率检测间隔
    LZA5GetSettingTypeFemaleHealthSetting = 14,           // 女性健康
    LZA5GetSettingTypePeriodReminderSetting = 15,         // 经期提醒
    LZA5GetSettingTypePeirod2ReminderSetting = 16,        // 易孕期提醒
    LZA5GetSettingTypeReminderSetting = 17,               // 消息提醒，包含睡眠提醒，久坐提醒 返回值对应 ReminderSetting
    LZA5GetSettingTypeHeartRateSwitachSetting = 18,       // 24小时心率开关
    LZA5GetSettingTypeDrinkReminderSetting = 19,          // 喝水提醒
    LZA5GetSettingTypeEncourageTargetSetting = 20,        // 目标提醒开关,
};


/// MemboHR2 屏幕类型
typedef NS_ENUM(NSUInteger, LZA5UIPageType) {
    /// 时间
    LZA5UIPageTypeTime = 0x00,
    /// 步数
    LZA5UIPageTypeStep = 0x01,
    /// 卡路里
    LZA5UIPageTypeCalorise = 0x02,
    /// 路程
    LZA5UIPageTypeDistance = 0x03,
    /// 心率
    LZA5UIPageTypeHr = 0x04,
    /// 跑步
    LZA5UIPageTypeRun = 0x05,
    /// 行走
    LZA5UIPageTypeWalk = 0x06,
    /// 自行车
    LZA5UIPageTypeCycling = 0x07,
    /// 游泳
    LZA5UIPageTypeSwimming = 0x08,
    /// 力量训练/健身
    LZA5UIPageTypeKeepfit = 0x09,
    /// 登山
    LZA5UIPageTypeMountainClimbing = 0x0a,
    /// 日常数据
    LZA5UIPageTypeDailyData = 0x0b,
    /// 秒表
    LZA5UIPageTypeStopwatch = 0x0c,
    /// 天气
    LZA5UIPageTypeWeather = 0x0d,
    /// 电量
    LZA5UIPageTypeBattery = 0x0e,
    /// 跑步机/室内跑
    LZA5UIPageTypeIndoorRun = 0x0f,
    /// 椭圆机
    LZA5UIPageTypeElliptical = 0x10,
    /// 有氧运动
    LZA5UIPageTypeAerobicWorkout = 0x11,
    /// 篮球
    LZA5UIPageTypeBasketball = 0x12,
    /// 足球
    LZA5UIPageTypeFootball = 0x13,
    /// 羽毛球
    LZA5UIPageTypeBadminton = 0x14,
    /// 排球
    LZA5UIPageTypeVolleyball = 0x15,
    /// 乒乓球
    LZA5UIPageTypeTableTennis = 0x16,
    /// 瑜伽
    LZA5UIPageTypeYoga = 0x17,
    /// 电竞
    LZA5UIPageTypeESport = 0x18,
    /// 12分钟跑
    LZA5UIPageType12MinutesRunMode = 0x19,
    /// 6分钟跑
    LZA5UIPageType6MinutesRunMode =0x1a,
    /// 阿里pay
    LZA5UIPageTypeAliPayMode =0x1b,
    /// 健身舞
    LZA5UIPageTypeGymDance = 0x1c,
    /// 太极
    LZA5UIPageTypeTaiji = 0x1d,
};


/// 这个 456B1 及更新款的手环手表
typedef NS_ENUM(NSUInteger, LZNewPageUIPageType) {
    /// 运动
    LZNewPageUIPageTypesport = 0,
    /// 血氧
    LZNewPageUIPageTypebloodO2 = 1,
    /// 心率
    LZNewPageUIPageTypeheartRate = 2,
    /// 运动记录
    LZNewPageUIPageTypesportReport = 3,
    /// 找手机
    LZNewPageUIPageTypefindPhone = 4,
    /// 闹钟
    LZNewPageUIPageTypealarm = 5,
    /// 拍照
    LZNewPageUIPageTypephoto = 6,
    /// 冥想（呼吸）
    LZNewPageUIPageTypethinking = 7,
    /// 睡眠记录
    LZNewPageUIPageTypesleepReport = 8,
    /// 天气
    LZNewPageUIPageTypeweather = 9,
    /// 秒表
    LZNewPageUIPageTypestopwatch = 10,
    /// 音乐
    LZNewPageUIPageTypemusic = 11,
    /// 倒计时
    LZNewPageUIPageTypecountdown = 12,
    /// 设置
    LZNewPageUIPageTypesetting = 13,
    /// LoT
    LZNewPageUIPageTyperealmeLink = 14,
    /// 消息
    LZNewPageUIPageTypemsg = 15,
    /// 工具
    LZNewPageUIPageTypetool = 16,
    /// 压力
    LZNewPageUIPageTypepreasure = 17,
    /// 女性健康
    LZNewPageUIPageTypefemaleHeathy = 18,
    /// 事件提醒
    LZNewPageUIPageTypeeventReminder = 19,
    /// 手电筒
    LZNewPageUIPageTypeflashlight = 20,
    /// 今日概览
    LZNewPageUIPageTypetodayOverview = 255,
};


NS_ASSUME_NONNULL_END
