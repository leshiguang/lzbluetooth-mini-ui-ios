//
//  LZA5SettingEventRemindData.h
//  LZBluetooth
//
//  Created by tanjian on 2020/10/22.
//  事件提醒信息到手环(0xA3)

#import <Foundation/Foundation.h>



#import <LZBracelet/LZA5SettingData.h>
#import <LZBluetooth/LZMeasurementDataProtocol.h>
#import <LZBluetooth/LZMergeDataManager.h>

NS_ASSUME_NONNULL_BEGIN

/// 事件提醒（带标签的闹钟提醒）
@interface LZA5SettingEventRemindData : LZA5SettingData

/// 事件提醒的索引， 需要开发者自己计算，唯一ID （最多5个提醒） HR6 （最多支持10个）
@property (nonatomic, assign) UInt8 index;
/// 提醒内容
@property (nonatomic, strong) NSString *des;
/// 开关
@property (nonatomic, assign) BOOL enable;
/// 提醒时间小时
@property (nonatomic, assign) UInt8 hour;
/// 提醒时间分钟
@property (nonatomic, assign) UInt8 minute;
/// 重复日期（星期）
@property (nonatomic, assign) LZA5RepeatTimeFlag repeatFlag;
/// 震动方式
@property (nonatomic, assign) LZA5VibrationType vibrationType;
/// 震动时长（0～60）
@property (nonatomic, assign) UInt8 vibrationTime;
/// 震动等级1（0～9）
@property (nonatomic, assign) UInt8 vibrationLevel1;
/// 震动等级2（0～9
@property (nonatomic, assign) UInt8 vibrationLevel2;
/// 时间戳
@property (nonatomic, assign) long long ringTime;

/// 以下 HR6支持
@property (nonatomic, assign) BOOL napEnable;
@property (nonatomic, assign) BOOL lightSleepEnable;
@property (nonatomic, assign) BOOL isDelete;
@property (nonatomic, assign) UInt32 napAlertTime;
@property (nonatomic, assign) UInt32 lightSleepAlertTime;

@end

@interface LZA5GetSettingEventRemindData : LZA5SettingData <LZMergeable, LZMeasurementDataProtocol>

@property (nonatomic, strong) NSArray <LZA5SettingEventRemindData *> *list;

- (void)parseData:(NSData *)data;

@end

NS_ASSUME_NONNULL_END
