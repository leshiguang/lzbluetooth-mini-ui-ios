//
//  LSWButton.h
//  LSWearable
//
//  Created by ZhangWenzheng on 16/6/28.
//  Copyright © 2016年 lifesense. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 默认左右边距 */
FOUNDATION_EXTERN NSInteger const kLSWButtonPadding;

/** 默认高度 */
FOUNDATION_EXTERN NSInteger const kLSWButtonHeight;

FOUNDATION_EXTERN NSInteger const kLSWButtonWidth;

/**
 LSW按钮样式

 - LSWButtonStylePrimaryButtonWithDeepColor:    深色主行动按钮
 - LSWButtonStylePrimaryButtonWithWhiteColor: 白色主行动按钮
 - LSWButtonStyleSecondaryButton:               辅助按钮
 */
typedef NS_ENUM(NSUInteger, LSWButtonStyle) {
    
    LSWButtonStylePrimaryButtonWithDeepColor,
    LSWButtonStylePrimaryButtonWithWhiteColor,
    LSWButtonStyleSecondaryButton,
    LSWBUttonStyleLineColor,    
    LSWButtonStyleClearColorWithLineBorder,
    LSWButtonStyleClearColorWithGrayLineBorder,
    LSWButtonStyleNewPrimaryButtonWithDeepBlueColor,
    LSWButtonStyleNewPrimaryButtonWithWhiteColor
};

@interface LSWButton : UIButton


/**
 样式，默认LSWButtonStylePrimaryButtonWithDeepColor
 */
@property (nonatomic, assign, readonly) LSWButtonStyle style;
 
- (instancetype)initWithButtonStyle:(LSWButtonStyle)style;


@property (nonatomic, assign) BOOL grayEnble;
@property (nonatomic, assign) CGFloat cornerRediu;

@end
