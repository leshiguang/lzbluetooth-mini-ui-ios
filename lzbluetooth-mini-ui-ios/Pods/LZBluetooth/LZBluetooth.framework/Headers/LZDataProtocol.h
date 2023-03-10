//
//  LZDataProtocol.h
//  LZBluetooth
//
//  Created by tanjian on 2020/9/27.
//  数据的协议

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


/// 加密数据
@protocol LZEncodeDataProtocol <NSObject>

@property (nonatomic, readonly) NSData *data;

@optional

@end

/// 解密数据
@protocol LZDecodeDataProtocol <NSObject>

@optional

@property (nonatomic, assign) UInt32 tag;

+ (id)instanceWithData:(NSData *)data;

/// 解析数据
/// @param data 数据
/// @param tag 标识
/// @param options 一些参数
- (void)parseData:(NSData *)data tag:(UInt32)tag options:(nullable NSDictionary *)options;

@end

@protocol LZDataProtocol <LZEncodeDataProtocol, LZDecodeDataProtocol>

@end



NS_ASSUME_NONNULL_END
