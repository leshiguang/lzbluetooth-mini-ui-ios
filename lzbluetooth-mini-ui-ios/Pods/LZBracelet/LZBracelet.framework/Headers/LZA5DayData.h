//
//  LZA5DayData.h
//  LZBluetooth
//
//  Created by tanjian on 2020/10/22.
//  发送手环每天测量数据(0x51)



#import <LZBracelet/LZBraceletMeasurementData.h>

NS_ASSUME_NONNULL_BEGIN

/// 数据详情
@interface LZA5TimeContentData : NSObject
/// 步数
@property (nonatomic, assign) UInt32 step;
/// 时间戳
@property (nonatomic, assign) UInt32 utc;
/// 运动量
@property (nonatomic, assign) double examount;
/// 卡路里 （千卡）
@property (nonatomic, assign) double calories;
/// 运动时间 （460上为活动时长）分钟
@property (nonatomic, assign) UInt16 exerciseTime;
/// 距离 （米）
@property (nonatomic, assign) UInt16 distance;
/// 睡眠、运动等级
@property (nonatomic, assign) UInt8 status;
/// 电量百分比 （在HR6上不准，请勿使用）
@property (nonatomic, assign) NSInteger batteryPercentage;

/// 静息心率是否存在
@property (nonatomic, assign) BOOL isSilenceExist;

/// 静息心率（可能不存在）
@property (nonatomic, assign) UInt32 silenceHeartRate;

@end

/// 日常监测数据 可以根据measurementDataType判断数据类型（LZBraceletMeasurementDataTypeDay 总数据) (LZBraceletMeasurementDataTypeHour 小时数据）
@interface LZA5DayData : LZBraceletMeasurementData
/// 数据列表
@property (nonatomic, strong) NSArray <LZA5TimeContentData *> *contentDatas;

/// 数据类型 0:实时数据 1：小时数据
@property (nonatomic, assign) UInt32 type;

@end

NS_ASSUME_NONNULL_END
