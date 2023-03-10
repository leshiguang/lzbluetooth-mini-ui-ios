//
//  LZA5SportCaloriesData.h
//  LZBluetooth
//
//  Created by tanjian on 2020/10/22.
//  跑步卡路里数据 0x7f 0x

#import <Foundation/Foundation.h>



#import <LZBracelet/LZBraceletMeasurementData.h>
#import <LZBluetooth/LZMergeDataManager.h>

@protocol LZMergeable;

NS_ASSUME_NONNULL_BEGIN

/// 卡路里 类型有两个，根据measurementDataType判断（LZBraceletMeasurementDataTypeRunCalories, LZBraceletMeasurementDataTypeSportCalories）
@interface LZA5SportCaloriesData : LZBraceletMeasurementData <LZMergeable>
/// 运动模式
@property (nonatomic, assign) LZA5SportMode sportMode;
/// 子模式
@property (nonatomic, assign) LZA5SportSubMode subMode;
///  UTC
@property (nonatomic, assign) UInt32 utc;
/// 每笔数据间隔时间 (s)
@property (nonatomic, assign) UInt32 utcOffset;
///  数据剩余条数
@property (nonatomic, assign) UInt16 reside;
/// 卡路里列表,每个值标识一个 UTC 偏移量时间内消耗的卡路里， utcOffset时间内消耗的卡路里 unit: kcal
@property (nonatomic, strong) NSArray <NSNumber *> *calories;
/// 原始数据
@property (nonatomic, strong) NSData *srcData;

@end

NS_ASSUME_NONNULL_END
