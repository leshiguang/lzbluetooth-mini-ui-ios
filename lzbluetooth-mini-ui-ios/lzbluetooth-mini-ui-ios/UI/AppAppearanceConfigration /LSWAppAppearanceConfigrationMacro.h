//
//  LSWAppAppearanceConfigrationMacro.h
//  LSWearable
//
//  Created by Wenzheng Zhang on 2016/10/24.
//  Copyright © 2016年 lifesense. All rights reserved.
//

#ifndef LSWAppAppearanceConfigrationMacro_h
#define LSWAppAppearanceConfigrationMacro_h

#import "LSWAppFontConfigrationMacro.h"
#import "LSWAppColorConfigrationMacro.h"

//**************** 字体定义 **********************

//**************** Handy 宏 **********************

#ifndef SCREEN_WIDTH
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#endif

#ifndef SCREEN_HEIGHT
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#endif

#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH <= 568.0)
#define IS_IPHONE_6_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH <= 667.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6_OR_LATER (IS_IPHONE && SCREEN_MAX_LENGTH >= 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)
#define IS_IPHONE_X (IS_IPHONE && SCREEN_MAX_LENGTH >= 812.0)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)


#define IPHONE_4_Height  480.0
#define IPHONE_5_Height  568.0
#define IPHONE_6_Height  667.0
#define IPHONE_6_Width   375.0
#define IPHONE_6p_Height 736.0
#define IPHONE_X_Height  812.0

#define LSW_IPHONE_X_BottomPadding  34
#define LSW_IPHONE_X_TopPadding     88  // 导航栏+状态栏

#define LSW_NavigationBarHeight (IS_IPHONE_X ? LSW_IPHONE_X_TopPadding : 64.0)  // 导航栏+状态栏
#define LSW_TabBarHeight (IS_IPHONE_X ? (LSW_IPHONE_X_BottomPadding + 49.0) : 49.0)

#define LSW_SearchNavBarHeight (IS_IPHONE_X ? 99.0 : 64.0)
#define LSW_Bottom_Button_Padding (IS_IPHONE_X ? LSW_IPHONE_X_BottomPadding : 10)
#define LSW_Device_iPhoneX_height(x) (IS_IPHONE_X ? (x + 34) : (x))


/*状态栏高度*/
#define kStatusBarHeight (CGFloat)(IS_IPHONE_X?(44.0):(20.0))
/*导航栏高度*/
#define kNavBarHeight (44)
/*状态栏和导航栏总高度*/
#define kNavBarAndStatusBarHeight (CGFloat)(IS_IPHONE_X?(88.0):(64.0))
/*TabBar高度*/
#define kTabBarHeight (CGFloat)(IS_IPHONE_X?(49.0 + 34.0):(49.0))
/*顶部安全区域远离高度*/
#define kTopBarSafeHeight (CGFloat)(IS_IPHONE_X?(44.0):(0))
/*底部安全区域远离高度*/
#define kBottomSafeHeight (CGFloat)(IS_IPHONE_X?(34.0):(0))



/**
 额外的底部空间，适用于已经有底部缩进，为适配iPhone X需要加上的额外的缩进。非iPhone X，此值为0

 @return 缩进值
 */
#define LSW_ExtraButtomPadding (IS_IPHONE_X ? (LSW_IPHONE_X_BottomPadding - 10) : 0)

/**
 额外的底部空间，适用于已经有顶部缩进，为适配iPhone X需要加上的额外的缩进。非iPhone X，此值为0
 
 @return 缩进值
 */
#define LSW_ExtraTopPadding (IS_IPHONE_X ? (LSW_IPHONE_X_TopPadding - 64) : 0)



/**
 给指定的View产生向上的阴影

 @param view view
 */
#define LSWDropUpwardShadow(view) { \
view.layer.shadowRadius  = 3.0;\
view.layer.shadowOpacity = 0.05;\
view.layer.shadowColor   = [UIColor blackColor].CGColor;\
view.layer.shadowOffset  = CGSizeMake(0.0, -2.0);\
view.layer.masksToBounds = NO;\
}


/**
 给群组的头像产生阴影

 @param view view
 */
#define LSWDropGroupAvatarShadow(view) { \
view.layer.shadowRadius  = 4.0;\
view.layer.shadowOpacity = 0.2;\
view.layer.shadowColor   = [UIColor blackColor].CGColor;\
view.layer.shadowOffset  = CGSizeMake(0.0, 0);\
view.layer.masksToBounds = NO;\
}


/**
 隐藏section最后一条cell的分割线，只有当cell遵循LSWSeparatorCell协议时才有效

 @param cell      当前cell
 @param tableView tableView
 @param indexPath 当前cell的indexPath
 */
#define LSWHideLastCellSeparator(cell, tableView, indexPath) {\
if ([cell conformsToProtocol:@protocol(LSWSeparatorCell)]) {\
id <LSWSeparatorCell> wtc = (id <LSWSeparatorCell>)cell;\
if ([tableView numberOfRowsInSection:indexPath.section] - 1 == indexPath.row) {\
wtc.separatorLineImageView.hidden = YES;\
} else wtc.separatorLineImageView.hidden = NO;\
}\
}


/**
 移除返回按钮的title

 @param navigationItem navigationItem
 */
#define LSWRemoveBackButtonItemTitle(navigationItem) navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil]

#define Chart_Scal (IS_IPHONE_5_OR_LESS ? 0.485 : 0.435)


#define LSWChartHeadViewHeight (IS_IPHONE_5_OR_LESS ? (Chart_Scal * SCREEN_HEIGHT) : ((0.435) * IPHONE_6_Height) )




#endif /* LSWAppAppearanceConfigrationMacro_h */
