//
//  LZProtocolManager.h
//  LZBluetooth
//
//  Created by tanjian on 2020/9/27.
//  数据的拆包解包，数据发送与接收的管理者

#import <Foundation/Foundation.h>
#import <LZBluetooth/LZBluetoothDefine.h>
#import <LZBluetooth/LZDataProtocol.h>
#import <LZBluetooth/LZResponse.h>

NS_ASSUME_NONNULL_BEGIN


typedef NSString *LZProtocolChannel;
typedef NSString *LZService;


/// 发送数据类型
typedef NS_ENUM(NSUInteger, LZBluetoothSendType) {
    LZBluetoothSendWithResponse,
    LZBluetoothSendWithoutResponse,
};


@protocol LZSendDataProtocol <NSObject>

/// 发送数据
/// @param data 一帧数据
/// @param channel 通道
/// @param sendType 发送类型，是有相应还是无响应
/// @param completion 发送结果回调
- (void)sendOneFrameData:(NSData *)data
                 channel:(LZProtocolChannel)channel
                sendType:(LZBluetoothSendType)sendType
              completion:(LZSendDataCompletion)completion;

@end

@protocol LZReceiverDataProtocol <NSObject>

/// 收到一帧数据
/// @param data 一帧数据
/// @param channel 通道
- (void)onReceiveOneFrameData:(NSData *)data channel:(LZProtocolChannel)channel service:(LZService)service;

@end


/// 实现了收发数据
@protocol LZBluetoothProtocolManager <LZReceiverDataProtocol>

/// 发送一个数据模型
/// @param dataModel 数据模型
/// @param completion 回调
- (void)sendDataModel:(id<LZEncodeDataProtocol>)dataModel completion:(LZSendDataCompletion)completion;


/// 发送一个数据包过去
/// @param data 数据
/// @param tag 标识
/// @param options 额外参数
/// @param completion 回调
- (void)sendData:(NSData *)data tag:(UInt32)tag options:(nullable NSDictionary *)options completion:(LZCompletion)completion;



@end

NS_ASSUME_NONNULL_END
