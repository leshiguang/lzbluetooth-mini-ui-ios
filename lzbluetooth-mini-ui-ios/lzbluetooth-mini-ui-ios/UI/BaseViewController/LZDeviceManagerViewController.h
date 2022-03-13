//
//  LZDeviceManagerViewController.h
//  LZBluetooth Example
//
//  Created by tanjian on 2021/1/14.
//

#import <UIKit/UIKit.h>
@import LZBluetooth;
@import LZScale;
@import LZSkip;
@import LZBloodPressure;
@import LZBracelet;


NS_ASSUME_NONNULL_BEGIN

@interface LZDeviceManagerViewController : UIViewController

@property (nonatomic, strong, readonly) id<LZDeviceManagerProtocol> deviceManager;


@property (nonatomic, strong, nullable) LZBaseDevice *device;

/// 设置类型
@property (nonatomic, assign) LZDeviceSettingType settingType;

@property (nonatomic, strong) NSArray <NSString *> *hours;
@property (nonatomic, strong) NSArray <NSString *> *minutes;

/// 可以重写方法刷新UI
- (void)updateUIWithResult:(LZBluetoothErrorCode)result;

- (void)sendData:(id<LZDeviceSettingProtocol>)settingData;

- (id)settingData;

/// 根据当前的设置类型获取设置列表
- (nullable NSArray <id<LZDeviceSettingProtocol>> *)settingDatas;

- (id)defaultData;

@end

NS_ASSUME_NONNULL_END
