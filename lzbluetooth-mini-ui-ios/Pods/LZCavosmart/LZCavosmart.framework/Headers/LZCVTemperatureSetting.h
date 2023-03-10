//
//  LZCVTemperatureSetting.h
//  LZCavosmart
//
//  Created by tanjian on 2022/8/16.
//

#import <Foundation/Foundation.h>
#import <LZCavosmart/LZCVDataBase.h>

NS_ASSUME_NONNULL_BEGIN

/// 温度单位
typedef NS_ENUM(NSUInteger, LZCVTemperatureUnit) {
    LZCVTemperatureUnitC             = 0x00,
    LZCVTemperatureUnitF             = 0x01,
};


/// 实时温度开关
@interface LZCVTemperatureSetting : LZCVDataBase <LZDecodeDataProtocol>

@property (nonatomic, assign) BOOL enable;

@end



/// 温度是否显示
@interface LZCVTemperatureDisplaySetting : LZCVDataBase <LZDecodeDataProtocol>


/// 开关
@property (nonatomic, assign) BOOL enable;


/// 单位
@property (nonatomic, assign) LZCVTemperatureUnit unit;


/// 温度补偿开关
@property (nonatomic, assign) BOOL compensationEnable;

@end

NS_ASSUME_NONNULL_END
