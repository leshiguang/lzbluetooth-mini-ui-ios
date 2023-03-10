//
//  LZGLData.h
//  LZGlucose
//
//  Created by tanjian on 2023/2/8.
//

#import <Foundation/Foundation.h>
#import <LZBluetooth/LZMeasurementDataProtocol.h>


NS_ASSUME_NONNULL_BEGIN

@interface LZGLData : NSObject <LZMeasurementDataProtocol>

@property (nonatomic, assign) UInt32 tag;

@property (nonatomic, assign) NSUInteger cmdExt;


@end

NS_ASSUME_NONNULL_END
