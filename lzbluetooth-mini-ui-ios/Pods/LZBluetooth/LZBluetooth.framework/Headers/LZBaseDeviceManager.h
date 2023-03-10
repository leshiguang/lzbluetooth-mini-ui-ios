//
//  LZBaseDeviceManager.h
//  LZBluetooth
//
//  Created by tanjian on 2020/11/17.
//

#import <Foundation/Foundation.h>

#import <LZBluetooth/LZBaseDevice.h>
#import <LZBluetooth/LZBluetoothManager.h>
#import <LZBluetooth/LZDeviceManagerProtocol.h>
#import <LZBluetooth/LZDeviceDelegate.h>
#import <LZBluetooth/LZDeviceManagerDelegate.h>

NS_ASSUME_NONNULL_BEGIN

@class LZBaseDeviceManager;
@class LZDeviceCache;

/// 设备管理
@interface LZBaseDeviceManager : NSObject <LZDeviceManagerProtocol>

/// 设备的代理
@property (nonatomic, weak, nullable) id<LZDeviceDelegate> delegate;

/// 蓝牙代理
@property (nonatomic, weak, nullable) id<LZDeviceManagerDelegate> deviceManagerDelegate;

/// 登陆时的配置
@property (nonatomic, strong) LZUserInfoConfig *userInfoConfig;

/// 蓝牙设备管理者
@property (nonatomic, readonly) LZBluetoothManager *bleManager;

/// 服务Uuids
@property (nonatomic, readonly) NSArray *serviceUuids;

/// 通过mac或者uuid缓存在内存中
@property (nonatomic, strong) LZDeviceCache *deviceCache;

/// 处理某个类型
@property (nonatomic, readonly) LZDeviceType deviceType;

/// 是否需要从deviceInfo中获取mac
@property (nonatomic, assign) bool needToReadMac;

/// 初始化方法
/// @param config 配置
- (instancetype)initWithConfig:(LZUserInfoConfig *)config;

/// 当蓝牙开关关闭的时候这个方法会调用
- (void)reset;

/// 检查设备是否可用 主要是过滤使用，比如某个uuid对应多个不同协议的设备 可重写， 默认是YES
/// @param blueDevice 蓝牙设备
- (BOOL)checkDeviceVilid:(LZBluetoothDevice *)blueDevice;


@end

NS_ASSUME_NONNULL_END
