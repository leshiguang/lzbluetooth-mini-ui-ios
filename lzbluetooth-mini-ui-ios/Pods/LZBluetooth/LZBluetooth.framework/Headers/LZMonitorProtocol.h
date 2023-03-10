//
//  LZMonitorProtocol.h
//  LZBluetooth
//
//  Created by tanjian on 2020/12/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol LZMonitorProtocol <NSObject>

@optional

/// 监听解析后的数据包
/// @param dataModel 解析后的数据包
- (void)onReceiveDataModel:(id)dataModel;

/// 监听解析后的数据包
/// @param dataModel 解析后的数据包
/// @param tag 表示
/// @param options 额外的一些参数
- (void)onReceiveDataModel:(id)dataModel tag:(UInt32)tag options:(nullable NSDictionary *)options;

/// 监听合并的数据包
/// @param data 合包数据的回调
/// @param tag 标识
/// @param options 额外的一些参数
- (void)onReceiveData:(NSData *)data tag:(UInt32)tag options:(nullable NSDictionary *)options;

@end

NS_ASSUME_NONNULL_END
