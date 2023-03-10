//
//  LZA5BloodOxygenData.h
//  LZBluetooth
//
//  Created by tanjian on 2021/11/12.
//



#import <LZBracelet/LZBraceletMeasurementData.h>
#import <LZBluetooth/LZMergeDataManager.h>

NS_ASSUME_NONNULL_BEGIN

@interface LZBloodOxygenInfo : NSObject

@property (nonatomic, assign) UInt32 utc;
@property (nonatomic, assign) UInt32 bloodOxygenValue;
@property (nonatomic, assign) UInt32 heartRate;

/// 0x00: 普通血氧数据  0x01: 异常血样数据
@property (nonatomic, assign) UInt32 state;

@end

@interface LZA5BloodOxygenData : LZBraceletMeasurementData <LZMergeable>

@property (nonatomic, assign) UInt32 reside;
@property (nonatomic, assign) UInt32 offset;


@property (nonatomic, strong) NSArray <LZBloodOxygenInfo *> *list;

@end

NS_ASSUME_NONNULL_END
