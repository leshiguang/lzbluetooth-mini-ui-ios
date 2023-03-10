//
//  LZA5HeatrateSectionData.h
//  LZBluetooth
//
//  Created by tanjian on 2020/10/22.
//  0x75 手环发送心率区间统计数据



#import <LZBracelet/LZBraceletMeasurementData.h>

NS_ASSUME_NONNULL_BEGIN
/// 手环发送心率区间统计数据 从当天的凌晨 00:00:00开始，到当天 的截止 UTC 的累计该心 率区间的时间
@interface LZA5HeatrateSectionData : LZBraceletMeasurementData
/// 当前截止时间 每天统计截止UTC
@property (nonatomic, assign) UInt32 utc;
/// 心率区间 I 累计时间， 单位: 秒
@property (nonatomic, assign) UInt32 section1Time;
/// 心率区间 II 累计时间， 单位: 秒
@property (nonatomic, assign) UInt32 section2Time;
/// 心率区间 III 累计时 间，单位: 秒
@property (nonatomic, assign) UInt32 section3Time;
@end

NS_ASSUME_NONNULL_END
