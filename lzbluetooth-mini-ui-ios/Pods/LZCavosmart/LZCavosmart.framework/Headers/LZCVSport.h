//
//  LZCVSport.h
//  LZCavosmart
//
//  Created by tanjian on 2022/8/16.
//

#import <Foundation/Foundation.h>
#import <LZCavosmart/LZCVDataBase.h>

NS_ASSUME_NONNULL_BEGIN

@interface LZCVSportInfo : NSObject

/// 运动模式
@property (nonatomic, assign) LZCVSportMode sportMode;
/// 暂停次数 
@property (nonatomic, assign) NSUInteger suspendTimes;
/// 暂停时长 （单位：秒）
@property (nonatomic, assign) NSUInteger durationOfSuspend;
/// 开始时间
@property (nonatomic, assign) NSUInteger start;
/// 结束时间
@property (nonatomic, assign) NSUInteger end;
/// 总步数，在游泳运动模式总步数代表 游泳圈数  laps
@property (nonatomic, assign) NSUInteger step;
/// 单位 Kcal
@property (nonatomic, assign) double calories;
/// 单位米
@property (nonatomic, assign) NSUInteger distance;

@end

@interface LZCVSport : LZCVDataBase

/// 运动数据列表
@property (nonatomic, strong) NSArray <LZCVSportInfo *> *list;

@end

NS_ASSUME_NONNULL_END
