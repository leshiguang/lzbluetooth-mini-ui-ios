//
//  LZA5SettingUserInfoData.h
//  LZBluetooth
//
//  Created by tanjian on 2020/10/22.
//  APP push 用户信息到蓝牙手环(0x68)

#import <Foundation/Foundation.h>



#import <LZBracelet/LZA5SettingData.h>
#import <LZBracelet/LZA5CommonDefine.h>


NS_ASSUME_NONNULL_BEGIN

@interface LZA5SettingUserInfoData : LZA5SettingData

@property (nonatomic, assign) BOOL isDelete;
@property (nonatomic, assign) double weight;
@property (nonatomic, assign) double height;
@property (nonatomic, assign) LZA5TargetType targetState;
@property (nonatomic, assign) NSNumber *weekTarget;

@end

NS_ASSUME_NONNULL_END
