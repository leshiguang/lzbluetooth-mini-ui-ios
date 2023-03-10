//
//  LZA5SettingDialTypeData.h
//  LZBluetooth
//
//  Created by tanjian on 2020/10/22.
//  表盘设置到手环(0xA1)

#import <Foundation/Foundation.h>



#import <LZBracelet/LZA5SettingData.h>


NS_ASSUME_NONNULL_BEGIN
/// 表盘
typedef NS_ENUM(NSUInteger, LZA5DialType) {
    /// 表盘1
    LZA5DialType1 = 1,
    /// 表盘2
    LZA5DialType2 = 2,
    /// 表盘3
    LZA5DialType3 = 3,
    /// 表盘4
    LZA5DialType4 = 4,
    /// 表盘5
    LZA5DialType5 = 5,
    /// 表盘6
    LZA5DialType6 = 6
};

/// 表盘设置
@interface LZA5SettingDialTypeData : LZA5SettingData

/// 表盘类型 0x01:表盘1; 0x02:表盘2; 0x03:表盘3; 0x04:表盘4; 0x05:表盘5; 0x06:表盘6;
@property (nonatomic, assign) LZA5DialType dialType;

@end

NS_ASSUME_NONNULL_END
