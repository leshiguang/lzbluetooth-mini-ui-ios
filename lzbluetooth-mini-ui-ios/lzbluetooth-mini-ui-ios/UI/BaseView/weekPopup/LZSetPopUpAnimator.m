//
//  LZSetPopUpAnimator.m
//  LSBluetoothUI_iOS
//
//  Created by wm on 2020/12/17.
//

#import "LZSetPopUpAnimator.h"

@interface LZSetPopUpAnimator ()
@property (nonatomic, strong) UIView *dimmingView;
@end

@implementation LZSetPopUpAnimator

#pragma mark - UIViewControllerTransitioningDelegate
- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source {
    LZSetPopUpAnimator *pc = [[LZSetPopUpAnimator alloc] initWithPresentedViewController:presented presentingViewController:presenting];
    return pc;
}

- (CGRect)frameOfPresentedViewInContainerView {
    CGRect presentedViewFrame = CGRectZero;
    CGRect containerBounds = [[self containerView] bounds];
    presentedViewFrame.size = CGSizeMake(containerBounds.size.width-60,460);
    presentedViewFrame.origin.x = (containerBounds.size.width -
    presentedViewFrame.size.width) * 0.5;
    presentedViewFrame.origin.y = (containerBounds.size.height -
    presentedViewFrame.size.height) * 0.5;
    return presentedViewFrame;
}

- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController {
    self = [super initWithPresentedViewController:presentedViewController
                             presentingViewController:presentingViewController];
    if(self) {
        // 初始化一个暗色视图, 并设置初始外观
        self.dimmingView = [[UIView alloc] init];
        [self.dimmingView setBackgroundColor:[UIColor colorWithWhite:0.0 alpha:0.2]];
        [self.dimmingView setAlpha:0.0];
        UIGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDismmingView)];
        [self.dimmingView addGestureRecognizer:tap];
    }
    return self;
}

- (void)presentationTransitionWillBegin {
    UIView* containerView = [self containerView];
    UIViewController* presentedViewController = [self presentedViewController];
    [[self dimmingView] setFrame:[containerView bounds]];
    [containerView insertSubview:[self dimmingView] atIndex:0];
    if([presentedViewController transitionCoordinator]) {
        [[presentedViewController transitionCoordinator] animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
                    [self.dimmingView setAlpha:1.0];
        } completion:nil];
    }
    else {
        [self.dimmingView setAlpha:1.0];
    }
}

- (void)dismissalTransitionWillBegin {
    [self.dimmingView removeFromSuperview];
}


#pragma mark - touch Event
- (void)tapDismmingView {
    UIViewController *vc = [self presentingViewController];
    [vc dismissViewControllerAnimated:NO completion:nil];
}


@end
