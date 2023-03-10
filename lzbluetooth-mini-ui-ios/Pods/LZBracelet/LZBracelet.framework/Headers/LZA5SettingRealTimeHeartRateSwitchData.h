//
//  LZA5SettingRealTimeHeartRateSwitchData.h
//  LZBluetooth
//
//  Created by tanjian on 2021/3/19.
//




#import <LZBracelet/LZA5SettingData.h>


NS_ASSUME_NONNULL_BEGIN

/// 实时心率开关
@interface LZA5SettingRealTimeHeartRateSwitchData : LZA5SettingData

/// 是否开启
@property (nonatomic, assign) BOOL enable;

@end

NS_ASSUME_NONNULL_END
