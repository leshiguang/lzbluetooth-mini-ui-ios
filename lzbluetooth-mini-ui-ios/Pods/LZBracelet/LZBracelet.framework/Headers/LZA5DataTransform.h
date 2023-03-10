//
//  LZA5DataTransform.h
//  LZBracelet
//
//  Created by tanjian on 2022/3/30.
//

#import <Foundation/Foundation.h>
#import <LZBracelet/LZBraceletMeasurementData.h>

NS_ASSUME_NONNULL_BEGIN

@interface LZA5DataTransform : NSObject


/// 将数据模型转成对象
/// @param data 数据模型
+ (nullable NSArray <NSDictionary *> *)transformToDictionaryWithData:(LZBraceletMeasurementData *)data;

@end

NS_ASSUME_NONNULL_END
