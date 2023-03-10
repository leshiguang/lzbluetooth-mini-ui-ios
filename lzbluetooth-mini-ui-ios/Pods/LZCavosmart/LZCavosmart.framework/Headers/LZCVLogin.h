//
//  LZCVLogin.h
//  LZCavosmart
//
//  Created by tanjian on 2022/8/16.
//

#import <Foundation/Foundation.h>
#import <LZCavosmart/LZCVDataBase.h>

NS_ASSUME_NONNULL_BEGIN

@interface LZCVLogin : LZCVDataBase

@property (nonatomic, strong) NSString *userId;

@end

@interface LZCVLoginResp : LZCVDataBase <LZDecodeDataProtocol>

@end

NS_ASSUME_NONNULL_END
