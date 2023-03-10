//
//  LZDeviceManagerProtocol.h
//  LZBluetooth
//
//  Created by tanjian on 2020/9/27.
//  设备管理者的协议

#import <Foundation/Foundation.h>
#import <LZBluetooth/LZBluetoothDefine.h>
#import <LZBluetooth/LZDeviceSettingProtocol.h>

NS_ASSUME_NONNULL_BEGIN

@class LZUserInfoConfig;
@class LZBaseDevice;
@protocol LZDeviceProtocol;
@protocol LZDeviceDelegate;
@protocol LZDeviceManagerDelegate;
@protocol LZDeviceBindDelegate;

/// 管理设备的协议
@protocol LZDeviceManagerProtocol <NSObject>

/// 代理，主要处理设备状态的改变，接收设备测量数据
@property (nonatomic, weak, nullable) id<LZDeviceDelegate> delegate;

/// 蓝牙开关的代理
@property (nonatomic, weak, nullable) id<LZDeviceManagerDelegate> deviceManagerDelegate;

/// 状态，蓝牙连接状态
@property (nonatomic, readonly) LZBluetoothState state;

/// 蓝牙是否可用
@property (nonatomic, readonly) BOOL isBluetoothEnabled;

/// 用户信息，用于初始化的时候
@property (nonatomic, strong, nullable) LZUserInfoConfig *userInfoConfig;

/// 获取已监听设备的基本信息
@property (nonatomic, readonly, nullable) NSArray <LZBaseDevice *> *bindedDevices;

/// 获取缓存里面的设备
/// @param mac mac地址
/// @return 设备
- (__kindof LZBaseDevice * _Nullable)deviceWithMac:(NSString *)mac;

#pragma mark - 设备的监听
/// 增加已绑定的设备监听
/// @param macString 设备mac
/// @param deviceType 设备类型
- (void)addMonitorDeviceWithMacString:(NSString *)macString
                           deviceType:(LZDeviceType)deviceType;

/// 设置监听一群设备，该方法相当于替换，本来已监听的设备
/// @param devices 设备信息 [{ @"macString":  @"xxxx", @"deviceType": @(LZDeviceTypeBracelet), @"model": @"xxxx"}]
- (void)setDevices:(NSArray <NSDictionary *> *)devices;

/// 删除设备监听
/// @param macString 设备mac
- (void)deleteMonitorDeviceWithMacString:(NSString *)macString;

/// 删除某一类的设备
/// @param deviceType 设备类型
- (void)deleteAllWithDeviceType:(LZDeviceType)deviceType;

/// 删除全部监听的设备，一般在退出登陆的时候调用
- (void)deleteAll;

#pragma mark - 设备的发现
/// 发现指定设备，如果未连接状态，则是发现广播就行了，如果是已链接设备，则需要读取设备信息，解析出来mac地址
/// @param macString mac地址
/// @param deviceType 设备类型
/// @param completion 回调
/// @Param flag 是否需要在系统已连接设备中查找（手环需要这样查找）
- (void)findDevicWithMacString:(NSString *)macString
                    deviceType:(LZDeviceType)deviceType
   shouldSystemConnectedDevice:(BOOL)flag
                    completion:(LZFindDeviceCompletion)completion;

/// 搜索设备
/// @param deviceTypes 设备类型 参考 LZDeviceType，不传默认所有SDK支持设备
/// @param resultHandle 结果
- (void)searchDeviceWithDeviceTypes:(nullable NSSet <NSNumber *> *)deviceTypes
                       resultHandle:(LZSearchResultBlock)resultHandle;

/// 停止搜索
- (void)stopSearch;

#pragma mark - 电量获取 如果有电量跟新，通过 LZDeviceDelegate deviceDidUpdateBatteryStatus 通知更新
- (void)readBatteryWithMacString:(NSString *)macString deviceType:(LZDeviceType)deviceType;

#pragma mark - 设备的升级
/// ota升级
/// @param macString 设备mac
/// @param deviceType 设备类型
/// @param path ota文件路径
/// @param progress 进度
/// @param resultHandler 结果
- (void)otaWithMacString:(NSString *)macString
              deviceType:(LZDeviceType)deviceType
                    path:(NSURL *)path
                progress:(LZOtaProgress)progress
           resultHandler:(LZSendDataCompletion)resultHandler;

/// 取消设备的Ota
/// @param macString mac地址
- (void)cancelOtaWithMacString:(NSString *)macString;

#pragma mark - 设备的绑定
/// 绑定设备
/// @param device 设备
/// @param delegate 监听状态改变的代理
- (void)bindWithDevice:(id<LZDeviceProtocol>)device
          bindDelegate:(id<LZDeviceBindDelegate>)delegate;

/// 取消设备的绑定
/// @param macString mac地址
- (void)cancelBindWithMacString:(NSString *)macString;

/// 输入随机码
/// @param randomCode 随机码
/// @param macString mac地址
/// @param deviceType 设备类型
- (void)inputRandomCode:(NSString *)randomCode macString:(NSString *)macString deviceType:(LZDeviceType)deviceType;

/// 确认绑定，会和设备交互，告诉设备已绑定
/// @param isSuccess 是否成功
/// @param macString mac地址
/// @param deviceType 设备类型
//- (void)confirmSuccess:(BOOL)isSuccess macString:(NSString *)macString deviceType:(LZDeviceType)deviceType;

#pragma mark - 设备设置项更新
/// 向手环发送数据
/// @param dataModel 实现了设置协议的数据模型
/// @param macString 设备的mac地址
/// @param completion 完成回调
- (void)sendDataModel:(id<LZDeviceSettingProtocol>)dataModel
            macString:(NSString *)macString
           completion:(LZSendDataCompletion)completion;

@optional
/// 乐心互联注册设备
/// @param deviceId 设备id
/// @param macString mac地址
/// @param deviceType 设备类型
- (void)registWithDeviceId:(NSString *)deviceId macString:(NSString *)macString deviceType:(LZDeviceType)deviceType API_DEPRECATED("2.0之后由sdk内部去操作，不需要调用", ios(2.0, 2.0));

/// 输入绑定结果
/// @param userNumber 表示用户在设备中分 配的用户号
/// @param bindResult 绑定结果
/// @param macString mac地址
- (void)inputUserNumber:(UInt8)userNumber bindResult:(UInt8)bindResult macString:(NSString *)macString deviceType:(LZDeviceType)deviceType API_DEPRECATED("2.0之后由sdk内部去操作，不需要主动调用", ios(2.0, 2.0));

@end

NS_ASSUME_NONNULL_END
