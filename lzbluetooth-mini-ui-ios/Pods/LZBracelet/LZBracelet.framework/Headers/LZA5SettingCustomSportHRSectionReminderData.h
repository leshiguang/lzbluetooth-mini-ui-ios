//
//  LZA5SettingCustomSportHRSectionReminderData.h
//  LZBluetooth
//
//  Created by tanjian on 2020/10/22.
//  自定义运动心率区间提醒到手环(0xA8)

#import <Foundation/Foundation.h>



#import <LZBracelet/LZA5SettingData.h>

NS_ASSUME_NONNULL_BEGIN
/// 自定义运动心率区间
@interface LZA5SettingCustomSportHRSectionReminderData : LZA5SettingData
/// 心率上限
@property (nonatomic, assign) UInt8 maxHr;
/// 心率下限
@property (nonatomic, assign) UInt8 minHr;
/// 心率 提醒开关
@property (nonatomic, assign) BOOL enable;


/// HR6 新增
@property (nonatomic, assign) UInt8 sportMaxHr;
@property (nonatomic, assign) UInt8 sportMinHr;
@property (nonatomic, assign) BOOL sportEnable;

@end

NS_ASSUME_NONNULL_END
