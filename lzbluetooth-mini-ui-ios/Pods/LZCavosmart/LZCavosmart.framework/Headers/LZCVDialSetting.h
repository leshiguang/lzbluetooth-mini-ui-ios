//
//  LZCVDialSetting.h
//  LZCavosmart
//
//  Created by tanjian on 2022/8/17.
//

#import <Foundation/Foundation.h>
#import <LZCavosmart/LZCVDataBase.h>

NS_ASSUME_NONNULL_BEGIN


/// 表盘设置
@interface LZCVDialSetting : LZCVDataBase <LZDecodeDataProtocol>


/// 当前表盘序号
@property (nonatomic, assign) NSUInteger index;

/// 表盘总数
@property (nonatomic, assign) NSUInteger total;

@end

NS_ASSUME_NONNULL_END
