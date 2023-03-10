//
//  LZA5SettingSmartHRDetectionData.h
//  LZBluetooth
//
//  Created by tanjian on 2020/10/22.
//  智能心率检测开关设置到手环(0x76)

#import <Foundation/Foundation.h>

#import <LZBracelet/LZA5SettingData.h>

NS_ASSUME_NONNULL_BEGIN

/// 监测模式
typedef NS_ENUM(NSUInteger, LZA5SmartHrMode) {
    /// 关闭
    LZA5SmartHrModeClose,
    /// 开启
    LZA5SmartHrModeEnable,
    /// 智能监测
    LZA5SmartHrModeSmart,
};

/// 智能心率检测开关设置
@interface LZA5SettingSmartHRDetectionData : LZA5SettingData
/// 0x00:关闭心率检测 0x01:开启心率检测 0x02:开启智能监测
@property (nonatomic, assign) LZA5SmartHrMode mode;

@end

NS_ASSUME_NONNULL_END
