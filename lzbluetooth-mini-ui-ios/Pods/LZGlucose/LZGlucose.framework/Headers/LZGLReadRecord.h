//
//  LZGLReadRecord.h
//  LZGlucose
//
//  Created by tanjian on 2023/2/8.
//

#import <LZGlucose/LZGLSetting.h>

NS_ASSUME_NONNULL_BEGIN

@interface LZGLReadRecord : LZGLSetting

/// 条数  0 表示所有 (  < 100)
@property (nonatomic, assign) NSUInteger count;


@end

NS_ASSUME_NONNULL_END
