//
//  LZA5SettingLanguageData.h
//  LZBluetooth
//
//  Created by tanjian on 2020/10/22.
//  语言设置到手环(0xAA)

#import <Foundation/Foundation.h>



#import <LZBracelet/LZA5SettingData.h>


NS_ASSUME_NONNULL_BEGIN

/// 语言类型
typedef NS_ENUM(NSUInteger, LZA5LanguageCode) {
    /// 中文简体
    LZA5LanguageCodeCN,
    /// 中文繁体
    LZA5LanguageCodeTW,
    /// 英语
    LZA5LanguageCodeEnglish,
    /// 日语
    LZA5LanguageCodeJapenese,
    /// 韩语
    LZA5LanguageCodeKorean,
    /// 法语
    LZA5LanguageCodeFrench
};

/// 语言设置
@interface LZA5SettingLanguageData : LZA5SettingData

@property (nonatomic, assign) LZA5LanguageCode languageCode;

@end

NS_ASSUME_NONNULL_END
