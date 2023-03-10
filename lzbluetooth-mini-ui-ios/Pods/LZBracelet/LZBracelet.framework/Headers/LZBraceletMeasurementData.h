//
//  LZBraceletMeasurementData.h
//  LZBluetooth
//
//  Created by tanjian on 2020/12/10.
//




#import <LZBluetooth/LZMeasurementDataProtocol.h>
#import <LZBracelet/LZA5Data.h>
#import <LZBracelet/LZA5CommonDefine.h>

NS_ASSUME_NONNULL_BEGIN

@interface LZBraceletMeasurementData : LZA5Data <LZMeasurementDataProtocol>


/// 数据类型
@property (nonatomic, readonly) LZMeasurementDataType measurementDataType;


@end

NS_ASSUME_NONNULL_END
