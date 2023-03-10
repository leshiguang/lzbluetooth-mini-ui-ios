//
//  LZA5SettingSedentaryReminderData.h
//  LZBluetooth
//
//  Created by tanjian on 2020/10/22.
//  久不动(久坐)提醒设置到蓝牙手环(0x6E)

#import <Foundation/Foundation.h>
#import <LZBracelet/LZA5SettingData.h>

NS_ASSUME_NONNULL_BEGIN

/// 久不动(久坐)提醒详情
@interface LZA5SettingSedentaryReminderData : LZA5SettingData
/// 久坐提醒列表
/// 事件提醒的索引， 需要开发者自己计算，唯一ID
@property (nonatomic, assign) UInt8 index;
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
/// 多久不动就提醒（单位：min）
@property (nonatomic, assign) UInt8 eachTimeAlert;
/// 提醒重复时间（星期）
@property (nonatomic, assign) LZA5RepeatTimeFlag repeatFlag;
/// 震动方式
@property (nonatomic, assign) LZA5VibrationType vibrationType;
/// 震动时间(0~60)
@property (nonatomic, assign) UInt8 vibrationTime;
/// 震动强度1 (0~9)
@property (nonatomic, assign) UInt8 vibrationLevel1;
/// 震动强度2 (0~9)
@property (nonatomic, assign) UInt8 vibrationLevel2;

@end

NS_ASSUME_NONNULL_END
