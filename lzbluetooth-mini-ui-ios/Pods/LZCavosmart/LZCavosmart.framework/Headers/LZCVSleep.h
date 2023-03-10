//
//  LZCVSleep.h
//  LZCavosmart
//
//  Created by tanjian on 2022/8/16.
//

#import <Foundation/Foundation.h>
#import <LZCavosmart/LZCVDataBase.h>
#import <LZBluetooth/LZMergeDataManager.h>

NS_ASSUME_NONNULL_BEGIN

@interface LZCVSleepState : NSObject

/**
 * 开始时间
 */
@property (nonatomic, assign) NSUInteger startUtc;
/**
 * 结束utc
 */
@property (nonatomic, assign) NSUInteger endUtc;

/**
 * 1 : 清醒2 : 浅睡 3 : 深睡
 */
@property (nonatomic, assign) NSUInteger deep;

/** 分钟 */
@property (nonatomic, assign) NSUInteger duration;

@end



@interface LZCVSleep : LZCVDataBase <LZMergeable>

/**
   * 睡眠时间 Bed time.
   */
@property (nonatomic, assign) NSUInteger sleepUtc;
  /**
   * 醒来时间 Get-up time.
   */
@property (nonatomic, assign) NSUInteger awakeUtc;
  /**
   * 清醒时长 （分钟）
   */
@property (nonatomic, assign) NSUInteger durationOfAwake;
  /**
   * 浅睡时长 （分钟）
   */
@property (nonatomic, assign) NSUInteger timeOfLightSleep;
  /**
   * 深睡时长 （分钟）
   */
@property (nonatomic, assign) NSUInteger timeOfDeepSleep;

/// 解析后的数据
@property (nonatomic, strong) NSMutableArray <LZCVSleepState *> *sleepList;


/// 原始数据
@property (nonatomic, strong) NSMutableArray <NSDictionary *> *list;


@end

NS_ASSUME_NONNULL_END
