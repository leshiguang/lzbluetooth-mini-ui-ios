//
//  AppDelegate.m
//  lzbluetooth-mini-ui-ios
//
//  Created by tanjian on 2021/1/18.
//

#import "AppDelegate.h"

//@import LZBluetooth;
@import LZBluetooth;
@import LZBracelet;
@import LZScale;
@import LZBloodPressure;
@import LZBox;
@import LZSkip;
@import LZCavosmart;
@import LZGlucose;


#import <YYModel/YYModel.h>
#import <ExternalAccessory/ExternalAccessory.h>




@interface AppDelegate () <LZDeviceDelegate>

@end


@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    // 请使用自己的appId
    [LZBluetooth initWithAppId:@"xxx"  options:@{
        @"ctei": @NO,
        @"debug": @YES,
        @"associatedId": @"0"
    }];
    
    
    
    id<LZDeviceManagerProtocol> deviceManager = [LZBluetooth getDeviceManagerWithDeviceTypes:@[

//        @(LZDeviceTypeBracelet),
//        @(LZDeviceTypeScale),
        @(LZDeviceTypeBloodPressure),
//        @(LZDeviceTypeMio),
//        @(LZDeviceTypeMcu),
//        @(LZDeviceTypeCavo),
//        @(LZDeviceTypeG3),
    ]];
    deviceManager.delegate = self;
    
    LZUserInfoConfig *userConfig = [[LZUserInfoConfig alloc] init];
    userConfig.userId = @"0";
    deviceManager.userInfoConfig = userConfig;
    
    NSLog(@"sdkVersion %@", LZBluetooth.version);
    [LZLogger shareInstance].loggerHandler = ^(LZLoggerLevel level, NSString * _Nonnull msg) {
        NSLog(@"[%@]%@", @(level), msg);
    };
    
    return YES;
}



#pragma mark - LZDeviceDelegate
- (void)device:(id<LZDeviceProtocol>)device didReceiveMeasurementData:(id<LZMeasurementDataProtocol>)measurementData {
    NSLog(@"app ====== %@ 收到测量数据 %@", device.mac, [(NSObject *)measurementData yy_modelToJSONString]);
    NSString *model = device.deviceInfo[kLZBluetoothDeviceInfoKeyModelName];
    
    if (measurementData.measurementDataType == LZBraceletMeasurementDataTypeSleep) {
        LZA5SleepData *sleepData = (LZA5SleepData *)measurementData;
        NSLog(@"睡眠数据 %@", sleepData);
    }
}

- (void)deviceInfo:(NSDictionary<NSString *,id> *)deviceInfo didReceiveMeasurementData:(NSDictionary<NSString *,id> *)measurementData {
    NSLog(@"deviceInfo %@ %@",deviceInfo, measurementData);
}

- (void)deviceDidUpdateConnectStatus:(id<LZDeviceProtocol>)device {
    NSLog(@"app ======连接状态发生变化 %ld", device.connectStatus);
}

- (void)deviceDidUpdateBatteryStatus:(id<LZDeviceProtocol>)device {
    NSLog(@"app ====== %@ 收到电量 %@", device.mac, [device.batteryInfo yy_modelToJSONString]);
}

- (void)deviceDidReadyToReceiveData:(id<LZDeviceProtocol>)device {
    NSLog(@"%@ 开始准备接受", device.mac);
}

@end
