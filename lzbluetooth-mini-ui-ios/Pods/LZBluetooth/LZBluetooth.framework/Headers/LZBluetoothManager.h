//
//  LZBluetoothManager.h
//  LZBluetooth
//
//  Created by tanjian on 2020/11/11.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <LZBluetooth/LZBluetoothDefine.h>
#import <LZBluetooth/LZBluetoothDevice.h>


NS_ASSUME_NONNULL_BEGIN

typedef void(^LZDeviceConnectionCompletion)(LZBluetoothDevice * _Nullable bleDevice, LZBluetoothErrorCode errorCode);
typedef void(^LZDiscoverDeviceBlock)(LZBluetoothDevice *bleDevice);
typedef void(^LZStateUpdateBlock)(LZBluetoothState state);

@class LZBluetoothManager;

@protocol LZBluetoothManagerDelegate <NSObject>

/// 设备的连接状态发生改变
- (void)bluetoothManager:(LZBluetoothManager *)manager didUpdateBleDeviceStatus:(LZBluetoothDevice *)bleDevice;
/// 蓝牙的状态发生改变
- (void)bluetoothManagerStateDidUpdate:(LZBluetoothManager *)manager;

@end

@interface LZBluetoothManager : NSObject

@property (nonatomic, weak) id<LZBluetoothManagerDelegate> delegate;

@property (nonatomic, assign) LZBluetoothState state;

@property (nonatomic, copy) LZDiscoverDeviceBlock discoverDeviceBlcok;
@property (nonatomic, copy) LZDeviceConnectionCompletion connectionCompletion;
@property (nonatomic, copy) LZDeviceConnectionCompletion disConnectionCompletion;
@property (nonatomic, copy) LZStateUpdateBlock stateUpdateBlock;

/// 初始化
/// @param queue 蓝牙运行队列
- (instancetype)initWithQueue:(dispatch_queue_t)queue;

- (void)scanForPeripheralsWithServiceUUIDs:(NSArray<CBUUID *> *)uuids options:(NSDictionary<NSString *, id> * _Nullable)options;

- (void)scanForPeripheralsWithServiceUUIDs:(NSArray<CBUUID *> *)uuids options:(NSDictionary<NSString *, id> * _Nullable)options didDiscoverPeripheral:(LZDiscoverDeviceBlock)discoverBlock;

- (void)connectDevice:(LZBluetoothDevice *)device completion:(LZDeviceConnectionCompletion)completion;

- (void)disConnectDevice:(LZBluetoothDevice *)device completion:(LZDeviceConnectionCompletion)compleiton;

- (NSArray <LZBluetoothDevice *> *)retrieveConnectedPeripheralsWithServices:(NSArray <CBUUID *> *)uuids;

/// 停止扫描
- (void)stopScan;

/// 是否正在扫描
- (BOOL)isScaning;

/// 断开蓝牙连接
/// @param device 设备
- (void)cancelDeviceConnection:(LZBluetoothDevice *)device;

@end

NS_ASSUME_NONNULL_END
