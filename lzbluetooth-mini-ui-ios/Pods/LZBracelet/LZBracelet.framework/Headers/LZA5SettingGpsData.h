//
//  LZA5SettingGpsData.h
//  LZBluetooth
//
//  Created by tanjian on 2020/10/22.
//  手机 GPS 状态到手环(0xA7)

#import <Foundation/Foundation.h>


#import <LZBracelet/LZA5SettingData.h>


NS_ASSUME_NONNULL_BEGIN

@interface LZA5SettingGpsData : LZA5SettingData

/// 手机功能 检测 0x01:GPS 检测 
@property (nonatomic, assign) UInt8 function;

@property (nonatomic, assign) UInt8 gpsSwitch;

@end

NS_ASSUME_NONNULL_END
