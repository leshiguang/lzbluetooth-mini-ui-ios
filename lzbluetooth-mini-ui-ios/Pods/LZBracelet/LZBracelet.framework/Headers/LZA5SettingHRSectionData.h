//
//  LZA5SettingHRSectionData.h
//  LZBluetooth
//
//  Created by tanjian on 2020/10/22.
//  心率区间到蓝牙手环(0x74)

/*
 心率区间计算方式（下面有单独列出的设备除外）：
 MAXHr =（220 - 年龄）= 220 – 20 = 200
 心率区间 = MAXHr * 运动强度%
 静态心率 < MAXHr * (35%) = 70
 热身心率 = MAXHr * (35~49%) = 70 ~ 98
 燃脂心率 = MAXHr * (50~59%) = 100 ~ 118
 有氧耐力 = MAXHr * (60~74%) = 120 ~ 148
 无氧耐力 = MAXHr * (75~84%) = 150 ~ 168
 极限锻炼 = MAXHr * 85% = 170

 LS437项目心率区间计算方式：
 MAXHr =（220 - 年龄）= 220 – 20 = 200
   静态心率： 小于 L0,  L0默认值 =  MAXHr * 45 %；
 热身区间：大于等于L0，小于L1，L1默认值 =  MAXHr * 50 %；
 减脂区间：大于等于L1，小于L2，L2默认值 =  MAXHr * 60 %；
 耐力区间：大于等于L2，小于L3，L3默认值 =  MAXHr * 75 %；
 有氧区间：大于等于L3，小于L4，L4默认值 =  MAXHr * 85 %；
 极限区间：大于等于L4
 */

#import <Foundation/Foundation.h>



#import <LZBracelet/LZA5SettingData.h>

NS_ASSUME_NONNULL_BEGIN

/// 心率区间
@interface LZA5SettingHRSectionData : LZA5SettingData
/// 年龄 设备默认是20
@property (nonatomic, assign) UInt8 age;
/// 心率区间1下限
@property (nonatomic, assign) UInt8 section1Min;
/// 心率区间1上限
@property (nonatomic, assign) UInt8 section1Max;
/// 心率区间2下限
@property (nonatomic, assign) UInt8 section2Min;
/// 心率区间2上限
@property (nonatomic, assign) UInt8 section2Max;
/// 心率区间3下限
@property (nonatomic, assign) UInt8 section3Min;
/// 心率区间3上限
@property (nonatomic, assign) UInt8 section3Max;


/// 新协议
@property (nonatomic, assign) UInt8 level0;
@property (nonatomic, assign) UInt8 level1;
@property (nonatomic, assign) UInt8 level2;
@property (nonatomic, assign) UInt8 level3;
@property (nonatomic, assign) UInt8 level4;



@end

NS_ASSUME_NONNULL_END
