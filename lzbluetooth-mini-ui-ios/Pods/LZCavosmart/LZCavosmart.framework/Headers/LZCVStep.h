//
//  LZCVStep.h
//  LZCavosmart
//
//  Created by tanjian on 2022/8/16.
//

#import <Foundation/Foundation.h>
#import <LZCavosmart/LZCVDataBase.h>

NS_ASSUME_NONNULL_BEGIN

@interface LZCVStep : LZCVDataBase <LZDecodeDataProtocol>


/// 当前15分钟步数 单位：步
@property (nonatomic, assign) NSUInteger stepsOf15min;

/// 当前15分钟卡路里 单位：卡
@property (nonatomic, assign) NSUInteger caloriesOf15min;

/// 当前15分钟距离 单位：米
@property (nonatomic, assign) NSUInteger distanceOf15min;

/// 时间戳
@property (nonatomic, assign) NSUInteger utc;

/// 当天总步数 单位：步
@property (nonatomic, assign) NSUInteger step;

/// 当天总卡路里 单位：卡
@property (nonatomic, assign) NSUInteger calories;

/// 当前总距离 单位：距离
@property (nonatomic, assign) NSUInteger distance;

@end

NS_ASSUME_NONNULL_END
