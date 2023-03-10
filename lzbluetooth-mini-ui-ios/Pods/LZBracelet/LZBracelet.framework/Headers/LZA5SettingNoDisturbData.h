//
//  LZA5SettingNoDisturbData.h
//  LZBluetooth
//
//  Created by tanjian on 2020/10/22.
//  勿扰模式设置到手环(0xB3，替代 0x77)

#import <Foundation/Foundation.h>
#import <LZBracelet/LZA5SettingData.h>

NS_ASSUME_NONNULL_BEGIN

/// 勿扰模式
@interface LZA5SettingNoDisturbData : LZA5SettingData
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
/// 勿扰模式下是否允许抬手亮屏
@property (nonatomic, assign) BOOL isEnableRaise;

@end

NS_ASSUME_NONNULL_END
