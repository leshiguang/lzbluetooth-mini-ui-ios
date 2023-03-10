//
//  LZA5SettingSwimParamsData.h
//  LZBluetooth
//
//  Created by tanjian on 2020/10/22.
//  游泳参数设置到手环(0xAC)

#import <Foundation/Foundation.h>



#import <LZBracelet/LZA5SettingData.h>

NS_ASSUME_NONNULL_BEGIN

/// 游泳参数设置
@interface LZA5SettingSwimParamsData : LZA5SettingData
/// 泳道长度 (单位: 米)
@property (nonatomic, assign) UInt8 length;

@end

NS_ASSUME_NONNULL_END
