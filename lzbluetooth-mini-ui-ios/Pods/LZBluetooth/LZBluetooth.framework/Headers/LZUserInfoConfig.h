//
//  LZUserInfoConfig.h
//  LZBluetooth
//
//  Created by tanjian on 2020/12/9.
//  初始化的时候的一些配置

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LZUserInfoConfig : NSObject

@property (nonatomic, assign) double weight;
@property (nonatomic, assign) double height;
@property (nonatomic, assign) UInt8 age;
@property (nonatomic, strong) NSNumber *weekTarget;


/// 需要配置id
@property (nonatomic, strong, nullable) NSString *userId;

/// 性别  
@property (nonatomic, assign) NSUInteger gender;

@end

NS_ASSUME_NONNULL_END
