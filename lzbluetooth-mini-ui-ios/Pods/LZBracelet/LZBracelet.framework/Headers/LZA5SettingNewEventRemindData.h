//
//  LZA5SettingNewEventRemindData.h
//  LZBluetooth
//
//  Created by tanjian on 2021/11/12.
//

/**
 * 新的事件提醒（这个事件提醒事项支持三种类型1: 喝水 2: 加餐 3: 睡觉） M6手环支持
 */




#import <LZBracelet/LZA5SettingData.h>


NS_ASSUME_NONNULL_BEGIN

@interface LZA5NewEventData : NSObject

/**
 * 序号 1～5
 */
@property (nonatomic, assign) UInt32 index;
/**
 * 1: 喝水
 * 2: 加餐
 * 3: 睡觉
 */
@property (nonatomic, assign) UInt32 type;

/**
 * 描述内容
 */
@property (nonatomic, strong) NSString *desc;

/**
 * 开关
 */
@property (nonatomic, assign) BOOL enable;

/**
 * 提醒时间的小时
 */
@property (nonatomic, assign) UInt32 hour;

/**
 * 提醒时间的分钟
 */
@property (nonatomic, assign) UInt32 minute;

/**
 * 提醒重复时间
 */
@property (nonatomic, assign) UInt32 repeatTime;

/**
 * 震动方式  Ps：间歇震动方式：2s ON，1s OFF 间歇震动强度：分2档
 */
@property (nonatomic, assign) UInt32 vibrationType;

/**
 * 震动时间
 */
@property (nonatomic, assign) UInt32 vibrationTime;
/**
 * 整栋强度1
 */
@property (nonatomic, assign) UInt32 vibrationLevel1;
/**
 * 震动强度2
     */
@property (nonatomic, assign) UInt32 vibrationLevel2;

@end



@interface LZA5SettingNewEventRemindData : LZA5SettingData

@property (nonatomic, strong) NSArray <LZA5NewEventData *> *list;

@end

NS_ASSUME_NONNULL_END
