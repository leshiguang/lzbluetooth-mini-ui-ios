//
//  LZMioRealtimeMeasureData.h
//  LZBluetooth
//
//  Created by tanjian on 2021/12/7.
//

#import <Foundation/Foundation.h>



#import <LZBluetooth/LZMeasurementDataProtocol.h>
#import <LZSkip/LZMioCommonDefine.h>


NS_ASSUME_NONNULL_BEGIN

@interface LZMioRealtimeMeasureData : NSObject <LZMeasurementDataProtocol>

/// 跳绳模式
@property (nonatomic, assign) LZMioJumpMode jumpMode;

/// 倒计时:倒计时秒数
/// 倒计数:倒计次次数
@property (nonatomic, assign) UInt32 settingContent;

/// 总时长
@property (nonatomic, assign) UInt32 duration;

/// 总次数
@property (nonatomic, assign) UInt32 count;

/// 绊绳次数最大为49次，跳绳组 数最大值为50;跳绳组数=绊 绳次数+1; 有绊绳后，会产生的多组跳 绳数据组数，若无绊绳，则 只有1组
@property (nonatomic, assign) UInt32 groupCount;

/// 0-100
@property (nonatomic, assign) UInt32 battery;

/// 有效时长
@property (nonatomic, assign) UInt32 validDuration;

/// 频次
@property (nonatomic, assign) UInt32 freq;

@end

NS_ASSUME_NONNULL_END
