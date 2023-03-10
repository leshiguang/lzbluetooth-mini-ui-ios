//
//  LZCVClockSetting.h
//  LZCavosmart
//
//  Created by tanjian on 2022/8/16.
//

#import <Foundation/Foundation.h>
#import <LZCavosmart/LZCVDataBase.h>

NS_ASSUME_NONNULL_BEGIN




@interface LZCVClockInfo : NSObject

/// 序号 1～5
@property (nonatomic, assign) NSUInteger index;

/// 小时
@property (nonatomic, assign) NSUInteger hour;

/// 分钟
@property (nonatomic, assign) NSUInteger minute;

/// 提醒重复时间
@property (nonatomic, assign) LZCVRepeatTime repeatTime;

@end


/// 闹钟  note: 闹钟设置都是全量替换
@interface LZCVClockSetting : LZCVDataBase <LZDecodeDataProtocol>

/// 闹钟列表
@property (nonatomic, strong) NSArray <LZCVClockInfo *> *events;

@end

NS_ASSUME_NONNULL_END
