//
//  LZResponse.h
//  LZBluetooth
//
//  Created by tanjian on 2021/11/2.
//

#import <Foundation/Foundation.h>
#import <LZBluetooth/LZBluetoothDefine.h>


NS_ASSUME_NONNULL_BEGIN

@class LZResponse;

typedef void(^LZCompletion)(LZResponse *response);
typedef void(^LZProgress)(double progress);



@interface LZResponse : NSObject

/// 任务id
@property (nonatomic, assign) UInt32 sid;
/// 此次任务的结果
@property (nonatomic, assign) LZBluetoothErrorCode errorCode;
/// 标签
@property (nonatomic, assign) UInt32 tag;
/// 错误码提示
@property (nonatomic, strong) NSString *msg;
/// 附带参数
@property (nonatomic, strong, nullable) NSData *data;
/// 附带参数
@property (nonatomic, strong, nullable) id parsedData;
/// 格外的一些参数
@property (nonatomic, strong, nullable) NSDictionary *extra;

/// 是否成功
- (BOOL)isSuccess;

+ (instancetype)errorCode:(LZBluetoothErrorCode)errorCode;

+ (instancetype)errorCode:(LZBluetoothErrorCode)errorCode data:(nullable NSData *)data sid:(UInt32)sid;

+ (instancetype)errorCode:(LZBluetoothErrorCode)errorCode data:(nullable NSData *)data sid:(UInt32)sid tag:(UInt32)tag;

+ (instancetype)success;

+ (instancetype)errorCode:(LZBluetoothErrorCode)errorCode parsedData:(id)parsedData;


@end

NS_ASSUME_NONNULL_END
