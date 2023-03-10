//
//  LZCVBPData.h
//  LZCavosmart
//
//  Created by tanjian on 2022/8/22.
//

#import <LZCavosmart/LZCVDataBase.h>

NS_ASSUME_NONNULL_BEGIN

@interface LZCVBPInfo : NSObject

@property (nonatomic, assign) NSUInteger utc;
@property (nonatomic, assign) NSUInteger bp_low;
@property (nonatomic, assign) NSUInteger bp_high;
@property (nonatomic, assign) NSUInteger heart_rate;

@end

@interface LZCVBPData : LZCVDataBase

@property (nonatomic, strong) NSMutableArray <LZCVBPInfo *> *list;


@end

NS_ASSUME_NONNULL_END
