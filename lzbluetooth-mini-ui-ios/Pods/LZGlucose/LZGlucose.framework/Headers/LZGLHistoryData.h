//
//  LZGLHistoryData.h
//  LZGlucose
//
//  Created by tanjian on 2023/2/8.
//

#import <Foundation/Foundation.h>
#import <LZGlucose/LZGLData.h>
#import <LZBluetooth/LZMergeDataManager.h>

NS_ASSUME_NONNULL_BEGIN

@interface LZGLHistoryDataInfo : NSObject

/// 血糖 (单位 mmol)
@property (nonatomic, assign) double glucose;

/// 时间戳
@property (nonatomic, assign) NSUInteger utc;

/// 样本， 0x11 为血液 0x22 为质控液
@property (nonatomic, assign) NSUInteger sample;

/// 餐前餐后状态 0x00 无状态 0x11 FPG（餐前） 0x22 PPG（餐后）
@property (nonatomic, assign) NSUInteger dinnerState;

@end


/// 血糖历史记录
@interface LZGLHistoryData : LZGLData <LZMergeable>

/// 历史列表
@property (nonatomic, strong) NSMutableArray <LZGLHistoryDataInfo *> *list;

@end

NS_ASSUME_NONNULL_END
