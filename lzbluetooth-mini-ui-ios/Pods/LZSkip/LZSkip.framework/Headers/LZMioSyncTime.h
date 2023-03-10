//
//  LZMioSyncTime.h
//  LZBluetooth
//
//  Created by tanjian on 2021/12/1.
//

#import <Foundation/Foundation.h>



#import <LZBluetooth/LZDeviceSettingProtocol.h>

NS_ASSUME_NONNULL_BEGIN

@interface LZMioSyncTime : NSObject <LZDeviceSettingProtocol>

@property (nonatomic, assign) uint32_t utc;
@property (nonatomic, assign) uint32_t timezone;

@end

NS_ASSUME_NONNULL_END
