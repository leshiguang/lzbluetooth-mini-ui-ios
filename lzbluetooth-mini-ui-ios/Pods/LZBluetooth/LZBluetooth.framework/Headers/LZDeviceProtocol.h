//
//  LZDeviceProtocol.h
//  LZBluetooth
//
//  Created by tanjian on 2020/9/27.
//  设备的协议

#import <LZBluetooth/LZBluetoothDefine.h>



NS_ASSUME_NONNULL_BEGIN

@class LZBatteryInfo;
@protocol LZDeviceSettingProtocol;

@protocol LZDeviceProtocol <NSObject>
/// 设备唯一id , 没有带帽好
@property (nonatomic, readonly) NSString *mac;
/// 为了和安卓统一，带冒号的设备地址，根据mac 计算得到，
@property (nonatomic, readonly) NSString *macAddress;
/// CTEI是Elink平台对所有设备的唯一标识 需要在初始化init
@property (nonatomic, readonly, nullable) NSString *ctei;
/// 设备id
@property (nonatomic, readonly, nullable) NSString *deviceId;
/// sn号
@property (nonatomic, readonly, nullable) NSString *sn;
/// 设备名称
@property (nonatomic, readonly, nullable) NSString *name;
/// 设备类型
@property (nonatomic, readonly) LZDeviceType deviceType;
/// 电量状态
@property (nonatomic, readonly, nullable) LZBatteryInfo *batteryInfo;
/// 设备连接状态
@property (nonatomic, readonly) LZDeviceConnectStatus connectStatus;
/// 协议
@property (nonatomic, readonly) LZProtocolType protocolType;
/// 设备信息（主要是180A服务的信息）
@property (nonatomic, readonly, nullable) NSDictionary <kLZBluetoothDeviceInfoKey, NSString *> *deviceInfo;
/// 蓝牙强度
@property (nonatomic, readonly, nullable) NSNumber *rssi;
/// 设备标识码
@property (nonatomic, readonly, nullable) NSString *identifier;


/// 像手环发送数据，必须是支持的数据
/// @param dataModel 数据模型
/// @param completion 回调
- (void)sendDataModel:(id<LZDeviceSettingProtocol>)dataModel completion:(LZSendDataCompletion)completion;


/// 获取手环的一些设置项，456之后支持
/// @param syncType 设置类型
/// @param completion 回调
- (void)getSettingsWithSyncType:(NSUInteger)syncType completion:(LZSendDataCompletion)completion;

@end




NS_ASSUME_NONNULL_END
