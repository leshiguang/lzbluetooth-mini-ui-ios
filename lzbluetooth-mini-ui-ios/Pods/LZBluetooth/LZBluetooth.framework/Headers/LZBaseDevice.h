//
//  LZBaseDevice.h
//  LZBluetooth
//
//  Created by tanjian on 2020/11/17.
//

#import <Foundation/Foundation.h>
#import <LZBluetooth/LZBluetoothDefine.h>
#import <LZBluetooth/LZDeviceProtocol.h>
#import <LZBluetooth/LZBatteryInfo.h>


NS_ASSUME_NONNULL_BEGIN

/// 代理服务有 LZDeviceDelegate
@interface LZBaseDevice : NSObject <LZDeviceProtocol>

/// 设备id
@property (nonatomic, strong, nullable) NSString *deviceId;

@end


NS_ASSUME_NONNULL_END
