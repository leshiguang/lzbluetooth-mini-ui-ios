//
//  LZA5SettingEncourageTargetData.h
//  LZBluetooth
//
//  Created by tanjian on 2020/10/22.
//  鼓励目标类型提醒设置到蓝牙手环(0xA5) 替换 0x70

#import <Foundation/Foundation.h>



#import <LZBracelet/LZA5SettingData.h>

NS_ASSUME_NONNULL_BEGIN

/// 目标设置
@interface LZA5SettingEncourageTargetData : LZA5SettingData
/// 开关
@property (nonatomic, assign) BOOL enable;
/// 鼓励目标类型 0x01:步数; C1 0x02:卡路里; C2 0x03:距离;
@property (nonatomic, assign) LZA5TargetType targetType;
/// 目标值 步数、卡路里：0.1KCal、距离：M
@property (nonatomic, assign) NSInteger value;

@end

NS_ASSUME_NONNULL_END
