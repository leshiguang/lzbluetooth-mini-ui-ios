//
//  LZGLTimeSetting.h
//  LZGlucose
//
//  Created by tanjian on 2023/2/8.
//

#import <LZGlucose/LZGLSetting.h>
#import <LZBluetooth/LZMeasurementDataProtocol.h>

NS_ASSUME_NONNULL_BEGIN

@interface LZGLTimeSetting : LZGLSetting <LZMeasurementDataProtocol>

/// 时间戳
@property (nonatomic, assign) NSUInteger utc;

@end

NS_ASSUME_NONNULL_END
