//
//  LZA6MeasurementData.h
//  LZBluetooth
//
//  Created by tanjian on 2020/10/12.
//

#import <Foundation/Foundation.h>


#import <LZBluetooth/LZMeasurementDataProtocol.h>
#import <LZScale/LZA6Data.h>


NS_ASSUME_NONNULL_BEGIN

typedef NS_OPTIONS(UInt32, LZA6MeasurementDataFlag) {
    /// 单位
    LZA6MeasurementDataFlagUnitKg = 0,
    LZA6MeasurementDataFlagUnitLb = 1,
    LZA6MeasurementDataFlagUnitSt = 2,
    LZA6MeasurementDataFlagUnitJin = 3,
    
    LZA6MeasurementDataFlagUsernumber = 1 << 2,
    LZA6MeasurementDataFlagUTC = 1 << 3,
    LZA6MeasurementDataFlagTimezone = 1 << 4,
    LZA6MeasurementDataFlagTimestamp = 1 << 5,
    LZA6MeasurementDataFlagBMI = 1 << 6,
    LZA6MeasurementDataFlagBodyFatPercentage = 1 << 7,
    LZA6MeasurementDataFlagBasalMetabolism = 1 << 8,
    LZA6MeasurementDataFlagMusclePercentage = 1 << 9,
    LZA6MeasurementDataFlagMuscleMass = 1 << 10,
    LZA6MeasurementDataFlagFatFreeMass = 1 << 11,
    LZA6MeasurementDataFlagSoftLeanMass = 1 << 12,
    LZA6MeasurementDataFlagBodyWaterMass = 1 << 13,
    LZA6MeasurementDataFlagImpedance = 1 << 14,
    LZA6MeasurementDataFlagDataType = 1 << 15,
    LZA6MeasurementDataFlagHeartRate = 1 << 16,
    LZA6MeasurementDataFlagBabyWeight = 1 << 17,
};

@interface LZA6MeasurementData : LZA6Data <LZMeasurementDataProtocol>

/// 剩余数据条目
@property (nonatomic, assign) UInt16 remainingCount;

/// 信息数据块的有无
@property (nonatomic, assign) LZA6MeasurementDataFlag flag;

/// 体重（单位为 kg） 数据以Kg单位上传，以C1、C2，C3,C4单位转换后数值显示
@property (nonatomic, assign) double weightValue;

@property (nonatomic, assign) UInt8 userNumber;
@property (nonatomic, assign) UInt32 utc;
@property (nonatomic, assign) UInt8 timezone;

/// 是个字符串，len = 7
@property (nonatomic, strong) NSData *timestamp;

/// 单位 0.1
@property (nonatomic, assign) UInt16 bmiValue;
/// Body Fat Percentage（单位：0.1）
@property (nonatomic, assign) UInt16 bodyFatPercentageValue;
/// Basal Metabolism
@property (nonatomic, assign) UInt16 BasalMetabolismValue;
/// Muscle Percentage（单位：0.1）
@property (nonatomic, assign) UInt16 musclePercentage;
/// Muscle Mass（单位为 0.010kg）
@property (nonatomic, assign) UInt16 muscleMassValue;
/// Fat Free Mass（单位为 0.010kg）
@property (nonatomic, assign) UInt16 fatFreeMassValue;
/// Soft Lean Mass（单位为 0.010kg）
@property (nonatomic, assign) UInt16 softLeanMassValue;
/// Body Water Mass（单位为 0.010kg）
@property (nonatomic, assign) UInt16 bodyWaterMassValue;
/// 阻抗（单位：Ω）
@property (nonatomic, assign) UInt16 impedanceValue;
/// 心率（单位：/）
@property (nonatomic, assign) UInt8 heartRateValue;

/// 婴儿体重（单位：0.010kg）
@property (nonatomic, assign) UInt16 babyWeightValue;


@end

NS_ASSUME_NONNULL_END
