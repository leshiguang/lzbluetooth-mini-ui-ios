//
//  LZNetworkUtil.h
//  LZBluetooth
//
//  Created by tanjian on 2021/4/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LZNetworkUtil : NSObject

@property (nonatomic, class, readonly) NSString *host;

/// post请求 （默认是code， msg，data结构）
/// @param url 路径
/// @param params 参数
/// @param completion 回调
+ (NSUInteger)requestPostWithUrl:(NSString *)url
                          params:(id _Nullable)params
                      completion:(void(^)(int code,  NSString * _Nullable msg,  NSDictionary * _Nullable data))completion;

+ (NSUInteger)requestGetWithUrl:(NSString *)url
                         params:(NSDictionary * _Nullable)params
                     completion:(void(^)(int code,  NSString * _Nullable msg,  NSDictionary * _Nullable data))completion;

+ (NSUInteger)getWithPath:(NSString *)path
                   params:(NSDictionary * _Nullable)params
               completion:(void(^)(int code,  NSString * _Nullable msg,  NSDictionary * _Nullable data))completion;

+ (void)cancelTaskWithId:(NSUInteger)taskId;

@end

NS_ASSUME_NONNULL_END
