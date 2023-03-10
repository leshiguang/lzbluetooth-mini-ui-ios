//
//  LZBluetoothDevice.h
//  LZBluetooth
//
//  Created by tanjian on 2020/11/11.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <LZBluetooth/LZProtocolManager.h>
#import <LZBluetooth/LZBluetoothDefine.h>


NS_ASSUME_NONNULL_BEGIN

@class LZBluetoothManager;

@interface LZBluetoothDevice : NSObject <LZSendDataProtocol>

/// mac标识
@property (nonatomic, strong, nullable) NSString *mac;
/// 数据的处理者
@property (nonatomic, weak) id<LZReceiverDataProtocol> receiver;
/// 设备名称
@property (nonatomic, readonly) NSString *name;
/// 设备连接状态
@property (nonatomic, readonly) LZDeviceConnectStatus connectStatus;
/// 苹果系统的蓝牙设备对象
@property (nonatomic, strong) CBPeripheral *peripheral;

/// 设备信息（主要是A180服务的信息）
@property (nonatomic, strong) NSDictionary <kLZBluetoothDeviceInfoKey, NSData *> *deviceInfo;

@property (nonatomic, strong) NSMutableDictionary <NSString *, CBCharacteristic *> *charactors;

/// 设备蓝牙信号强度
@property (nonatomic, strong, nullable) NSNumber *rssi;

/// 广播信息
@property (nonatomic, strong, nullable) NSDictionary <NSString *, id> *advertisement;

@property (nonatomic, copy, nullable) LZDeviceHandlerCompletion discoverServicesCompletion;
@property (nonatomic, copy, nullable) LZDeviceHandlerCompletion readRssiCompletion;
@property (nonatomic, copy, nullable) LZDeviceHandlerCompletion setCharNotifyCompletion;

@property (nonatomic, assign) BOOL didDiscoverServices;
@property (nonatomic, assign) BOOL didReadDeviceInfo;

@property (nonatomic, weak) LZBluetoothManager *bluetoothManager;

- (instancetype)initWithCBPeripheral:(CBPeripheral *)peripheral;

- (void)readRssiWithCompletion:(LZDeviceHandlerCompletion)completion;

- (void)discoverServicesAndCharacteristicsWithUUID:(NSArray<CBUUID *> *)serviceUUID completion:(LZDeviceHandlerCompletion)compleion;


- (void)readChar:(NSString *)charUUID completion:(LZDeviceReadCharValueCompletion _Nullable)completion;


- (void)updateChars:(NSArray <NSString *> *)chars notifyValue:(BOOL)value completion:(LZDeviceHandlerCompletion)completion;

/// 直接断开链接
- (void)disConnected;

/// 重置状态
- (void)reset;

@end

NS_ASSUME_NONNULL_END
