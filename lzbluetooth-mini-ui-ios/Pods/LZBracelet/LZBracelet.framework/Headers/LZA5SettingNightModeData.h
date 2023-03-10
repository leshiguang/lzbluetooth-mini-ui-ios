//
//  LZA5SettingNightModeData.h
//  LZBluetooth
//
//  Created by tanjian on 2020/10/22.
//  夜间抬手显示开关设置到手环(0x77)

#import <Foundation/Foundation.h>



#import <LZBracelet/LZA5SettingData.h>

NS_ASSUME_NONNULL_BEGIN

/// 夜间抬手显示开关设置
@interface LZA5SettingNightModeData : LZA5SettingData
/// 开关
@property (nonatomic, assign) BOOL enable;
/// 开始时间小时
@property (nonatomic, assign) UInt8 startHour;
/// 开始时间分钟
@property (nonatomic, assign) UInt8 startMinute;
/// 结束时间小时
@property (nonatomic, assign) UInt8 endHour;
/// 结束时间分钟
@property (nonatomic, assign) UInt8 endMinute;

@end

NS_ASSUME_NONNULL_END
