//
//  LZA5SettingAlarmClockData.h
//  LZBluetooth
//
//  Created by tanjian on 2020/10/22.
//  闹钟设置到蓝牙手环(0x69)

#import <Foundation/Foundation.h>



#import <LZBracelet/LZA5SettingData.h>

NS_ASSUME_NONNULL_BEGIN

/// 闹钟详情
@interface LZA5SettingAlarmClockContentData : NSObject
/// 闹钟标示
@property (nonatomic, assign) UInt8 index;
/// 开关
@property (nonatomic, assign) BOOL enable;
/// 小时
@property (nonatomic, assign) UInt8 hour;
/// 分钟
@property (nonatomic, assign) UInt8 minute;
/// 重复时间
@property (nonatomic, assign) LZA5RepeatTimeFlag repeatFlag;
/// 震动类型
@property (nonatomic, assign) LZA5VibrationType vibrationType;
/// 震动时长 （s）
@property (nonatomic, assign) UInt8 vibrationTime;
/// 震动等级1（0～9）
@property (nonatomic, assign) UInt8 vibrationLevel1;
/// 震动等级2（0～9）
@property (nonatomic, assign) UInt8 vibrationLevel2;

@end

/// 闹钟设置到蓝牙手环
@interface LZA5SettingAlarmClockData : LZA5SettingData
/// 开关
@property (nonatomic, assign) BOOL enable;
/// 闹钟列表
@property (nonatomic, strong) NSArray <LZA5SettingAlarmClockContentData *> *contentDatas;
@end

NS_ASSUME_NONNULL_END
