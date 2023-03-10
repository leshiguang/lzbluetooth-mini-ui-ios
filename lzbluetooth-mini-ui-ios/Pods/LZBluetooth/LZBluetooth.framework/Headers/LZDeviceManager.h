//
//  LZDeviceManager.h
//  LZBluetooth
//
//  Created by tanjian on 2020/12/7.
//

#import <Foundation/Foundation.h>
#import <LZBluetooth/LZDeviceManagerProtocol.h>



NS_ASSUME_NONNULL_BEGIN

/// 管理所有的设备
@interface LZDeviceManager : NSObject <LZDeviceManagerProtocol>

/// 可更新的
@property (nonatomic, strong) LZUserInfoConfig *userInfoConfig;

/// 可设置的
@property (nonatomic, weak, nullable) id<LZDeviceDelegate> delegate;

@property (nonatomic, weak, nullable) id<LZDeviceManagerDelegate> deviceManagerDelegate;

/// 初始化一个可以管理多个设备的deviceManager
/// @param deviceTypes 设备类型数组 参考 LZDeviceType
- (instancetype)initWithSupportDeviceTypes:(NSArray <NSNumber *> *)deviceTypes;

- (instancetype)init UNAVAILABLE_ATTRIBUTE;

@end

NS_ASSUME_NONNULL_END
