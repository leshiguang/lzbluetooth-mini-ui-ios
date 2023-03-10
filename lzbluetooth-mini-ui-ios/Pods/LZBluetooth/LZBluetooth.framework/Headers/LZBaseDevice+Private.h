//
//  LZBaseDevice+Private.h
//  LZBluetooth
//
//  Created by tanjian on 2020/12/25.
//

#import <LZBluetooth/LZBaseDevice.h>
#import <LZBluetooth/LZBatteryInfo.h>
#import <LZBluetooth/LZOtaProtocol.h>
#import <LZBluetooth/LZUserInfoConfig.h>
#import <LZBluetooth/LZDeviceDelegate.h>

NS_ASSUME_NONNULL_BEGIN

@class LZBluetoothDevice;
@class LZDeviceCache;

@interface LZBaseDevice ()

@property (nonatomic, weak, nullable) id<LZDeviceDelegate> delegate;

@property (nonatomic, strong, nullable) NSString *mac;

@property (nonatomic, strong) NSString *ctei;

/// 设备名称
@property (nonatomic, strong, nullable) NSString *name;

/// 设备类型
@property (nonatomic, assign) LZDeviceType deviceType;

/// 设备标识码
@property (nonatomic, strong, nullable) NSString *identifier;



/// 设备是否注册
@property (nonatomic, assign) BOOL isRegister;

/// 工作状态
@property (nonatomic, assign) LZWorkMode workMode;

/// 设备信息（A180服务的信息）
@property (nonatomic, strong) NSMutableDictionary <kLZBluetoothDeviceInfoKey, NSString *> *deviceInfo;

/// 设备信息key value形式
@property (nonatomic, strong) NSDictionary *deviceInfoMap;

@property (nonatomic, strong, nullable) LZBatteryInfo *batteryInfo;
@property (nonatomic, strong, nullable) LZUserInfoConfig *userInfoConfig;

@property (nonatomic, readonly) NSArray *serviceUuids;

@property (nonatomic, strong) LZBluetoothDevice *bleDevice;
@property (nonatomic, weak) LZDeviceCache *deviceCache;
@property (nonatomic, copy, nullable) LZBindDeviceBlock bindBlock;

/// 是否需要读取mac
@property (nonatomic, assign) BOOL needToReadMac;

/// 设备的初始化
/// @param bleDevice 蓝牙设备
- (instancetype)initWithBleDevice:(LZBluetoothDevice *)bleDevice;

/// 读取mac地址
/// @param completion 读取mac地址
- (void)readMacWithCompletion:(LZReadMacCompletion)completion;

/// 解析设备信息的值
/// @param deviceInfo 设备信息
- (void)parseBleDeviceInfo:(NSDictionary <kLZBluetoothDeviceInfoKey, NSData *> *)deviceInfo NS_REQUIRES_SUPER;

/// 解析广播信息
/// @param advertisement 广播
- (void)parseAdvertisement:(NSDictionary *)advertisement;

/// 开始工作
/// @param workMode 工作模式
/// @param config 一些参数
- (void)startWithWorkMode:(LZWorkMode)workMode
                   config:(LZUserInfoConfig * _Nullable)config;

/// 尝试读取设备信息
/// @param workMode 工作模式
/// @param config 一些参数
- (void)tryToReadDeviceInfoWithMode:(LZWorkMode)workMode config:(LZUserInfoConfig * _Nullable)config resultHandler:(LZBindDeviceBlock _Nullable)resultHandler;

/// 取消绑定
- (void)cancelBind NS_REQUIRES_SUPER;

/// ota升级
/// @param path ota文件路径
/// @param progress 进度回调
/// @param completion 结果回调
- (void)otaWithPath:(NSURL *)path
           progress:(LZOtaProgress)progress
         completion:(LZSendDataCompletion)completion;

/// 绑定回调方法
/// @param bindState 绑定状态
- (void)callbackWithBindState:(LZBindState)bindState;

/// 取消ota升级
- (void)cancelOta;

/// 重置状态，
- (void)reset;

/// 读取电量
- (void)readBattery;

@end

NS_ASSUME_NONNULL_END
