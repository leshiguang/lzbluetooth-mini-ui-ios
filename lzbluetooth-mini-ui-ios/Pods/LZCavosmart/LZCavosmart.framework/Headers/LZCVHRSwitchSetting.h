//
//  LZCVHRSwitchSetting.h
//  LZCavosmart
//
//  Created by tanjian on 2022/8/17.
//

#import <Foundation/Foundation.h>
#import <LZCavosmart/LZCVDataBase.h>

NS_ASSUME_NONNULL_BEGIN

/// 心率开关类型
typedef NS_ENUM(NSUInteger, LZCVHRSwitchType) {
    /// 连续心率采集
    LZCVHRSwitchTypeSerial     = 1,
    /// 单次心率采集
    LZCVHRSwitchTypeTest        = 2,
};

/// 心率开关
@interface LZCVHRSwitchSetting : LZCVDataBase <LZDecodeDataProtocol>

/// 开关
@property (nonatomic, assign) BOOL enable;


/// 开关类型
@property (nonatomic, assign) LZCVHRSwitchType switchType;

/// 采样间隔 单位：分钟
@property (nonatomic, assign) NSUInteger interval;

@end

NS_ASSUME_NONNULL_END
