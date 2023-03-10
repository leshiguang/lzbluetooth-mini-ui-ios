//
//  LZBaseSession.h
//  LZBluetooth
//
//  Created by tanjian on 2020/10/12.
//

#import <Foundation/Foundation.h>
#import <LZBluetooth/LZProtocolManager.h>


NS_ASSUME_NONNULL_BEGIN

@class LZBaseSession;
typedef void(^LZSessionCompletion)(NSData * _Nullable data, __kindof LZBaseSession * _Nullable session, LZBluetoothErrorCode result);

typedef NS_ENUM(UInt8, LZA6AckState) {
    LZA6AckStateSuccess = 1,
    LZA6AckStateFailed = 2,
};

@interface LZBaseSession : NSObject

@property (nonatomic, weak, nullable) id<LZSendDataProtocol> sender;
/// 回调
@property (nonatomic, copy, nullable) LZSessionCompletion completion;

@property (nonatomic, assign) UInt32 cmd;
/// 协商mtu 默认是20
@property (nonatomic, assign) UInt16 mtu;

- (void)didReveiveData:(NSData *)data;

- (void)startWithData:(NSData * _Nullable )data;

@end



NS_ASSUME_NONNULL_END
