//
//  LZBluetooth.h
//  Pods
//
//  Created by tanjian on 2020/9/27.
//

#import <LZBluetooth/LZBluetoothDefine.h>
#import <LZBluetooth/LZBaseDevice.h>
#import <LZBluetooth/LZLogger.h>
#import <LZBluetooth/LZDeviceManagerProtocol.h>
#import <LZBluetooth/LZDeviceManagerDelegate.h>
#import <LZBluetooth/LZDeviceDelegate.h>
#import <LZBluetooth/LZDeviceBindDelegate.h>
#import <LZBluetooth/LZUserInfoConfig.h>
#import <LZBluetooth/LZWeatherData.h>

#import <LZBluetooth/LZBaseData.h>
#import <LZBluetooth/LZBaseDeviceManager.h>
#import <LZBluetooth/LZBaseProtocolManager.h>
#import <LZBluetooth/LZBluetoothManager.h>
#import <LZBluetooth/LZCrc32.h>
#import <LZBluetooth/LZDataStream.h>
#import <LZBluetooth/LZDataUtil.h>
#import <LZBluetooth/LZJsonUtil.h>
#import <LZBluetooth/LZDeviceCache.h>
#import <LZBluetooth/LZDeviceManager.h>
#import <LZBluetooth/LZFileInfoData.h>
#import <LZBluetooth/LZGCDTimer.h>
#import <LZBluetooth/LZMeasurementDataProtocol.h>
#import <LZBluetooth/LZMergeDataManager.h>
#import <LZBluetooth/LZMonitorProtocol.h>
#import <LZBluetooth/LZMutipleAction.h>
#import <LZBluetooth/LZMutipleActionManager.h>
#import <LZBluetooth/LZNetworkUtil.h>
#import <LZBluetooth/LZOtaProtocol.h>
#import <LZBluetooth/LZProtocolManager.h>
#import <LZBluetooth/LZResponse.h>
#import <LZBluetooth/LZSessionManager.h>
#import <LZBluetooth/NSDate+LZUtil.h>
#import <LZBluetooth/LZBaseDevice+Private.h>

#import <LZBluetooth/LZBaseSession.h>
#import <LZBluetooth/LZBaseSetting.h>






NS_ASSUME_NONNULL_BEGIN

/// 接入步骤
/// 1、先调用initWithAppId:方法给个apppid
/// 2、获取设备管理者getDeviceManagerWithDeviceType: 如果没有appid，你是获取不到管理者
/// 3、通过设备管理者扫描设备 绑定设备
/// 4、通过LZBaseDevice 可以发送 设置信息 可发送的数据参考 LZA5SettingDataHeader
/// 5、回调LZDeviceDelegate 可以监听设备测量数据 数据类型参考 LZBraceletMeasurementDataHeader
/// 6、如果你想打印日志可以 使用[LZLogger shareInstance].loggerHandler = ^(LZLoggerLevel level, NSString * _Nonnull msg) { NSLog(@"[%@]%@", @(level), msg); };
@interface LZBluetooth : NSObject

/// 获取多个类型设备管理器  ！！！该方法永远只会返回第一次初始化的实例，!!!2.0.0版本后包了，所以需要先引入各种设备的包，然后调用注册之后，才能获取
/// @param deviceTypes 设备参考 LZDeviceType
+ (id<LZDeviceManagerProtocol>)getDeviceManagerWithDeviceTypes:(NSArray <NSNumber *> * _Nullable)deviceTypes;

/// 获取单个设备管理器，获取的实例与上面的方法获取的实例一致
/// @param deviceType 设备参考 LZDeviceType
+ (id<LZDeviceManagerProtocol>)getDeviceManagerWithDeviceType:(LZDeviceType)deviceType;

/// 摧毁上述方法产生的实例
+ (void)destroy;

/// 初始化Appid
/// @param appid appid
+ (void)initWithAppId:(NSString *)appid;


/// 初始化Appid 一般用户不需要设置ctei， 如果ctei打开，则在绑定的时候会走请求ctei的操作
/// @param appid appid
/// @param options 一些配置如下
/// {
///    debug: @YES,                  // 是否是debug模式，默认NO
///    ctei: @YES,                     // 是否需要获取ctei
///    associatedId: "123456"   // 用户标识，默认使用
/// }
///
+ (void)initWithAppId:(NSString *)appid options:(NSDictionary <NSString *, id> * _Nullable)options;

/// 获取天气
/// @param lng 经度
/// @param lat 纬度
/// @param adcode 地区编码，需要第三方地图获取
/// @param completion 回调
+ (void)requestWeatherWithLng:(double)lng
                          lat:(double)lat
                       adcode:(NSString *)adcode
                   completion:(void(^)(NSInteger code, NSString *msg, LZWeatherData *data))completion;

/// 版本号
+ (NSString *)version;

/// 注册设备插件
/// @param deviceType 设备类型
/// @param extension 设备插件
+ (void)registDeviceType:(LZDeviceType)deviceType extention:(Class<LZDeviceManagerProtocol>)extension;

@end

NS_ASSUME_NONNULL_END

