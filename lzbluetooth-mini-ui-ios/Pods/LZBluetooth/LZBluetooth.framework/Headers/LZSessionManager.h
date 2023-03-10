//
//  LZSessionManager.h
//  LZBluetooth
//
//  Created by tanjian on 2021/11/2.
//

#import <Foundation/Foundation.h>
#import <LZBluetooth/LZResponse.h>


NS_ASSUME_NONNULL_BEGIN


typedef void(^LZCompletion)(LZResponse *response);

// 任务会话
@protocol LZSessionProtocol <NSObject>

/// 任务会话id
@property (nonatomic, readonly) UInt32 sid;

/// 任务会话完成
@property (nonatomic, strong, nullable) LZCompletion completion;

/// 超时时间
@property (nonatomic, readwrite) NSTimeInterval timeout;

/// 是否被取消被清理
@property (nonatomic, readonly) BOOL isClear;

/// 结束当前会话
- (void)clear;

/// 开始会话
- (void)start;

/// 回调结束
/// @param response 结束
- (void)callbackWithResponse:(LZResponse *)response;

/// 重置超时时间
- (void)resetTimeout;

/// 清理超时处理
- (void)clearTimeout;


@end


/// 通用任务
@interface LZCommonSession : NSObject <LZSessionProtocol>

@property (nonatomic, assign) UInt32 sid;

/// 任务会话完成
@property (nonatomic, strong, nullable) LZCompletion completion;

/// 超时时间
@property (nonatomic, assign) NSTimeInterval timeout;

/// 是否清除
@property (nonatomic, readonly) BOOL isClear;

@end









NS_ASSUME_NONNULL_END
