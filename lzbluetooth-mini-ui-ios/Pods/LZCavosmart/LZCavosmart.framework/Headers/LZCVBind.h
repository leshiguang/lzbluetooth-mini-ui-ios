//
//  LZCVBind.h
//  LZCavosmart
//
//  Created by tanjian on 2022/8/16.
//

#import <Foundation/Foundation.h>
#import <LZCavosmart/LZCVDataBase.h>

NS_ASSUME_NONNULL_BEGIN

@interface LZCVBind : LZCVDataBase

@property (nonatomic, strong) NSString *userId;

@end

@interface LZCVBindResp : LZCVDataBase <LZDecodeDataProtocol>

@property (nonatomic, assign) BOOL success;

@end


@interface LZCVBindCancel : LZCVDataBase

@end





NS_ASSUME_NONNULL_END
