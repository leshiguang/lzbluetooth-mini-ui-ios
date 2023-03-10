//
//  LZGLDeleteSetting.h
//  LZGlucose
//
//  Created by tanjian on 2023/2/9.
//

#import <LZGlucose/LZGLSetting.h>

NS_ASSUME_NONNULL_BEGIN

@interface LZGLDeleteSetting : LZGLSetting

/// 条数  0 表示所有 (  < 100)
@property (nonatomic, assign) BOOL isAll;

@end

NS_ASSUME_NONNULL_END
