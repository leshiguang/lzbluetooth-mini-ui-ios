//
//  LZBaseSetting.h
//  LZBluetooth
//
//  Created by tanjian on 2021/12/8.
//

#import <Foundation/Foundation.h>
#import <LZBluetooth/LZDeviceSettingProtocol.h>


NS_ASSUME_NONNULL_BEGIN

@interface LZBaseSetting : NSObject <LZDeviceSettingProtocol>

@property (nonatomic, strong, nullable) NSData *data;
@property (nonatomic, assign) LZDeviceSettingType settingType;
@property (nonatomic, assign) UInt32 tag;

@end

NS_ASSUME_NONNULL_END
