//
//  LZScaleDefine.h
//  LZScale
//
//  Created by tanjian on 2022/3/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, LZScaleMeasurementType) {
    /// 体重数据 对应 LZA6MeasurementData
    LZScaleMeasurementTypeWeight = 0x4802,
    /// 体重单位 对应 LZA6UnitSettingData
    LZScaleMeasurementTypeUnit = 0x1004,
    /// wifi 数据 对应 LZWifiData
    LZDeviceMeasurementTypeWifi = 0x101000,
};

typedef NS_ENUM(NSUInteger, LZDeviceSettingTypeScale) {
    /// 体脂秤心率开关
    LZDeviceSettingTypeScaleHR = 0x1007,
    /// 体重单位
    LZDeviceSettingTypeScaleUnit = 0x1004,
    /// wifi 配网
    LZDeviceSettingTypeWifiScan = 0x100000,
    /// wifi 配置网络
    LZDeviceSettingTypeWifiConnect = 0x100001,
    /// wifi 重制
    LZDeviceSettingTypeWifiReset = 0x100007,
    /// 获取wifi 状态
    LZDeviceSettingTypeWifiStatus = 0x100006,
};


NS_ASSUME_NONNULL_END
