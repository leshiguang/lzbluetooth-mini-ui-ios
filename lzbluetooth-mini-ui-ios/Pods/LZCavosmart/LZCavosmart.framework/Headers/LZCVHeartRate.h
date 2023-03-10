//
//  LZCVHeartRate.h
//  LZCavosmart
//
//  Created by tanjian on 2022/8/16.
//

#import <Foundation/Foundation.h>
#import <LZCavosmart/LZCVDataBase.h>

NS_ASSUME_NONNULL_BEGIN

@interface LZCVHRInfo : NSObject

/// 心率值
@property (nonatomic, assign) NSUInteger hr;

/// 和手环显示温度开关数据一致
@property (nonatomic, assign) BOOL temperatureDisplaySwitch;

/// 温度补偿开关
@property (nonatomic, assign) BOOL compensationEnable;

/// 佩戴状态 暂时无用
@property (nonatomic, assign) NSUInteger wearState;

/// 温度 单位是0.1（摄氏度） 比如316 = 31.6（摄氏度）
@property (nonatomic, assign) NSUInteger temperature;


/// 时间戳
@property (nonatomic, assign) NSUInteger utc;

@end

@interface LZCVHeartRate : LZCVDataBase <LZDecodeDataProtocol>


/// 第一笔的时间戳
@property (nonatomic, assign) NSUInteger utc;


/// 心率列表
@property (nonatomic, strong) NSArray <LZCVHRInfo *> *heartRates;


/// 间隔时间
@property (nonatomic, assign) NSUInteger utcOffset;


@end

NS_ASSUME_NONNULL_END
