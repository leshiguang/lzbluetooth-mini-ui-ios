//
//  LZCVLongSitSetting.h
//  LZCavosmart
//
//  Created by tanjian on 2022/8/16.
//

#import <Foundation/Foundation.h>
#import <LZCavosmart/LZCVDataBase.h>

NS_ASSUME_NONNULL_BEGIN


/// 久坐提醒
@interface LZCVLongSitSetting : LZCVDataBase <LZDecodeDataProtocol>

/// 开关
@property (nonatomic, assign) BOOL enable;
/// 多久不活动触发提醒 （单位：分钟）
@property (nonatomic, assign) NSUInteger duration;
/// 开始时间小时
@property (nonatomic, assign) UInt8 startHour;
/// 结束时间小时
@property (nonatomic, assign) UInt8 endHour;

/// 提醒重复时间
@property (nonatomic, assign) LZCVRepeatTime repeatTime;


@end

NS_ASSUME_NONNULL_END
