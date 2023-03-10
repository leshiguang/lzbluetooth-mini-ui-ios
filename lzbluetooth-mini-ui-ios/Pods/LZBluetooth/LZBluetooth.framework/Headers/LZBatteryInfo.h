//
//  LZBatteryInfo.h
//  LZBluetooth
//
//  Created by tanjian on 2020/11/19.
//  电量信息

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LZBatteryInfo : NSObject

/// 是否正在充电
@property (nonatomic, assign) BOOL isCharging;

/// 电量%
@property (nonatomic, assign) NSUInteger batteryPercentage;

@end

NS_ASSUME_NONNULL_END
