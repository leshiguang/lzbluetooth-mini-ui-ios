//
//  LZWifiStatus.h
//  LZBluetooth
//
//  Created by tanjian on 2021/2/2.
//

#import <Foundation/Foundation.h>



#import <LZBluetooth/LZDataProtocol.h>
#import <LZBluetooth/LZDeviceSettingProtocol.h>


NS_ASSUME_NONNULL_BEGIN

@interface LZWifiStatus : NSObject <LZDeviceSettingProtocol, LZEncodeDataProtocol>

@end

NS_ASSUME_NONNULL_END
