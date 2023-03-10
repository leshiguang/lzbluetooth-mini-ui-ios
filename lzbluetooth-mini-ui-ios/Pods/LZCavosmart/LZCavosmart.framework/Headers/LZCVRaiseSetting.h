//
//  LZCVRaiseSetting.h
//  LZCavosmart
//
//  Created by tanjian on 2022/8/16.
//

#import <Foundation/Foundation.h>
#import <LZCavosmart/LZCVDataBase.h>

NS_ASSUME_NONNULL_BEGIN


/// 打开转腕功能设置
@interface LZCVRaiseSetting : LZCVDataBase <LZDecodeDataProtocol>


/// 开关
@property (nonatomic, assign) BOOL enable;

@end

NS_ASSUME_NONNULL_END
