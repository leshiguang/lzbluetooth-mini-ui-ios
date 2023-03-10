//
//  LZGLSetting.h
//  LZGlucose
//
//  Created by tanjian on 2023/2/8.
//

#import <Foundation/Foundation.h>
#import <LZBluetooth/LZDeviceSettingProtocol.h>

NS_ASSUME_NONNULL_BEGIN

@interface LZGLSetting : NSObject <LZDeviceSettingProtocol>

@property (nonatomic, assign) UInt32 tag;

@property (nonatomic, assign) NSUInteger cmdExt;

- (instancetype)initWithTag:(UInt32)tag cmdExt:(NSUInteger)cmdExt;

@end

NS_ASSUME_NONNULL_END
