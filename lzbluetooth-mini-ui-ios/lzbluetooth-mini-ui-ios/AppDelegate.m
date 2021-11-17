//
//  AppDelegate.m
//  lzbluetooth-mini-ui-ios
//
//  Created by tanjian on 2021/1/18.
//

#import "AppDelegate.h"
#import <LZBluetooth/LZBluetooth.h>
#import <YYModel/YYModel.h>
#import <ExternalAccessory/ExternalAccessory.h>

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
    
    
    
//    @"lxe105d9c5fdf0cc93"
    [LZBluetooth initWithAppId:@"lx60ea22583d67ff24"];
    id<LZDeviceManagerProtocol> deviceManager = [LZBluetooth getDeviceManagerWithDeviceTypes:@[
        @(LZDeviceTypeBracelet),
//        @(LZDeviceTypeScale),
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
