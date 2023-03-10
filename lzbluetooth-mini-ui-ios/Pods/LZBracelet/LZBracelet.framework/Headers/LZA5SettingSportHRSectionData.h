//
//  LZA5SettingSportHRSectionData.h
//  LZBluetooth
//
//  Created by tanjian on 2020/10/22.
//  运动区间心率到蓝牙手环(0x71)

#import <Foundation/Foundation.h>



#import <LZBracelet/LZA5SettingData.h>


NS_ASSUME_NONNULL_BEGIN

/// 运动心率区间
@interface LZA5SettingSportHRSectionData : LZA5SettingData
/// 运动区间心率 下限
@property (nonatomic, assign) UInt8 maxValue;
/// 运动区间心率 上限
@property (nonatomic, assign) UInt8 minValue;

@end

NS_ASSUME_NONNULL_END
