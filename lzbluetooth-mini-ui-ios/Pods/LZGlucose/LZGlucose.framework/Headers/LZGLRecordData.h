//
//  LZGLRecordData.h
//  LZGlucose
//
//  Created by tanjian on 2023/2/8.
//

#import <Foundation/Foundation.h>
#import <LZGlucose/LZGLData.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, LZGLRecordState) {
    /// 上一笔
    LZGLRecordStateLast = 0x10,
    /// 表示显示去测试
    LZGLRecordStateTestPage = 0x11,
    /// 等待血液
    LZGLRecordStateWaitBlood = 0x22,
    /// 表示已经完成
    LZGLRecordStateAlread = 0x33,
    /// 表示结果
    LZGLRecordStateresult = 0x44,
    /// 表示错误
    LZGLRecordStateWarn = 0x55,
};


/// 实时报告，在测量的时候连接了设备，就会有各种状态
@interface LZGLRecordData : LZGLData

/// 血糖（单位 mmol）
@property (nonatomic, assign) double glucose;

/// 状态
@property (nonatomic, assign) LZGLRecordState state;

/// 样本， 0x11 为血液 0x22 为质控液
@property (nonatomic, assign) NSUInteger sample;

/// 错误码
@property (nonatomic, assign) NSUInteger errCode;

/// 测量时间
@property (nonatomic, assign) NSUInteger utc;


@end

NS_ASSUME_NONNULL_END
