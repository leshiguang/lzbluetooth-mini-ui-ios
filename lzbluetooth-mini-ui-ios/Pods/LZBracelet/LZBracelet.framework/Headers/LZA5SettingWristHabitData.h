//
//  LZA5SettingWristHabitData.h
//  LZBluetooth
//
//  Created by tanjian on 2020/10/22.
//  手环佩戴左右手显示方式设置到手环(0x7A)

#import <Foundation/Foundation.h>



#import <LZBracelet/LZA5SettingData.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, LZA5DisplayMode) {
    /// 左手佩戴显示
    LZA5DisplayModeLeft = 0,
    /// 右手佩戴显示
    LZA5DisplayModeRight,
};

@interface LZA5SettingWristHabitData : LZA5SettingData
/// 显示方式 0x00:佩戴左手显示 0x01:佩戴右手显示
@property (nonatomic, assign) LZA5DisplayMode displayMode;

@end

NS_ASSUME_NONNULL_END
