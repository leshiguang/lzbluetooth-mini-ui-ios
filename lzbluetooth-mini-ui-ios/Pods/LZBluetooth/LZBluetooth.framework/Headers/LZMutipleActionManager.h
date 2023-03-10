//
//  LZMutipleActionManager.h
//  LZBluetooth
//
//  Created by tanjian on 2021/11/2.
//

#import <Foundation/Foundation.h>
#import <LZBluetooth/LZMutipleAction.h>


NS_ASSUME_NONNULL_BEGIN

typedef void(^LZPushDataHandler)(id data, LZCompletion callback);

@interface LZMutipleActionManager : NSObject

/// 上下文
@property (nonatomic, readwrite) id context;

@property (nonatomic, strong) LZPushDataHandler pushDataHandler;

/// 收到最新的数据
/// @param newData 新数据
- (BOOL)didReceiveData:(id)newData;

- (void)cancelCurrentSetting;

- (UInt32)executeTask:(id<LZMutipleAction>)task
             callback:(LZCompletion)callback;

- (void)clear;

@end

NS_ASSUME_NONNULL_END
