//
//  LZMeasurementDataProtocol.h
//  LZBluetooth
//
//  Created by tanjian on 2021/1/13.
//

#import <Foundation/Foundation.h>
#import <LZBluetooth/LZBluetoothDefine.h>
#import <LZBluetooth/LZDataProtocol.h>



NS_ASSUME_NONNULL_BEGIN

@protocol LZMeasurementDataProtocol <LZDecodeDataProtocol>

/// 测量数据类型
@property (nonatomic, readonly) LZMeasurementDataType measurementDataType;

@end

NS_ASSUME_NONNULL_END
