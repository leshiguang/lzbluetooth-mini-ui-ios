//
//  LZDeviceSettingDBUtil.h
//  LZBluetooth Example
//
//  Created by tanjian on 2021/1/18.
//

#import <Foundation/Foundation.h>
#import <LZBluetooth/LZBluetooth.h>

NS_ASSUME_NONNULL_BEGIN

@interface LZDeviceSettingDBUtil : NSObject

/// 获取设置项所对应的配置，如果没有设置过，则为默认
/// @param macString 设备的Mac地址
/// @param settingType 设置类型
/// @return 设置项model
+ (nullable id<LZDeviceSettingProtocol>)getConfigWithMacString:(NSString *)macString
                                          settingType:(LZDeviceSettingType)settingType;


/// 存储设备信息
/// @param settingData 设置信息
/// @param macString Mac地址
+ (void)saveSettingData:(id<LZDeviceSettingProtocol>)settingData withMacString:(NSString *)macString;

@end

NS_ASSUME_NONNULL_END
