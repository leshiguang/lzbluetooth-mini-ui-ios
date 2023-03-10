//
//  LZA5SettingEncourageData.h
//  LZBluetooth
//
//  Created by tanjian on 2020/10/27.
//  0x70 鼓励提醒 删除




#import <LZBracelet/LZA5SettingData.h>

NS_ASSUME_NONNULL_BEGIN
/// 步数目标
@interface LZA5SettingEncourageData : LZA5SettingData
/// 鼓励开关 当为“关闭”时，此字段为 该命令除 CRC 外最后一个字 节
@property (nonatomic, assign) BOOL enable;
/// 步数目标
@property (nonatomic, assign) UInt32 step;

@end

NS_ASSUME_NONNULL_END
