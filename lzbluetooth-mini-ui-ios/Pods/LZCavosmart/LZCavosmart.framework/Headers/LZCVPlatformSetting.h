//
//  LZCVPlatformSetting.h
//  LZCavosmart
//
//  Created by tanjian on 2022/8/16.
//

#import <Foundation/Foundation.h>
#import <LZCavosmart/LZCVDataBase.h>

NS_ASSUME_NONNULL_BEGIN

/// 平台类型
typedef NS_ENUM(NSUInteger, LZCVPlatformType) {
    LZCVPlatformTypeIOS     = 1,
    LZCVPlatformTypeAndroid = 2,
};


/// 平台
@interface LZCVPlatformSetting : LZCVDataBase <LZDecodeDataProtocol>

/// 平台类型
@property (nonatomic, assign) LZCVPlatformType platformType;

@end

NS_ASSUME_NONNULL_END
