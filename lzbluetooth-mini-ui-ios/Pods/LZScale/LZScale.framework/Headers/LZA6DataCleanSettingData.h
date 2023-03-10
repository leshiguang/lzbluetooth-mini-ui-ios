//
//  LZA6DataCleanSettingData.h
//  LZBluetooth
//
//  Created by tanjian on 2020/10/12.
//

#import <Foundation/Foundation.h>

#import <LZScale/LZA6Data.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_OPTIONS(UInt32, LZA6DataCleanType) {
    LZA6DataCleanTypeAll = 1 << 0,
    LZA6DataCleanTypeUserInfo = 1 << 1,
    LZA6DataCleanTypeSettingInfo = 1 << 2,
    LZA6DataCleanTypeMeasurementData = 1 << 3
};

@interface LZA6DataCleanSettingData : LZA6Data

@property (nonatomic, assign) UInt8 userNumber;

@property (nonatomic, assign) LZA6DataCleanType clear;

@end

NS_ASSUME_NONNULL_END
