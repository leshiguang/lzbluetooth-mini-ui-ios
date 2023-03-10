//
//  LZA5SettingHeartrateDetectionData.h
//  LZBluetooth
//
//  Created by tanjian on 2020/10/22.
//  心率检测设置到蓝牙手环(0x6D)

#import <Foundation/Foundation.h>



#import <LZBracelet/LZA5SettingData.h>
#import <LZBluetooth/LZMeasurementDataProtocol.h>

NS_ASSUME_NONNULL_BEGIN

/// 心率开关
@interface LZA5SettingHeartrateDetectionData : LZA5SettingData <LZMeasurementDataProtocol>
/// 开关
@property (nonatomic, assign) BOOL enable;
/// 开始时间小时
@property (nonatomic, assign) UInt8 startHour;
/// 开始时间分钟
@property (nonatomic, assign) UInt8 startMinute;
/// 结束时间小时
@property (nonatomic, assign) UInt8 endHour;
/// 结束时间分钟
@property (nonatomic, assign) UInt8 endMinute;

@end

NS_ASSUME_NONNULL_END
