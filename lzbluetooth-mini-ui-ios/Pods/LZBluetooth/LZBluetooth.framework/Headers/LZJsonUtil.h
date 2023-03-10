//
//  LZJsonUtil.h
//  LZBluetooth
//
//  Created by tanjian on 2022/3/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LZJsonUtil : NSObject

+ (nullable id)jsonWithObj:(nullable NSObject *)obj;

+ (nullable NSString *)jsonStringWithObj:(nullable NSObject *)obj;

@end

NS_ASSUME_NONNULL_END
