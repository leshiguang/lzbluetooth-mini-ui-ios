//
//  LZA5SettingPaceAndDistanceData.h
//  LZBluetooth
//
//  Created by tanjian on 2020/10/22.
//  配速和距离到手环(0xAB)

#import <Foundation/Foundation.h>



#import <LZBracelet/LZA5SettingData.h>

NS_ASSUME_NONNULL_BEGIN

/// 配速与距离设置
@interface LZA5SettingPaceAndDistanceData : LZA5SettingData
/// 配速1 (unit:s)  配速是指跑(走)完1km 需要多久时间，精确到秒， 例如256表示4’16’’
@property (nonatomic, assign) UInt16 pace;
/// 距离(单 位:米)
@property (nonatomic, assign) UInt32 distance;

@end

NS_ASSUME_NONNULL_END
