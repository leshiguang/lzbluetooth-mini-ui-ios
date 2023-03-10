//
//  LZDeviceSettingProtocol.h
//  LZBluetooth
//
//  Created by tanjian on 2021/1/15.
//

#import <Foundation/Foundation.h>
#import <LZBluetooth/LZBluetoothDefine.h>
#import <LZBluetooth/LZDataProtocol.h>

NS_ASSUME_NONNULL_BEGIN

/// 设置项类型的协议
@protocol LZDeviceSettingProtocol <LZEncodeDataProtocol>

/// 对外别名
@property (nonatomic, readonly) LZDeviceSettingType settingType;

@optional
/// 指令
@property (nonatomic, readonly) UInt32 tag;

@end


NS_ASSUME_NONNULL_END
