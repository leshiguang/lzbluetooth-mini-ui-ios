//
//  LZA5RestingHeartRateData.h
//  LZBracelet
//
//  Created by tanjian on 2022/3/11.
//  静息心率

#import <LZBracelet/LZBraceletMeasurementData.h>
#import <LZBluetooth/LZMergeDataManager.h>

NS_ASSUME_NONNULL_BEGIN

@interface LZRestingHeartRateInfo : NSObject

@property (nonatomic, assign) UInt32 utc;
@property (nonatomic, assign) UInt32 bloodOxygenValue;
@property (nonatomic, assign) UInt32 heartRate;

@end



@interface LZA5RestingHeartRateData : LZBraceletMeasurementData <LZMergeable>

/// 剩余
@property (nonatomic, assign) UInt32 reside;

/// 偏移量
@property (nonatomic, assign) UInt32 offset;

/// 数据列表
@property (nonatomic, strong) NSArray <LZRestingHeartRateInfo *> *list;

@end

NS_ASSUME_NONNULL_END
