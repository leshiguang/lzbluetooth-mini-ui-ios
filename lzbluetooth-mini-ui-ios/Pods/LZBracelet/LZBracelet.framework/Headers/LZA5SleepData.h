//
//  LZA5SleepData.h
//  LZBluetooth
//
//  Created by tanjian on 2020/10/22.
//  发送手环睡眠压缩数据(0x52)



#import <LZBracelet/LZBraceletMeasurementData.h>

NS_ASSUME_NONNULL_BEGIN

/// 睡眠数据
@interface LZA5SleepData : LZBraceletMeasurementData
///  UTC
@property (nonatomic, assign) UInt32 utc;
/// 每笔睡眠数据间隔 （s）
@property (nonatomic, assign) UInt32 utcOffset;
/// 手环中睡眠 数据剩余条数
@property (nonatomic, assign) UInt16 reside;
/// 睡眠值
@property (nonatomic, strong) NSArray <NSNumber *> *levelSet;
/// 原始数据 
@property (nonatomic, strong) NSData *srcData;

@end

NS_ASSUME_NONNULL_END
