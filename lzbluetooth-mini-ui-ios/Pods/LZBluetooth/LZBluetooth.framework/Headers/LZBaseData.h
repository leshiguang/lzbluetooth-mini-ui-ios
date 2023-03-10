//
//  LZBaseData.h
//  LZBluetooth
//
//  Created by tanjian on 2021/12/8.
//

#import <Foundation/Foundation.h>
#import <LZBluetooth/LZMeasurementDataProtocol.h>


NS_ASSUME_NONNULL_BEGIN

@interface LZBaseData : NSObject <LZMeasurementDataProtocol>

@property (nonatomic, assign) UInt32 tag;
@property (nonatomic, assign) LZMeasurementDataType measurementDataType;

@property (nonatomic, strong, nullable) NSData *data;


@end

NS_ASSUME_NONNULL_END
