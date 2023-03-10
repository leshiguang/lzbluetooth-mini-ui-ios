//
//  LZBPCommonDefine.h
//  LZBluetooth
//
//  Created by tanjian on 2020/10/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 血压单位
typedef NS_ENUM(NSUInteger, LZA6BloodPressureUnit) {
    LZA6BloodPressureUnitMmHg = 0,
    LZA6BloodPressureUnitKpa = 1,
};

typedef NS_ENUM(NSUInteger, LZBPMeasurementType) {
    LZBPMeasurementTypeBp = 0x4902,
};



NS_ASSUME_NONNULL_END
