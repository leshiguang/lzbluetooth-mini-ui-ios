//
//  LZA5HeartRateData.h
//  LZBluetooth
//
//  Created by tanjian on 2020/12/10.
//  发送手环心率数据(0x53 跑步心率 0x73 运动心率 0xe5)



#import <LZBracelet/LZBraceletMeasurementData.h>
#import <LZBluetooth/LZMergeDataManager.h>

NS_ASSUME_NONNULL_BEGIN


/// 心率传感器接触状态
typedef NS_ENUM(NSUInteger, LZSensorContactStatus) {
    /// 传感器触点功能不支持
    LZSensorContactStatusUnsupported,
    /// 非直接接触式的传感器触
    LZSensorContactStatusWithoutDetected,
    /// 支持直接接触式的传感器触点功能
    LZSensorContactStatusWithDetected
};

typedef NS_ENUM(NSUInteger, LZHeartRateType) {
    LZHeartRateTypeNormal = 0,
    LZHeartRateTypeRealTime = 1,
    LZHeartRateTypeSport = 2,
};

/// 心率，measurementDataType 有三种类型 （LZBraceletMeasurementDataTypeHeartRate、LZBraceletMeasurementDataTypeSportHeartRate、LZBraceletMeasurementDataTypeRealTimeHR）

@interface LZA5HeartRateData : LZBraceletMeasurementData <LZMergeable>
/// 运动模式
@property (nonatomic, assign) LZA5SportMode sportMode;
/// 进入模式
@property (nonatomic, assign) LZA5SportSubMode subMode;
/// 时间戳
@property (nonatomic, assign) UInt32 utc;
/// 每笔心率间隔 (s)
@property (nonatomic, assign) UInt32 utcOffset;
/// 手环中 数据剩余条数
@property (nonatomic, assign) UInt16 reside;
/// 心率数据  间隔时间为 utcOffset
@property (nonatomic, strong) NSArray <NSNumber *> *heartRates;
/// 原始数据
@property (nonatomic, strong) NSData *srcData;
/// 心率传感器接触状态 （实时心率才有这个）
@property (nonatomic, assign) LZSensorContactStatus status;


@property (nonatomic, assign) LZHeartRateType type;

@end

NS_ASSUME_NONNULL_END
