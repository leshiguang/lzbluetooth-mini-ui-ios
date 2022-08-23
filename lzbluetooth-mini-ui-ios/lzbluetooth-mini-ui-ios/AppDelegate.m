//
//  AppDelegate.m
//  lzbluetooth-mini-ui-ios
//
//  Created by tanjian on 2021/1/18.
//

#import "AppDelegate.h"

#import <YYModel/YYModel.h>
#import <ExternalAccessory/ExternalAccessory.h>

@import LZBluetooth;
@import LZBracelet;
@import LZCavosmart;
//#import "LZDataUtil.h"
//#import "LZDataStream.h"


@interface AppDelegate () <LZDeviceDelegate>

@end



@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
//    LZDataStream *stream = [LZDataStream streamWithCapacity:32];
//    NSLog(@"data0 %@", stream.data);
//    [stream writeByte:1];
//    NSLog(@"data1 %@", stream.data);
//    [stream writeByte:2];
//    NSLog(@"data2 %@", stream.data);
//    [stream writeByte:3];
//    NSLog(@"data3 %@", stream.data);
    
//    Byte byte[] = { 0xb0, 0x38, 0x50, 0x60};
//    double ret =  lzz_sfloat_value(byte);
//    NSLog(@"ret %f", ret);
//    [self init_crc_table];
//    NSString *hexString = @"97DE117D5FCC";
//    NSData *data = [LZDataUtil convertHexStrToData:hexString];
//    NSData *reData = [LZDataUtil reverseData:data];
//    NSString *retString = [LZDataUtil hexStringFromData:reData];
    
    // 请使用自己的appId
    [LZBluetooth initWithAppId:@"xxx"  options:@{
        @"ctei": @NO,
        @"debug": @YES,
        @"associatedId": @"xxxx"
    }];
    id<LZDeviceManagerProtocol> deviceManager = [LZBluetooth getDeviceManagerWithDeviceTypes:@[
        @(LZDeviceTypeBracelet),
        @(LZDeviceTypeScale),
        @(LZDeviceTypeCavo),
//        @(LZDeviceTypeBloodPressure),
//        @(LZDeviceTypeAlice),
//        @(LZDeviceTypeGlu)
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
    NSLog(@"%@ 收到测量数据 %@", device.mac, [(NSObject *)measurementData yy_modelToJSONString]);
    
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
    NSLog(@"连接状态发生变化 %ld", device.connectStatus);
}

- (void)deviceDidUpdateBatteryStatus:(id<LZDeviceProtocol>)device {
    NSLog(@"%@ 收到电量 %@", device.mac, [device.batteryInfo yy_modelToJSONString]);
}

- (void)deviceDidReadyToReceiveData:(id<LZDeviceProtocol>)device {
    NSLog(@"%@ 开始准备接受", device.mac);
}

@end
