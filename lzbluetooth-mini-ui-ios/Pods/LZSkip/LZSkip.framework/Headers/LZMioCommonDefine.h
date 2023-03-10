//
//  LZMioCommonDefine.h
//  LZBluetooth
//
//  Created by tanjian on 2021/12/6.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, LZMioJumpMode) {
    /// 倒计时
    LZMioJumpModeTimeConutdown,
    /// 到计数
    LZMioJumpModeNumberCountdown,
    /// 自由模式
    LZMioJumpModeFree,
};


typedef NS_ENUM(NSUInteger, LZMioMeasurementType) {
    /// 实时数据
    LZMioMeasurementTypeRealtimeData = 0x07000000,
    /// 结果数据
    LZMioMeasurementTypeResultData = 0x07000001,
};

typedef NS_ENUM(NSUInteger, LZDeviceSettingTypeJump) {
    LZDeviceSettingTypeJumpBegin = 0x08000000,
    LZDeviceSettingTypeJumpEnd = 0x08000001,
    LZDeviceSettingTypeMioSyncTime = 0x08000002,
};

