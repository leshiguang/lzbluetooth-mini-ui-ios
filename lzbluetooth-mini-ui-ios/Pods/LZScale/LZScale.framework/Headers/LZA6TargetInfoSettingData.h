//
//  LZA6TargetInfoSettingData.h
//  LZBluetooth
//
//  Created by tanjian on 2020/10/12.
//

#import <Foundation/Foundation.h>

#import <LZScale/LZA6Data.h>


NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, LZA6TargetType) {
    LZA6TargetTypeWeight = 1,
};

@interface LZA6TargetInfoSettingData : LZA6Data

@property (nonatomic, assign) UInt8 userNumber;

@property (nonatomic, assign) LZA6TargetType targetType;

@property (nonatomic, assign) UInt32 targetValue;

@end

NS_ASSUME_NONNULL_END
