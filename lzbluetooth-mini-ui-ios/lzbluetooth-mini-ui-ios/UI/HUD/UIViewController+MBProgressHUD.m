//
//  UIViewController+MBProgressHUD.m
//  security
//
//  Created by sen5labs on 15/10/14.
//  Copyright © 2015年 sen5. All rights reserved.
//

#import "UIViewController+MBProgressHUD.h"
#import "objc/runtime.h"

//static char kLSWHintMessageHUDKey;
//static char kLSWActivityIndicatorHUDKey;
static char kLSWHintMessageWithIconHUDKey;


//static MBProgressHUD * _hud = nil;

@implementation UIViewController (MBProgressHUD)

- (void)showWithTime:(NSTimeInterval)time title:(NSString *)title {
    [self showHintMessage:title duration:time];
}

- (void)showActivityIndicatorViewWithTitle:(NSString *)title {
    [self showActivityIndicatorHUDWithMessage:title];
}

- (void)hideActivityIndicatorView {
    [self hideActivityIndicatorHUD];
    
}

- (void)showHintMessage:(NSString *)hintMessage iconImage:(UIImage *)image duration:(NSTimeInterval)duration margin:(CGFloat)margin minSize:(CGSize)minSize {
    if (image == nil || hintMessage == nil) return;
    
    UIView *superView = self.view;
    if (self.navigationController.view != nil) {
        //        superView = self.navigationController.view;
    }
        
        if (!superView) {
            return;
        }
    
    MBProgressHUD *hintHud = objc_getAssociatedObject(self, &kLSWHintMessageWithIconHUDKey);
    if (hintHud == nil) {
        hintHud = [[MBProgressHUD alloc] initWithView:superView];
        hintHud.mode = MBProgressHUDModeCustomView;
        hintHud.removeFromSuperViewOnHide = YES;
        hintHud.layer.cornerRadius = 4;
        hintHud.layer.opacity = 0.6;
        objc_setAssociatedObject(self, &kLSWHintMessageWithIconHUDKey, hintHud, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    if (hintHud.superview == nil) {
        [superView addSubview:hintHud];
    }
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    UIView *wrapper = [[UIView alloc] initWithFrame:CGRectInset(imageView.bounds, 0, -6.5)];
    [wrapper addSubview:imageView];
    hintHud.customView = wrapper;
//    hintHud.labelText = hintMessage;
    hintHud.label.text = hintMessage;
    if (margin == 0) {
        hintHud.margin = 20;
    } else {
        hintHud.margin = margin;
    }
    
    hintHud.minSize = minSize;
    [hintHud showAnimated:YES];
    [hintHud hideAnimated:YES afterDelay:duration];
}

- (void)showHintMessage:(NSString *)hintMessage iconImage:(UIImage *)image duration:(NSTimeInterval)duration
{
    [self showHintMessage:hintMessage iconImage:image duration:duration margin:0 minSize:CGSizeZero];
}



- (void)showHintMessage:(NSString *)hintMessage duration:(NSTimeInterval)duration
{
    UIView *superView = self.view;
    if (!superView) {
        return;
    }
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:superView];
    hud.removeFromSuperViewOnHide = YES;
    [superView addSubview:hud];
    hud.margin = 5.0;
    hud.layer.cornerRadius = 4;
    hud.layer.opacity = 0.6;
    hud.margin = 15;
    hud.mode = MBProgressHUDModeText;
    hud.label.text = hintMessage;
    [hud showAnimated:YES];
    [hud hideAnimated:YES afterDelay:duration];
}

- (void)showActivityIndicatorHUDWithMessage:(NSString *)message
{
    UIView *superView = self.view;
    if (!superView) {
        return;
    }
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:superView];
    hud.removeFromSuperViewOnHide = YES;
    [superView addSubview:hud];
    hud.margin = 5.0;
    hud.layer.cornerRadius = 4;
    hud.layer.opacity = 0.6;
    hud.margin = 15;
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.text = message;
    [hud showAnimated:YES];
}

- (void)hideActivityIndicatorHUD
{
    UIView *superView = self.view;
    if (!superView) {
        return;
    }
    MBProgressHUD *hud = [MBProgressHUD HUDForView:superView];
    if (hud != nil) {
        hud.removeFromSuperViewOnHide = YES;
        [hud hideAnimated:YES];
    }
}

@end
