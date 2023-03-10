//
//  LZMergeDataManager.h
//  LZBluetooth
//
//  Created by tanjian on 2021/11/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 可合并的数据
@protocol LZMergeable <NSObject>

- (id<LZMergeable>)merger:(id)data;

@end


typedef void(^LZMergedDataHandler)(id<LZMergeable> mergedData);

/// 合并数据管理器
@protocol LZMergeManagerProtocol <NSObject>

/// 数据的处理者
@property (nonatomic, copy) LZMergedDataHandler handler;

/// 处理数据，如果不处理则会返回NO，
- (BOOL)handleData:(id)newData;

/// 清理缓存
- (void)callbackAllData;

@end




NS_ASSUME_NONNULL_END
