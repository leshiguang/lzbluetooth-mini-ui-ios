//
//  LSCircleWaveAnimationView.h
//  LSWearable
//
//  Created by Wenzheng Zhang on 2017/3/9.
//  Copyright © 2017年 lifesense. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSCircleWaveAnimationView : UIView

/**
 开始圆形波浪动画

 @param circleWaveCenter 圆形波浪的圆心
 */
- (void)startAnimationWithCircleWaveCenter:(CGPoint)circleWaveCenter;

/**
 停止动画
 */
- (void)stopAnimation;
@end
