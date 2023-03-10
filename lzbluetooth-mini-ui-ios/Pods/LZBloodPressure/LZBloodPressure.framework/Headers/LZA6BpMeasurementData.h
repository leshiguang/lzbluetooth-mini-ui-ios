//
//  LZA6BpMeasurementData.h
//  LZBluetooth
//
//  Created by tanjian on 2020/12/8.
//



#import <LZBloodPressure/LZBPData.h>
#import <LZBloodPressure/LZBPCommonDefine.h>
#import <LZBluetooth/LZMeasurementDataProtocol.h>



NS_ASSUME_NONNULL_BEGIN

typedef NS_OPTIONS(UInt32, LZA6BloodPressureFlag) {
    /// 单位标志位
    LZA6BloodPressureFlagUnit        = 1 << 0,
    /// 数据包中包含心率
    LZA6BloodPressureFlagPulserate      = 1 << 1,
    /// 数据中是否包含用户信息
    LZA6BloodPressureFlagUserid         = 1 << 2,
    /// 用户信息是否有utc
    LZA6BloodPressureFlagUtc            = 1 << 3,
//    LZA6BloodPressureFlagTimezone       = 1 << 4,
//    LZA6BloodPressureFlagTimestamp      = 1 << 5,
    LZA6BloodPressureFlagIrregularPulseDetection = 1 << 6,
};

@interface LZA6BpMeasurementData : LZBPData <LZMeasurementDataProtocol>

/// 传输完本数据包后设备中的剩余数据条目。
@property (nonatomic, assign) UInt16 remainingCount;
/// 标致位
@property (nonatomic, assign) LZA6BloodPressureFlag flags;
/// 单位
@property (nonatomic, assign) LZA6BloodPressureUnit unit;

/// 高压数据，以mmHg上传，根据unit flag的定义进行显示
@property (nonatomic, assign) UInt16 systolic;

/// 低压数据，以mmHg上传，根据unit flag的定义进行显示
@property (nonatomic, assign) UInt16 diastolic;

/// 平均值数据，以mmHg上传，根据unit flag的定义进行显示
@property (nonatomic, assign) UInt16 meanPressure;

/// 脉搏数据
@property (nonatomic, assign) UInt16 pulseRate;

/// 用户编号1表示用户1  2表示用户2
@property (nonatomic, assign) UInt16 userID;

/// 时间戳
@property (nonatomic, assign) UInt32 utc;

/// 0:未检测到心率不齐 1:检测到心率不齐
@property (nonatomic, assign) BOOL irregularPulseDetection;

@end

NS_ASSUME_NONNULL_END
