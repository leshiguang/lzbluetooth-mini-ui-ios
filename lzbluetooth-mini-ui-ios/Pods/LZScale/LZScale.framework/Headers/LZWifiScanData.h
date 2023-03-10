//
//  LZA6WifiScanSettingData.h
//  LZBluetooth
//
//  Created by tanjian on 2021/1/29.
//





#import <LZBluetooth/LZDeviceSettingProtocol.h>
#import <LZBluetooth/LZDataProtocol.h>


NS_ASSUME_NONNULL_BEGIN

/// 扫描服务wifi热点
@interface LZWifiScanData : NSObject <LZDeviceSettingProtocol, LZEncodeDataProtocol>
/// Enable to scan AP whose SSID is hidden; enable (1), disable (0）
@property (nonatomic, assign) BOOL showHidden;
/// Scan type, active or passive; active (0), passive (1)
@property (nonatomic, assign) BOOL scanType;

/// 为了防止一次搜索不到的情况，可以搜索多次，每次搜索大概 4s   默认值1,  取值范围[1, 5]
@property (nonatomic, assign) int numberOfScan;

@end


NS_ASSUME_NONNULL_END
