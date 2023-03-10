//
//  LZBPUserInfoSettingData.h
//  LZBluetooth
//
//  Created by tanjian on 2020/10/12.
//  设置用户信息请求（0x1101）收到设备信息

#import <Foundation/Foundation.h>


#import <LZBloodPressure/LZBPData.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(UInt8, LZBPUserInfoGender) {
    LZBPUserInfoGenderMale,
    LZBPUserInfoGenderFeMale,
};

@interface LZBPUserInfoSettingData : LZBPData

/// 0：客人/未识别用户 1~4：已识别用户 255：无效用户
@property (nonatomic, assign) UInt8 userNumber;

/// 0：男性 1：女性
@property (nonatomic, assign) LZBPUserInfoGender gender;

/// 年龄
@property (nonatomic, assign) UInt8 age;

/// 单位为 0.01m
@property (nonatomic, assign) UInt8 height;

/// 0：普通 1：运动员
@property (nonatomic, assign) BOOL isSporter;

/// 0、255：无效 1~254：运动等级
@property (nonatomic, assign) UInt8 sportLevel;

/// 体重（单位为 0.010kg）
@property (nonatomic, assign) UInt16 weight;

@end

NS_ASSUME_NONNULL_END
