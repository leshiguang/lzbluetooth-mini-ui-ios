//
//  LZLogger.h
//  LZBluetooth
//
//  Created by tanjian on 2020/12/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, LZLoggerLevel) {
    /// 错误
    LZLoggerLevelError = 1,
    /// 警告
    LZLoggerLevelWarning = 2,
    /// 信息
    LZLoggerLevelInfo = 3,
    /// 信息
    LZLoggerLevelVerbose = 4,
    /// 测试
    LZLoggerLevelDebug = 5,

};

typedef NS_ENUM(NSUInteger, LZLoggerType) {
    /// 蓝牙
    LZLoggerTypeBle = 1,
    /// 网络请求
    LZLoggerTypeNetwork = 2,
    /// 应用
    LZLoggerTypeApp = 3,
    /// 通用
    LZLoggerTypeGeneral = 4
};

#define LZLog(mac, dev, lv, lt, fmt, ...) [LZLogger logWithMac:mac deviceId:dev level:lv logType:lt msg:[NSString stringWithFormat:fmt, ##__VA_ARGS__]]

#define LZGeneralLog(mac, fmt, ...) LZLog(mac, nil, LZLoggerLevelDebug, LZLoggerTypeGeneral, fmt, ##__VA_ARGS__)
#define LZNetworkLog(fmt, ...) LZLog(nil, nil, LZLoggerLevelDebug, LZLoggerTypeNetwork, fmt, ##__VA_ARGS__)
#define LZNetworkErrorLog(fmt, ...) LZLog(nil, nil, LZLoggerLevelError, LZLoggerTypeNetwork, fmt, ##__VA_ARGS__)
#define LZBleDebugLog(mac, dev, fmt, ...) LZLog(mac, dev, LZLoggerLevelDebug, LZLoggerTypeBle, fmt, ##__VA_ARGS__)
#define LZBleErrorLog(mac, dev, fmt, ...) LZLog(mac, dev, LZLoggerLevelError, LZLoggerTypeBle, fmt, ##__VA_ARGS__)
#define LZAppErrorLog(mac, fmt, ...) LZLog(mac, nil, LZLoggerLevelError, LZLoggerTypeApp, fmt, ##__VA_ARGS__)
#define LZAppWarnLog(mac, fmt, ...) LZLog(mac, nil, LZLoggerLevelWarning, LZLoggerTypeApp, fmt, ##__VA_ARGS__)
#define LZAppDebugLog(mac, fmt, ...) LZLog(mac, nil, LZLoggerLevelDebug, LZLoggerTypeApp, fmt, ##__VA_ARGS__)


typedef void(^LZLoggerHander)(LZLoggerLevel level, NSString *msg);

@interface LZLogger : NSObject

+ (instancetype)shareInstance;

@property (nonatomic, strong, null_resettable) LZLoggerHander loggerHandler;


/// 打印日志
/// @param mac mac标识
/// @param deviceId 设备标识
/// @param level 等级
/// @param logType 类型
/// @param msg 日志
+ (void)logWithMac:(nullable NSString *)mac
          deviceId:(nullable NSString *)deviceId
             level:(LZLoggerLevel)level
           logType:(LZLoggerType)logType
               msg:(NSString *)msg;

+ (void)initWithOptions:(NSDictionary *)options;

@end

NS_ASSUME_NONNULL_END
