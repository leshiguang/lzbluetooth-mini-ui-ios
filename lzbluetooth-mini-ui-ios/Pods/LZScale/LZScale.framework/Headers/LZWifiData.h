//
//  LZWifiData.h
//  LZBluetooth
//
//  Created by tanjian on 2020/10/13.
//  配网

#import <Foundation/Foundation.h>



#import <LZBluetooth/LZDataProtocol.h>
#import <LZBluetooth/LZDeviceSettingProtocol.h>
#import <LZBluetooth/LZMeasurementDataProtocol.h>


NS_ASSUME_NONNULL_BEGIN

@interface LZWifiData : NSObject <LZDeviceSettingProtocol, LZEncodeDataProtocol, LZMeasurementDataProtocol>
/// Stores the predefined SSID. 最长32位
@property (nonatomic, strong) NSString *ssid;
/// AP's MAC address
@property (nonatomic, strong) NSData *bssid;
/// Open (0), WEP (1), WPA_PSK (2), WPA2_PSK (3), WPA_WPA_2_PSK(4), WPA2_ENTERPRISE (5).
@property (nonatomic, assign) UInt8 authMode;
/// Records the RSSI value when probe response is received.
@property (nonatomic, assign) char rssi;
/// Connected: AP was connected before. (0 not connected before, 1 connected before)
@property (nonatomic, assign) NSInteger connected;
/// 密码(8~63位)
@property (nonatomic, strong, nullable) NSString *password;

/// 获取wifi状态的时候，有ip
@property (nonatomic, strong, nullable) NSString *ip;

@end



NS_ASSUME_NONNULL_END
