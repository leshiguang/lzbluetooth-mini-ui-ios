//
//  LZCVChargingData.h
//  LZCavosmart
//
//  Created by tanjian on 2022/8/22.
//

#import <LZCavosmart/LZCavosmart.h>

NS_ASSUME_NONNULL_BEGIN



@interface LZCVChargingData : LZCVDataBase


/// 0-不充电。1-充电中  2-充电完成
@property (nonatomic, assign) NSUInteger state;

@end

NS_ASSUME_NONNULL_END
