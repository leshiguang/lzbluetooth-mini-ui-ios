//
//  LZCVTimeFormatSetting.h
//  LZCavosmart
//
//  Created by tanjian on 2022/8/16.
//

#import <Foundation/Foundation.h>
#import <LZCavosmart/LZCVDataBase.h>

NS_ASSUME_NONNULL_BEGIN

///  消息类型
typedef NS_ENUM(NSUInteger, LZCVTimeFormat) {
    LZCVTimeFormat24     = 0,
    LZCVTimeFormat12     = 1,
   
};

/// 时间格式
@interface LZCVTimeFormatSetting : LZCVDataBase <LZDecodeDataProtocol>

@property (nonatomic, assign) LZCVTimeFormat timeFormat;

@end

NS_ASSUME_NONNULL_END
