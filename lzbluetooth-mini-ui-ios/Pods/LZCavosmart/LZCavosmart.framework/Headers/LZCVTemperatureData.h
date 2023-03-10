//
//  LZCVTemperatureData.h
//  LZCavosmart
//
//  Created by tanjian on 2022/8/22.
//

#import <LZCavosmart/LZCVDataBase.h>

NS_ASSUME_NONNULL_BEGIN

@interface LZCVTemperatureData : LZCVDataBase

/// 0-温度数据监测关闭返回。
/// 1-温度数据监测开启返回
/// 2-手环设备连续心率没有开启，温度数据监测功能不开启
/// 3-手环设备连续心率已经开启，温度监测功能可以开启
/// 4-手环设备连续心率已经开启，但是因为设备正在忙碌状态，温度数据监测功能不开启
@property (nonatomic, assign) NSUInteger state;

@end

NS_ASSUME_NONNULL_END
