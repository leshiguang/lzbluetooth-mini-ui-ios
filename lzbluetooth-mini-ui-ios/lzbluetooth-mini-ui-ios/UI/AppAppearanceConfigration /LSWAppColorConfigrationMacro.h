//
//  LSWAppColorConfigrationMacro.h
//  LSWearable
//
//  Created by Wenzheng Zhang on 2017/9/1.
//  Copyright © 2017年 lifesense. All rights reserved.
//

#ifndef LSWAppColorConfigrationMacro_h
#define LSWAppColorConfigrationMacro_h

#pragma mark - 颜色转换
//**************** 颜色转换 **********************
#define LSWHEXRGBA(c,a)  [UIColor colorWithRed:((c>>16)&0xFF)/255.0  green:((c>>8)&0xFF)/255.0   blue:((c)&0xFF)/255.0   alpha:a]
#define LSWHEXRGB(c) LSWHEXRGBA(c,1.0)

#define LSWRGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define LSWRGB(r,g,b) LSWRGBA(r,g,b,1.0)

#define UIColorFromHex(hex) [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16))/255.0 green:((float)((hex & 0xFF00) >> 8))/255.0 blue:((float)(hex & 0xFF))/255.0 alpha:1.0]

//**************** 颜色定义 **********************

/**
 主体蓝
 */
#define LSWMainBlueColor UIColorFromHex(0x1EABE1)

/**
 运动黑
 */
#define LSWSportBlackColor UIColorFromHex(0x29122E)

/**
 睡眠紫
 */
#define LSWSleepPurpleColor UIColorFromHex(0x252F68)

/**
 体重绿
 */
#define LSWWeightGreenColor UIColorFromHex(0x12B4B3)

/**
 心率青
 */
#define LSWHeartrateCyanColor UIColorFromHex(0x0C7D9B)

/**
 步数蓝
 */
#define LSWStepBlueColor LSWMainBlueColor


/**
 App主色调
 */
#define LSWKeyColor LSWMainBlueColor

/**
 主体黑，用于列表文字，正文等
 */
#define LSWImportantContentFontColor UIColorFromHex(0x414141)

/**
 次要文字黑
 */
#define LSWNormalContentFontColor    UIColorFromHex(0x797979)

/**
 辅助灰，用于显示次要文字，分割线等
 */
#define LSWWeakContentFontColor      UIColorFromHex(0xB6B6B6)

/**
 默认背景颜色
 */
#define LSWDefaultBackgroundColor    UIColorFromHex(0xf0f0f0)

/**
 默认分割线颜色
 */
#define LSWDefaultSeperatorLineColor    UIColorFromHex(0xD9D9D9)


//**************** 向后兼容,其他颜色定义 **********************
#define LSWOtherImportContentFontColor UIColorFromHex(0x000000)
#define LSWOtherNormalContentFontColor UIColorFromHex(0x414141)
#define LSWOtherWeakContentFontColor   UIColorFromHex(0x9b9b9b)

/*
 * 账号相关页面改版
 */
#define kLSWMainThemColor       UIColorFromHex(0x6593e5)       // 主题色

#define kLSWAssistThemColor     UIColorFromHex(0x94b4ed)       // 主题色assist

#define kLSWMainAssistColor     UIColorFromHex(0xa3a3a3)       // 辅助色

#define kLSWMainBlacColor       UIColorFromHex(0x1c1c1c)       // 主黑色

#define kLSWMainSeparateColor   UIColorFromHex(0xcecece)       // 分割线

#define kLSWMainGrayColor       UIColorFromHex(0x666666)       // 灰色

#endif /* LSWAppColorConfigrationMacro_h */
