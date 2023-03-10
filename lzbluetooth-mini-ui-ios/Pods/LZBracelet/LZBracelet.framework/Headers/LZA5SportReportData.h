//
//  LZA5SportModeData.h
//  LZBluetooth
//
//  Created by tanjian on 2020/10/22.
//  手环发送运动报告数据到 APP(0xE2)

#import <Foundation/Foundation.h>




#import <LZBracelet/LZA5CommonDefine.h>
#import <LZBracelet/LZBraceletMeasurementData.h>

NS_ASSUME_NONNULL_BEGIN

/// 暂停与重新开始 公共类型
@interface LZA5TimeStateData : NSObject
/// 暂停
@property (nonatomic, assign) UInt32 pauseUtc;
/// 重新开始时间戳
@property (nonatomic, assign) UInt32 reStartUtc;

@end

/// 运动报告
@interface LZA5SportReportData : LZBraceletMeasurementData
/// 运动模式
@property (nonatomic, assign) LZA5SportMode sportMode;
/// 运动子模式（测量模式）
@property (nonatomic, assign) LZA5SportSubMode subMode;
/// bit0 为1是 表示有最大步频 平均步频
@property (nonatomic, assign) UInt32 flags;
/// 暂停次数 包括结束，所以默认就为1
@property (nonatomic, assign) UInt8 suspendTimes;
/// 开始时间
@property (nonatomic, assign) UInt32 start;
/// 结束时间
@property (nonatomic, assign) UInt32 end;
/// 时间中间暂停次数
@property (nonatomic, strong, nullable) NSArray <LZA5TimeStateData *> *states;
/// 单位秒
@property (nonatomic, assign) UInt16 sportTime;
/// 总步数，在游泳运动模式总步数代表 游泳圈数  laps
@property (nonatomic, strong, nullable) NSNumber *step;
/// 单位 Kcal
@property (nonatomic, strong, nullable) NSNumber *calories;
/// 最大心率
@property (nonatomic, strong, nullable) NSNumber *maxHr;
/// 平均心率
@property (nonatomic, strong, nullable) NSNumber *avgHr;
/// 最大步频
@property (nonatomic, strong, nullable) NSNumber *maxStepFreq;
/// 平均步频
@property (nonatomic, strong, nullable) NSNumber *avgStepFreq;
/// 最大速度 单位 Km/h
@property (nonatomic, strong, nullable) NSNumber *maxSpeed;
/// 平均速度 单位 Km/h
@property (nonatomic, strong, nullable) NSNumber *avgSpeed;
/// 单位米
@property (nonatomic, strong, nullable) NSNumber *distance;


/// 456新增
/// 平均步幅 （cm） 456新增
@property (nonatomic, strong, nullable) NSNumber *avgStepOfFloating;
/// 平均配速 单位 秒/公里 456 新增
@property (nonatomic, strong, nullable) NSNumber *avgPace;

/// 运动目标达成情况， 0无目标，1目标达成，2目标未达成
@property (nonatomic, strong, nullable) NSNumber *infoOfTarget;

/// 运动目标类型
@property (nonatomic, strong, nullable) NSNumber *targetType;

/// 运动目标值
@property (nonatomic, strong, nullable) NSNumber *targetValue;

/// 心率区间（一般为5个心率区间）
@property (nonatomic, strong) NSArray <NSNumber *> *hrSections;
/// 主泳姿 只在游泳有
@property (nonatomic, strong, nullable) NSNumber *mainStrokes;

/// 平均Swolf 只在游泳有
@property (nonatomic, strong, nullable) NSNumber *avgSwolf;

/// 划水次数 只在游泳有
@property (nonatomic, strong, nullable) NSNumber *numberOfStroke;

/// 冲刺速度 Km/h 只在足球有
@property (nonatomic, strong, nullable) NSNumber *sprintSpeed;

/// 最大步频时的心率 只在足球有
@property (nonatomic, strong, nullable) NSNumber *maxHrWhenMaxStepFreq;
/// 心率区间单位 （460新增）
@property (nonatomic, strong, nullable) NSNumber *hrSectionUnit;

@end

NS_ASSUME_NONNULL_END
