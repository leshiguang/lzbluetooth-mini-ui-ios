//
//  LZDeviceDelegate.h
//  LZBluetooth
//
//  Created by tanjian on 2020/12/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol LZDeviceProtocol;
@protocol LZMeasurementDataProtocol;

@protocol LZDeviceDelegate <NSObject>

@optional

/// 设备的连接状态发生改变
/// @param device 设备
- (void)deviceDidUpdateConnectStatus:(id<LZDeviceProtocol>)device;

/// 设备的Rssi更新
/// @param device 设备
//- (void)deviceDidUpdateRssi:(id<LZDeviceProtocol>)device;

/// 设备的电量状态发生变化
/// @param device 设备
- (void)deviceDidUpdateBatteryStatus:(id<LZDeviceProtocol>)device;

/// 设备已经准备好接收数据了
/// @param device 设备
- (void)deviceDidReadyToReceiveData:(id<LZDeviceProtocol>)device;

/// 设备接收到测量数据
/// @param device 设备
/// @param measurementData 测量数据
- (void)device:(id<LZDeviceProtocol>)device didReceiveMeasurementData:(id<LZMeasurementDataProtocol>)measurementData;

/// 设备接收到测量数据
/// @param deviceInfo 设备信息
/// @param measurementData 测量数据
- (void)deviceInfo:(NSDictionary <NSString *, id> *)deviceInfo didReceiveMeasurementData:(NSDictionary <NSString *, id> *)measurementData;

@end

NS_ASSUME_NONNULL_END
