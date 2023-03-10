//
//  LZA5SportPaceData.h
//  LZBluetooth
//
//  Created by tanjian on 2020/10/22.
//  手环发送运动配速数据(0xE4)

#import <Foundation/Foundation.h>



#import <LZBracelet/LZBraceletMeasurementData.h>
#import <LZBluetooth/LZMergeDataManager.h>

@protocol LZMergeable;

NS_ASSUME_NONNULL_BEGIN

/// 配速
@interface LZA5SportPaceData : LZBraceletMeasurementData <LZMergeable>
/// 运动模式 参考LZA5SportMode
@property (nonatomic, assign) LZA5SportMode sportMode;
/// 运动子模式 参考LZA5SportSubMode
@property (nonatomic, assign) LZA5SportSubMode subMode;
///  UTC
@property (nonatomic, assign) UInt32 utc;
/// 测量数据间隔时间
@property (nonatomic, assign) UInt32 utcOffset;
/// 手环中 剩余条数
@property (nonatomic, assign) UInt16 reside;
/// 配速数据 (跑完1KM需要多长时间，精确到秒) 单位s
@property (nonatomic, strong) NSArray <NSNumber *> *speeds;
/// 原始数据
@property (nonatomic, strong) NSData *srcData;

@end

NS_ASSUME_NONNULL_END
