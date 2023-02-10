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

#import <YYModel/YYModel.h>
#import <ExternalAccessory/ExternalAccessory.h>

<<<<<<< HEAD
=======
@import LZBluetooth;
@import LZBracelet;
@import LZCavosmart;
>>>>>>> afe7026f0e2f43953884b817b1cc7145b79bee82
//#import "LZDataUtil.h"
//#import "LZDataStream.h"


@interface AppDelegate () <LZDeviceDelegate>

@end


@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
//    @"lxe105d9c5fdf0cc93"
    [LZBluetooth initWithAppId:@"lx99c41eaa523f62f2" options:@{
    
    // 请使用自己的appId
    [LZBluetooth initWithAppId:@"xxx"  options:@{
        @"ctei": @NO,
        @"debug": @YES,
        @"associatedId": @"13265792174"
    }];
    
    id<LZDeviceManagerProtocol> deviceManager = [LZBluetooth getDeviceManagerWithDeviceTypes:@[
        @(LZDeviceTypeBracelet),
        @(LZDeviceTypeScale),
        @(LZDeviceTypeBloodPressure),
        @(LZDeviceTypeMio),
        @(LZDeviceTypeMcu)
        @(LZDeviceTypeCavo),
//        @(LZDeviceTypeBloodPressure),
//        @(LZDeviceTypeAlice),
//        @(LZDeviceTypeGlu)
    ]];
    deviceManager.delegate = self;
    
    LZUserInfoConfig *userConfig = [[LZUserInfoConfig alloc] init];
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

/// 新增
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
