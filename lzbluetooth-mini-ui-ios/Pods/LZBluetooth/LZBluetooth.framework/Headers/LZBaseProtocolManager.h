//
//  LZBaseProtocolManager.h
//  LZBluetooth
//
//  Created by tanjian on 2020/10/9.
//

#import <Foundation/Foundation.h>

#import <LZBluetooth/LZProtocolManager.h>
#import <LZBluetooth/LZMonitorProtocol.h>
#import <LZBluetooth/LZSessionManager.h>


NS_ASSUME_NONNULL_BEGIN

@interface LZDataSession : LZCommonSession <LZReceiverDataProtocol>

/// 额外的一些参数
@property (nonatomic, strong, nullable) NSDictionary *options;

/// 数据
@property (nonatomic, strong, nullable) NSData *data;

/// 标识
@property (nonatomic, assign) UInt32 tag;

/// 发送者
@property (nonatomic, weak) id<LZSendDataProtocol> sender;

/// 每包最大字节数
@property (nonatomic, assign) UInt32 mtu;

@end


@interface LZBaseProtocolManager : NSObject <LZBluetoothProtocolManager>
@property (nonatomic, weak) LZBaseDevice <LZMonitorProtocol> *monitor;
@property (nonatomic, weak) id<LZSendDataProtocol> sender;
@property (nonatomic, assign) UInt32 mtu;

/// 正在发送的session
@property (nonatomic, strong, nullable) __kindof LZDataSession *sendingSession;

/// 正在接受的session
@property (nonatomic, strong, nullable) __kindof LZDataSession *receivingSession;

/// 将要发送的会话
@property (nonatomic, strong) NSMutableArray <__kindof LZDataSession *> *senderSessions;



/// 重置
- (void)reset;

/// overwritable 创建一个发数据的会话
/// @param data 数据包
/// @param tag 标识
/// @param options 额外参数
- (__kindof LZDataSession *)createSenderSessionWithData:(NSData *)data tag:(UInt32)tag options:(nullable NSDictionary *)options;

/// overwritable 创建一个接收数据的会话
/// @param data 数据包
/// @param options 额外参数
- (__kindof LZDataSession *)createReceiveSessionWithData:(NSData *)data options:(nullable NSDictionary *)options;

/// 尝试执行会话
- (void)tryToDispatchSession;

@end

NS_ASSUME_NONNULL_END
