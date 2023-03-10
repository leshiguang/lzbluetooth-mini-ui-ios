//
//  LZA5SleepReportData.h
//  LZBluetooth
//
//  Created by tanjian on 2021/11/12.
//



#import <LZBracelet/LZBraceletMeasurementData.h>
#import <LZBluetooth/LZMergeDataManager.h>


NS_ASSUME_NONNULL_BEGIN

@protocol LZMergeable;

@interface LZSleepData : NSObject

/**
 * 开始时间
 */
@property (nonatomic, assign) UInt32 startUtc;
/**
 * 结束utc
 */
@property (nonatomic, assign) UInt32 endUtc;

/**
 * 4 : 眼动 1 : 清醒2 : 浅睡 3 : 深睡
 */
@property (nonatomic, assign) UInt32 deep;

/** 分钟 */
@property (nonatomic, assign) UInt32 duration;

@end

@interface LZA5SleepReportData : LZBraceletMeasurementData <LZMergeable>

/**
   * 睡眠时间 Bed time.
   */
@property (nonatomic, assign) UInt32 sleepUtc;
  /**
   * 醒来时间 Get-up time.
   */
@property (nonatomic, assign) UInt32 awakeUtc;
  /**
   * 清醒时长 （分钟）
   */
@property (nonatomic, assign) UInt32 durationOfAwake;
  /**
   * 醒来次数
   */
@property (nonatomic, assign) UInt32 numberOfAwake;
  /**
   * 眼动次数
   */
@property (nonatomic, assign) UInt32 numberOfEyeMovement;
  /**
   * 浅睡时长 （分钟）
   */
@property (nonatomic, assign) UInt32 timeOfLightSleep;
  /**
   * 深睡时长 （分钟）
   */
@property (nonatomic, assign) UInt32 timeOfDeepSleep;
  /**
   * 睡眠特征
   */
@property (nonatomic, assign) UInt32 characteristicsOfSleep;
  /**
   * 带上传睡眠报告个数
   */
@property (nonatomic, assign) UInt32 reside;
  /**
   * 睡眠报告偏移
   */
@property (nonatomic, assign) UInt32 offsetOfSleepReport;
  /**
   * 扩展标志
   */
@property (nonatomic, assign) UInt32 extFlag;
  /**
   * 本次睡眠结构总数
   */
@property (nonatomic, assign) UInt32 totalOfSleepStruct;
  /**
   * 明细睡眠结构偏移
   */
@property (nonatomic, assign) UInt32 offsetOfSleepStruct;

  /**
   * 睡眠呼吸评分
   */
@property (nonatomic, assign) UInt32 breathScore;

  /**
   * 睡眠呼吸等级
   */
@property (nonatomic, assign) UInt32 breathLevel;

  /**
   * 睡眠评分
   */
@property (nonatomic, assign) UInt32 sleepScore;

@property (nonatomic, strong) NSArray <LZSleepData *> *sleepList;

@end

NS_ASSUME_NONNULL_END
