//
//  LZDeviceManagerDelegate.h
//  LZBluetooth
//
//  Created by tanjian on 2020/12/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol LZDeviceManagerProtocol;

@protocol LZDeviceManagerDelegate <NSObject>

/// 蓝牙的状态发生改变
- (void)deviceManagerStateDidUpdate:(__kindof id<LZDeviceManagerProtocol>)manager;

@end

NS_ASSUME_NONNULL_END
