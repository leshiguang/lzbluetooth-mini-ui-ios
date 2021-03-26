//
//  AppDelegate.m
//  lzbluetooth-mini-ui-ios
//
//  Created by tanjian on 2021/1/18.
//

#import "AppDelegate.h"
#import <LZBluetooth/LZBluetooth.h>
#import <YYModel/YYModel.h>

@interface AppDelegate () <LZDeviceDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [LZBluetooth initWithAppId:@"com.leshiguang.saas.rbac.demo.appid"];
    id<LZDeviceManagerProtocol> deviceManager = [LZBluetooth getDeviceManagerWithDeviceTypes:@[
        @(LZDeviceTypeBracelet),
        @(LZDeviceTypeScale),
        @(LZDeviceTypeBloodPressure)
    ]];
    deviceManager.delegate = self;
    
    LZUserInfoConfig *userConfig = [[LZUserInfoConfig alloc] init];
    deviceManager.userInfoConfig = userConfig;
    
    [LZLogger shareInstance].loggerHandler = ^(LZLoggerLevel level, NSString * _Nonnull msg) {
        NSLog(@"[%@]%@", @(level), msg);
    };
    return YES;
}

#pragma mark - LZDeviceDelegate
- (void)device:(id<LZDeviceProtocol>)device didReceiveMeasurementData:(id<LZMeasurementDataProtocol>)measurementData {
    NSLog(@"%@ 收到测量数据 %@", device.mac, measurementData);
    
    if (measurementData.measurementDataType == LZBraceletMeasurementDataTypeSleep) {
        LZA5SleepData *sleepData = (LZA5SleepData *)measurementData;
        NSLog(@"睡眠数据 %@", sleepData);
    }
}

- (void)deviceDidUpdateConnectStatus:(id<LZDeviceProtocol>)device {
    NSLog(@"连接状态发生变化 %ld", device.connectStatus);
}

- (void)deviceDidUpdateBatteryStatus:(id<LZDeviceProtocol>)device {
    NSLog(@"%@ 收到电量 %@", device.mac, [device.batteryInfo yy_modelToJSONString]);
}

- (void)deviceDidReadyToReceiveData:(id<LZDeviceProtocol>)device {
    NSLog(@"%@ 开始准备接受", device.mac);
}

@end
