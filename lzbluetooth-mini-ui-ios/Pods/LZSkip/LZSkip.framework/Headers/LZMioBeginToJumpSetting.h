//
//  LZMioBeginToJumpSetting.h
//  LZBluetooth
//
//  Created by tanjian on 2021/12/1.
//



#import <LZBluetooth/LZDeviceSettingProtocol.h>
#import <LZBluetooth/LZDataProtocol.h>
#import <LZSkip/LZMioCommonDefine.h>


NS_ASSUME_NONNULL_BEGIN

@interface LZMioBeginToJumpSetting : NSObject <LZDeviceSettingProtocol>

@property (nonatomic, assign) LZMioJumpMode jumpMode;
@property (nonatomic, assign) uint32_t settingContent;
@property (nonatomic, assign) uint32_t utc;
@property (nonatomic, assign) uint32_t numberOfCountdown;

@end

NS_ASSUME_NONNULL_END
