//
//  LZA5NewMeasurementData.h
//  LZBluetooth
//
//  Created by tanjian on 2020/10/22.
//  发送新测量数据到 APP(0xE9)

#import <Foundation/Foundation.h>



#import <LZBracelet/LZBraceletMeasurementData.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_OPTIONS(NSUInteger, LZA5MeasureDataFlag) {
    /// 没有Gsensor 数据
    LZA5MeasureDataFlagNoGsensor = 1,
    /// Gsensor 1 byte
    LZA5MeasureDataFlag1ByteGsensor = (1<<1),
    /// Gsensor 2 byte
    LZA5MeasureDataFlag2ByteGsensor = (1<<2),
    /// Gsensor 3 byte
    LZA5MeasureDataFlag3ByteGsensor = (1<<3),
    /// 没有Heartrate 数据
    LZA5MeasureDataFlagNoHeartrate = (1<<4),
    /// Heartrate 1 byte
    LZA5MeasureDataFlag1ByteHeartrate = (1<<5),
    /// Heartrate 2 byte
    LZA5MeasureDataFlag2ByteHeartrate = (1<<6),
    /// Heartrate 3 byte
    LZA5MeasureDataFlag3ByteHeartrate = (1<<7),
    /// 没有step 数据
    LZA5MeasureDataFlagNoStep = (1<<8),
    /// step 1 byte
    LZA5MeasureDataFlag1ByteStep = (1<<9),
    /// step 2 byte
    LZA5MeasureDataFlag2ByteStep = (1<<10),
    /// step 3 byte
    LZA5MeasureDataFlag3ByteStep = (1<<11),
};


@interface LZA5NewMeasurementContentData : NSObject

@property (nonatomic, assign) UInt32 x;
@property (nonatomic, assign) UInt32 y;
@property (nonatomic, assign) UInt32 z;
@property (nonatomic, assign) UInt32 heartrate;
@property (nonatomic, assign) UInt32 step;

@end

@interface LZA5NewMeasurementData : LZBraceletMeasurementData

@property (nonatomic, assign) LZA5MeasureDataFlag flag;

@property (nonatomic, assign) UInt32 firstDataUtc;
@property (nonatomic, assign) UInt32 utcOffset;
@property (nonatomic, assign) UInt16 restCount;

/// 当前上传测量数据起始条数
@property (nonatomic, assign) UInt16 startOffset;

@property (nonatomic, strong) NSArray <LZA5NewMeasurementContentData *> *contentDatas;


@end

NS_ASSUME_NONNULL_END
