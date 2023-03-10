//
//  LZBPDataCleanSettingData.h
//  LZBluetooth
//
//  Created by tanjian on 2020/10/12.
//

#import <Foundation/Foundation.h>


#import <LZBloodPressure/LZBPData.h>



NS_ASSUME_NONNULL_BEGIN

typedef NS_OPTIONS(UInt32, LZBPDataCleanType) {
    LZBPDataCleanTypeAll = 1 << 0,
    LZBPDataCleanTypeUserInfo = 1 << 1,
    LZBPDataCleanTypeSettingInfo = 1 << 2,
    LZBPDataCleanTypeMeasurementData = 1 << 3
};

@interface LZBPDataCleanSettingData : LZBPData

@property (nonatomic, assign) UInt8 userNumber;

@property (nonatomic, assign) LZBPDataCleanType clear;

@end

NS_ASSUME_NONNULL_END
