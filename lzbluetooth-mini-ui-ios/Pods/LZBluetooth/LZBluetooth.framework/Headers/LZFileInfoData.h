//
//  LZFileInfoData.h
//  LZBluetooth
//
//  Created by tanjian on 2021/11/16.
//

#import <Foundation/Foundation.h>
#import <LZBluetooth/LZDeviceSettingProtocol.h>


NS_ASSUME_NONNULL_BEGIN

@interface LZFileInfoData : NSObject <LZDeviceSettingProtocol>

@property (nonatomic, strong) NSData *fileBuf;
@property (nonatomic, strong) LZOtaProgress progress;

@end

NS_ASSUME_NONNULL_END
