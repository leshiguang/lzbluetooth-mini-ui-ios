//
//  LZA5SettingTimeModeData.h
//  LZBluetooth
//
//  Created by tanjian on 2020/10/22.
//  手环时间显示时制设置到手环(0x79)

#import <Foundation/Foundation.h>



#import <LZBracelet/LZA5SettingData.h>


NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, LZA5TimeMode) {
    /// 24小时
    LZA5TimeMode24 = 0,
    /// 12小时
    LZA5TimeMode12,
};

/// 手环时间显示时制设置
@interface LZA5SettingTimeModeData : LZA5SettingData
/// 0x00:24小时制显示 0x01:12小时制显示
@property (nonatomic, assign) LZA5TimeMode timeMode;

@end

NS_ASSUME_NONNULL_END
