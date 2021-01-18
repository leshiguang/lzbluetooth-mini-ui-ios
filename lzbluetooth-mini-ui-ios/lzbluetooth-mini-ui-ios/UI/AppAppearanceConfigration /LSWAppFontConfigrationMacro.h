//
//  LSWAppFontConfigrationMacro.h
//  LSWearable
//
//  Created by Wenzheng Zhang on 2017/9/1.
//  Copyright © 2017年 lifesense. All rights reserved.
//

#ifndef LSWAppFontConfigrationMacro_h
#define LSWAppFontConfigrationMacro_h

#pragma mark - 标准字体/字号定义
//标准字体/字号定义

/**
 小字号，标签字
 */
#define LSWSmallFontSize 12

/**
 辅助字号，导航栏操作/描述/时间/名次/人数字/等
 */
#define LSWSecondaryFontSize 14

/**
 主要字号，正文/列表
 */
#define LSWMainFontSize 16

//**************** 常规字体定义 **********************
/**
 获取指定字号的标准字体
 
 @param fontSize 字号
 @return 字体
 */
#define LSWDefaultFontWithSize(fontSize) [UIFont systemFontOfSize:fontSize]

/**
 获取指定字号的半加粗字体
 
 @param fontSize 字号
 @return 字体
 */
#define LSWDefaultMediumFontWithSize(fontSize) (([[[UIDevice currentDevice] systemVersion] compare:@"8.2" options:NSNumericSearch] != NSOrderedAscending) ? [UIFont systemFontOfSize:fontSize weight:UIFontWeightMedium] : [UIFont boldSystemFontOfSize:fontSize])


/**
 获取指定字号的加粗字体
 
 @param fontSize 字号
 @return 字体
 */
#define LSWDefaultBoldFontWithSize(fontSize) [UIFont boldSystemFontOfSize:fontSize]

//**************** 数字字体定义 **********************
/**
 DINCond-Medium字体，通常用于显示数字
 
 @param fontSize 字体大小
 
 @return DINCond-Medium字体
 */
#define LSWDigitMediumFontWithSize(fontSize) ([UIFont fontWithName:@"DINCond-Medium" size:fontSize])


/**
 DINCond-Bold字体，通常用于显示数字
 
 @param fontSize 字体大小
 
 @return DINCond-Bold字体
 */
#define LSWDigitBoldFontWithSize(fontSize) [UIFont fontWithName:@"DINCond-Bold" size:fontSize]


//**************** 向后兼容, 其他字体定义 **********************
//PingFang
#define LSWPingFangSCFontWithSize(fontSize) LSWDefaultFontWithSize(fontSize)
#define LSWPingFangMediumFontWithSize(fontSize) LSWDefaultMediumFontWithSize(fontSize)

//Helvetica
#define LSWHelveticaBoldObliqueFontWithSize(fontSize) ([UIFont fontWithName:@"HelveticaNeue-BoldItalic" size:fontSize] ?: [UIFont boldSystemFontOfSize:fontSize])
#define LSWHelveticaMediumbliqueFontWithSize(fontSize) ([UIFont fontWithName:@"HelveticaNeue-Medium" size:fontSize] ?: [UIFont boldSystemFontOfSize:fontSize])
#define LSWHelveticaBoldItalicFontWithSize(fontSize) ([UIFont fontWithName:@"HelveticaNeue-BoldItalic" size:fontSize] ?: [UIFont italicSystemFontOfSize:fontSize])

//STHeiti
#define LSWSTHeitiMediumFontWithSize(fontSize) ([UIFont fontWithName:@"STHeiti-Medium" size:fontSize]) ?: ([UIFont systemFontOfSize:fontSize])


#endif /* LSWAppFontConfigrationMacro_h */
