//
//  LZDeviceBindDelegate.h
//  LZBluetooth
//
//  Created by tanjian on 2021/1/13.
//

#import <Foundation/Foundation.h>
#import <LZBluetooth/LZBluetoothDefine.h>


NS_ASSUME_NONNULL_BEGIN

@protocol LZDeviceProtocol;

@protocol LZDeviceBindDelegate <NSObject>

/// 设备状态码
/// @param device 设备
/// @param bindState 绑定状态
- (void)device:(id<LZDeviceProtocol>)device bindStateChanged:(LZBindState)bindState;

@end

NS_ASSUME_NONNULL_END
