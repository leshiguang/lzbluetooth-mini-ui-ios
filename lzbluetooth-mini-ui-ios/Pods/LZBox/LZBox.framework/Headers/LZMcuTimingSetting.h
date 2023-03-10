//
//  LZMcuTimingSetting.h
//  LZBluetooth
//
//  Created by tanjian on 2021/12/2.
//



#import <LZBluetooth/LZDeviceSettingProtocol.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_OPTIONS(NSUInteger, LZMcuWeek) {
    /// 星期一
    LZMcuWeekMon        = 1 << 0,
    /// 星期二
    LZMcuWeekTues       = 1 << 1,
    /// 星期三
    LZMcuWeekWed        = 1 << 2,
    /// 星期四
    LZMcuWeekThur       = 1 << 3,
    /// 星期五
    LZMcuWeekFri        = 1 << 4,
    /// 星期六
    LZMcuWeekSat        = 1 << 5,
    /// 星期天
    LZMcuWeekSun        = 1 << 6,
};

@interface LZMcuTimeData : NSObject
/// 时
@property (nonatomic, assign) UInt32 hour;
/// 分
@property (nonatomic, assign) UInt32 min;
/// 秒
@property (nonatomic, assign) UInt32 sec;
/// 重复天
@property (nonatomic, assign) LZMcuWeek week;

@end

@interface LZMcuTimingSetting : NSObject <LZDeviceSettingProtocol>

/// 定时设置（最多设置9个）条目为0的时候表示删除该编号所有定时器
@property (nonatomic, strong) NSArray <LZMcuTimeData *> *times;

/// 药格编号（1-4）
@property (nonatomic, assign) UInt32 index;

@end

NS_ASSUME_NONNULL_END
