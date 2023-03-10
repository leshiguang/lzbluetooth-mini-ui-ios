//
//  LZA5SettingLostData.h
//  LZBluetooth
//
//  Created by tanjian on 2020/10/22.
//  防丢设置到蓝牙手环(0x6F)

#import <Foundation/Foundation.h>



#import <LZBracelet/LZA5SettingData.h>

NS_ASSUME_NONNULL_BEGIN
/// 防丢设置
@interface LZA5SettingLostData : LZA5SettingData
/// 防丢设置开关
@property (nonatomic, assign) BOOL enable;

@end

NS_ASSUME_NONNULL_END
