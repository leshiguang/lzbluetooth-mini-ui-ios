//
//  LZA6TimeSettingData.h
//  LZBluetooth
//
//  Created by tanjian on 2020/10/12.
//

#import <Foundation/Foundation.h>

#import <LZScale/LZA6Data.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_OPTIONS(UInt8, LZA6TimeFlag) {
    LZA6TimeFlagUTC = 1 << 0,
    LZA6TimeFlagTimezone = 1 << 1,
    LZA6TimeFlagTimestamp = 1 << 2,
};

@interface LZA6TimeSettingData : LZA6Data

@property (nonatomic, assign) LZA6TimeFlag flag;

@property (nonatomic, assign) UInt32 utc;

@property (nonatomic, assign) UInt8 timezone;

@property (nonatomic, strong) NSData *timestamp;

@end

NS_ASSUME_NONNULL_END
