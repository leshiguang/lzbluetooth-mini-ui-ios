//
//  LZDeviceSettingDBUtil.h
//  LZBluetooth Example
//
//  Created by tanjian on 2021/1/18.
//

#import <Foundation/Foundation.h>
@import LZBracelet;

NS_ASSUME_NONNULL_BEGIN

@interface LZDeviceSettingDBUtil : NSObject


/// 获取设置
/// @param macString Mac地址
/// @param settingType 类型
+ (nullable id)getConfigsWithMacString:(NSString *)macString settingType:(LZDeviceSettingType)settingType;

/// 存储设备信息 这里是替换
/// @param settingDatas 设置信息，可以是数组，不过是数组的时候需要settingType一致
/// @param macString Mac地址
+ (void)saveSettingDatas:(id)settingDatas withMacString:(NSString *)macString;

+ (void)setEventReminder:(LZA5SettingEventRemindData *)data macString:(NSString *)macString;

+ (void)removeEventReminder:(LZA5SettingEventRemindData *)contentData macString:(NSString *)macString;

+ (void)setCallReminder:(LZA5SettingMessageReminderData *)data macString:(NSString *)macString;


/// 设置类型
/// @param settingType 设置类型
+ (NSString *)titleWithSettingType:(LZDeviceSettingType)settingType;

@end

NS_ASSUME_NONNULL_END
