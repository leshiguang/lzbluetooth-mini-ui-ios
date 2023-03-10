//
//  LZMcuDefine.h
//  LZBox
//
//  Created by tanjian on 2022/3/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, LZMcuMeasurementType) {
    /// 药盒数据
    LZMcuMeasurementTypeBoxData = 0x08000000,
    /// 设备信息
    LZMcuMeasurementTypeDeviceInfo = 0x08000001,
};

typedef NS_ENUM(NSUInteger, LZDeviceSettingTypeBox) {
    LZDeviceSettingTypeBoxTiming = 0x07000000,
    LZDeviceSettingTypeBoxFind = 0x07000001,
    LZDeviceSettingTypeBoxSyncData = 0x07000002,
};

NS_ASSUME_NONNULL_END
