//
//  LZMcuDeviceInfo.h
//  LZBluetooth
//
//  Created by tanjian on 2021/12/2.
//

#import <Foundation/Foundation.h>



#import <LZBluetooth/LZBluetooth.h>


NS_ASSUME_NONNULL_BEGIN

@interface LZMcuDeviceInfo : LZBaseData

@property (nonatomic, assign) UInt32 battery;
@property (nonatomic, assign) UInt32 version;
@property (nonatomic, strong) NSData *magic;

@end

NS_ASSUME_NONNULL_END
