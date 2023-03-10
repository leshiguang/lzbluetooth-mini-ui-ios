//
//  LZA6HearRateSwitchSettingData.h
//  LZBluetooth
//
//  Created by tanjian on 2020/10/12.
//

#import <Foundation/Foundation.h>

#import <LZScale/LZA6Data.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, LZA6HearRateSwitch) {
    LZA6HearRateSwitchOn = 1,
    LZA6HearRateSwitchOff = 2,
};

@interface LZA6HearRateSwitchSettingData : LZA6Data

@property (nonatomic, assign) LZA6HearRateSwitch hrSwitch;

@end

NS_ASSUME_NONNULL_END
