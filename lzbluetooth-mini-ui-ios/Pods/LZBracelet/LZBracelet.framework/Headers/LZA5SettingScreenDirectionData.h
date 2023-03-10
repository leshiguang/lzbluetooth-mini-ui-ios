//
//  LZA5SettingScreenDirectionData.h
//  LZBluetooth
//
//  Created by tanjian on 2020/10/22.
//  手环横屏竖屏显示设置到手环(0x7D)

#import <Foundation/Foundation.h>



#import <LZBracelet/LZA5SettingData.h>

NS_ASSUME_NONNULL_BEGIN
/// 屏幕方向
typedef NS_ENUM(NSUInteger, LZA5ScreenDirection) {
    /// 横屏
    LZA5ScreenDirectionH,
    /// 竖屏
    LZA5ScreenDirectionV,
};

/// 手环横屏竖屏显示设置
@interface LZA5SettingScreenDirectionData : LZA5SettingData

/// 横屏竖屏显示 设置 0x00:横屏显示 0x01:竖屏显示
@property (nonatomic, assign) LZA5ScreenDirection screenDirection;

@end

NS_ASSUME_NONNULL_END
