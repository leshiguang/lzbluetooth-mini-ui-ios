//
//  LZCVTimeSetting.h
//  LZCavosmart
//
//  Created by tanjian on 2022/8/16.
//

#import <Foundation/Foundation.h>
#import <LZCavosmart/LZCVDataBase.h>

NS_ASSUME_NONNULL_BEGIN


/// 时间更新
@interface LZCVTimeSetting : LZCVDataBase <LZDecodeDataProtocol>

@property (nonatomic, assign) NSUInteger year;
@property (nonatomic, assign) NSUInteger month;
@property (nonatomic, assign) NSUInteger day;
@property (nonatomic, assign) NSUInteger hour;
@property (nonatomic, assign) NSUInteger min;
@property (nonatomic, assign) NSUInteger second;

@end

NS_ASSUME_NONNULL_END
