//
//  LZMioResultMeasureData.h
//  LZBluetooth
//
//  Created by tanjian on 2021/12/7.
//

#import <Foundation/Foundation.h>



#import <LZSkip/LZMioCommonDefine.h>
#import <LZBluetooth/LZMeasurementDataProtocol.h>

NS_ASSUME_NONNULL_BEGIN

@interface LZMioResultMeasureData : NSObject <LZMeasurementDataProtocol>

/// 0-表示当前跳神的结果。 1-表示历史数据的结果
@property (nonatomic, assign) UInt32 type;

/// 测量时间
@property (nonatomic, assign) UInt32 utc;

/// 跳绳模式
@property (nonatomic, assign) LZMioJumpMode jumpMode;

/// 倒计时跳:设置倒计时秒数; 倒计数跳:设置倒计次次数
@property (nonatomic, assign) UInt32 settingContent;

/// 总时长
@property (nonatomic, assign) UInt32 duration;

/// 总次数
@property (nonatomic, assign) UInt32 count;

/// 平均频次
@property (nonatomic, assign) UInt32 avgFreq;

/// 最大频次
@property (nonatomic, assign) UInt32 maxFreq;

/// 最大连跳次数
@property (nonatomic, assign) UInt32 maxContinueCount;

/// 绊绳次数最大为49次，跳绳组 数最大值为50;跳绳组数=绊 绳次数+1; 有绊绳后，会产生的多组跳 绳数据组数，若无绊绳，则 只有1组
@property (nonatomic, assign) UInt32 groupCount;

/// 数据格式如 {"time": 10, "count": 3 }  标识在time时间内，跳了count次
@property (nonatomic, strong, nullable) NSArray <NSMutableDictionary *> *list;

@end

NS_ASSUME_NONNULL_END
