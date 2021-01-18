//
//  LZDeviceManagerViewController.h
//  LZBluetooth Example
//
//  Created by tanjian on 2021/1/14.
//

#import <UIKit/UIKit.h>
#import <LZBluetooth/LZBluetooth.h>

NS_ASSUME_NONNULL_BEGIN

@interface LZDeviceManagerViewController : UIViewController

@property (nonatomic, strong, readonly) id<LZDeviceManagerProtocol> deviceManager;

@property (nonatomic, strong, nullable) LZBaseDevice *device;

/// 可以重写方法刷新UI
- (void)updateUIWithResult:(LZBluetoothErrorCode)result;

- (void)sendData:(__kindof LZA5SettingData *)settingData;

- (id<LZDeviceSettingProtocol>)getSettingDataWithType:(LZBraceletSettingType)settingType;

@end

NS_ASSUME_NONNULL_END
