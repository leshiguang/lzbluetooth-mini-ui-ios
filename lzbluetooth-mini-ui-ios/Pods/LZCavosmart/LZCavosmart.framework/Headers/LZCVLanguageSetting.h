//
//  LZCVLanguageSetting.h
//  LZCavosmart
//
//  Created by tanjian on 2022/8/16.
//

#import <Foundation/Foundation.h>
#import <LZCavosmart/LZCVDataBase.h>

NS_ASSUME_NONNULL_BEGIN


///  语言类型
typedef NS_ENUM(NSUInteger, LZCVLanguageType) {
    /// 英语
    LZCVLanguageTypeEng                 = 0,
    /// 简体中文
    LZCVLanguageTypeSimpleChinese       = 1,
    /// 繁体中文
    LZCVLanguageTypeTraditionChinese    = 2,
};

/// 语言
@interface LZCVLanguageSetting : LZCVDataBase <LZDecodeDataProtocol>

/// 语言类型
@property (nonatomic, assign) LZCVLanguageType languageType;

@end

NS_ASSUME_NONNULL_END
