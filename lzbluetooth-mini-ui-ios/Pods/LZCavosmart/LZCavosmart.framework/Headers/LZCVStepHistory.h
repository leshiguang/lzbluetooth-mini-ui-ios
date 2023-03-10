//
//  LZCVStepHistory.h
//  LZCavosmart
//
//  Created by tanjian on 2022/8/16.
//

#import <Foundation/Foundation.h>
#import <LZCavosmart/LZCVDataBase.h>

NS_ASSUME_NONNULL_BEGIN

@interface LZCVStepHistoryInfo : NSObject

/// 时间戳 精度15分钟 单位：s
@property (nonatomic, assign) NSUInteger utc;

/// 模式（暂不考虑）
@property (nonatomic, assign) NSUInteger mode;

/// 步数
@property (nonatomic, assign) NSUInteger step;

/// 活动时长，
@property (nonatomic, assign) NSUInteger activeTime;

/// 卡路里 单位：卡
@property (nonatomic, assign) NSUInteger calories;

/// 距离 单位 ：米
@property (nonatomic, assign) NSUInteger distance;

@end


/// 历史步数
@interface LZCVStepHistory : LZCVDataBase <LZDecodeDataProtocol>


/// 历史步数列表
@property (nonatomic, strong) NSArray <LZCVStepHistoryInfo *> *list;

@end

NS_ASSUME_NONNULL_END
