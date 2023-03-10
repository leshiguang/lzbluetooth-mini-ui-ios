//
//  LZA5SettingUnitData.h
//  LZBluetooth
//
//  Created by tanjian on 2020/10/22.
//  单位设置到手环(0x78)

#import <Foundation/Foundation.h>
#import <LZBracelet/LZA5SettingData.h>

NS_ASSUME_NONNULL_BEGIN

@interface LZA5SettingUnitData : LZA5SettingData
/// 0x00:公制 0x01:英制 其他:预留
@property (nonatomic, assign) UInt8 unit;

@end

NS_ASSUME_NONNULL_END
