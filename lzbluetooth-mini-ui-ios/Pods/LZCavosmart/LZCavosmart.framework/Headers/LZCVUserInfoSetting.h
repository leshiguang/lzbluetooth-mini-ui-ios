//
//  LZCVUserInfoSetting.h
//  LZCavosmart
//
//  Created by tanjian on 2022/8/16.
//

#import <Foundation/Foundation.h>
#import <LZCavosmart/LZCVDataBase.h>

NS_ASSUME_NONNULL_BEGIN


/// 用户信息
@interface LZCVUserInfoSetting : LZCVDataBase <LZDecodeDataProtocol>


/// 用户性别 0:女 1:男
@property (nonatomic, assign) NSUInteger gender;

/// 年龄
@property (nonatomic, assign) NSUInteger age;

/// 身高 （单位：cm） 精度 0.5
@property (nonatomic, assign) double height;

/// 体重 （单位：kg）精度 0.5
@property (nonatomic, assign) double weight;

@end

NS_ASSUME_NONNULL_END
