//
//  LZDeviceCache.h
//  LZBluetooth
//
//  Created by tanjian on 2020/11/18.
//

#import <Foundation/Foundation.h>

@class LZBaseDevice;

NS_ASSUME_NONNULL_BEGIN

@interface LZDeviceCache : NSObject

- (nullable __kindof LZBaseDevice *)deviceForMacString:(NSString *)macString;

- (nullable __kindof LZBaseDevice *)deviceForUuid:(NSString *)uuid;

- (void)updateDevice:(LZBaseDevice *)device;

- (void)removeForMacString:(NSString *)macString;

- (void)removeForUuid:(NSString *)uuid;

- (void)removeAll;

@end

NS_ASSUME_NONNULL_END
