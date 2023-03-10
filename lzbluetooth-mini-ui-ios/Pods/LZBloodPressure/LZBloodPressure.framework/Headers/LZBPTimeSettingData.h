//
//  LZBPTimeSettingData.h
//  LZBluetooth
//
//  Created by tanjian on 2020/10/12.
//

#import <Foundation/Foundation.h>


#import <LZBloodPressure/LZBPData.h>


NS_ASSUME_NONNULL_BEGIN

typedef NS_OPTIONS(UInt8, LZBPTimeFlag) {
    LZBPTimeFlagUTC = 1 << 0,
    LZBPTimeFlagTimezone = 1 << 1,
    LZBPTimeFlagTimestamp = 1 << 2,
};

@interface LZBPTimeSettingData : LZBPData

@property (nonatomic, assign) LZBPTimeFlag flag;

@property (nonatomic, assign) UInt32 utc;

@property (nonatomic, assign) UInt8 timezone;

@property (nonatomic, strong) NSData *timestamp;

@end

NS_ASSUME_NONNULL_END
