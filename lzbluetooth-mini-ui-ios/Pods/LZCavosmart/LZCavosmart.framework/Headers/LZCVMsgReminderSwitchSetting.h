//
//  LZCVMsgReminderSwitchSetting.h
//  LZCavosmart
//
//  Created by tanjian on 2022/8/16.
//

#import <Foundation/Foundation.h>
#import <LZCavosmart/LZCVDataBase.h>

NS_ASSUME_NONNULL_BEGIN

///  消息类型
typedef NS_ENUM(NSUInteger, LZCVMsgType) {
    LZCVMsgTypeCall     = 0x01,
    LZCVMsgTypeQQ       = 0x03,
    LZCVMsgTypeWechat   = 0x05,
    LZCVMsgTypeSMS      = 0x07,
    LZCVMsgTypeLine     = 0x09,
    LZCVMsgTypeTwitter  = 0x0b,
    LZCVMsgTypeFacebook = 0x0e,
    LZCVMsgTypeMessage  = 0x10,
};

/// 消息提醒开关
@interface LZCVMsgReminderSwitchSetting : LZCVDataBase <LZDecodeDataProtocol>

@property (nonatomic, assign) BOOL enable;
@property (nonatomic, assign) LZCVMsgType msgType;

@end

NS_ASSUME_NONNULL_END
