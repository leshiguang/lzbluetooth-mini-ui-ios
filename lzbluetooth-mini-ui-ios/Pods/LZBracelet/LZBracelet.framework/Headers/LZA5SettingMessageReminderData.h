//
//  LZA5SettingMessageReminderData.h
//  LZBluetooth
//
//  Created by tanjian on 2020/10/28.
//  信息提醒使能 AppId(0xB6)
//  注:
//  1、M5 中实现，与原 0x6A 指令同时兼容使用。




#import <LZBracelet/LZA5SettingData.h>

NS_ASSUME_NONNULL_BEGIN

/// Push来电提醒设置类型
typedef NS_ENUM(NSUInteger, LZA5MsgReminderType) {
    /// 来电提醒
    LZA5MsgReminderTypeCall = 1,
    /// 消息提醒
    LZA5MsgReminderTypeMsg = 2,
    /// 断连提醒
    LZA5MsgReminderTypeLost = 3,
    /// 短信提醒
    LZA5MsgReminderTypeSMS = 4,
    /// 微信提醒
    LZA5MsgReminderTypeWX = 5,
    /// QQ提醒
    LZA5MsgReminderTypeQQ = 6,
    /// Facebook提醒
    LZA5MsgReminderTypeFacebook = 7,
    /// Twitter提醒
    LZA5MsgReminderTypeTwitter = 8,
    /// Line提醒
    LZA5MsgReminderTypeLine = 9,
    /// Gmail提醒
    LZA5MsgReminderTypeGmail = 0x0a,
    /// KakaoTalk提醒
    LZA5MsgReminderTypeKakaoTalk = 0x0b,
    /// WhatsApp提醒
    LZA5MsgReminderTypeWhatsApp = 0x0c,
    
//    LZA5CallReminderTypeSEWellness = 253,
    /// SE Wellness提醒
    LZA5MsgReminderTypeSEWellness = 0xfe,
    /// 自定义
    LZA5MsgReminderTypeCustom = 0xff,
};

/// 信息提醒使能 AppId
@interface LZA5SettingMessageReminderData : LZA5SettingData
/// 提醒开关
@property (nonatomic, assign) BOOL enable;
/// 提醒类型
@property (nonatomic, assign) LZA5MsgReminderType reminderType;
/// 包名 （reminderType == LZA5MsgReminderTypeCustom 的时候生效）
@property (nonatomic, strong, nullable) NSString *appId;
/// 延时时间 (s)
@property (nonatomic, assign) UInt8 delay;
/// 震动类型
@property (nonatomic, assign) LZA5VibrationType vibrationType;
/// 震动时长 (s)
@property (nonatomic, assign) UInt8 vibrationTime;
/// 震动等级1（0～9）
@property (nonatomic, assign) UInt8 vibrationLevel1;
/// 震动等级2（0～9）
@property (nonatomic, assign) UInt8 vibrationLevel2;

@end

NS_ASSUME_NONNULL_END
