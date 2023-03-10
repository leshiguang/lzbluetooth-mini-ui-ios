//
//  LZCVEncourageSetting.h
//  LZCavosmart
//
//  Created by tanjian on 2022/8/16.
//

#import <Foundation/Foundation.h>
#import <LZCavosmart/LZCVDataBase.h>

NS_ASSUME_NONNULL_BEGIN

/// 目标类型
typedef NS_ENUM(NSUInteger, LZCVTargetType) {
    /// 步数
    LZCVTargetTypeStep = 1,
    /// 卡路里 单位千卡
    LZCVTargetTypeCalories = 2,
};


/// 鼓励目标
@interface LZCVEncourageSetting : LZCVDataBase <LZDecodeDataProtocol>


/// 目标类型
@property (nonatomic, assign) LZCVTargetType targetType;

/// 目标值
@property (nonatomic, assign) NSUInteger value;

@end

NS_ASSUME_NONNULL_END
