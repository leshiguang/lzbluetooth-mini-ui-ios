//
//  LSCircleWaveAnimationView.m
//  LSWearable
//
//  Created by Wenzheng Zhang on 2017/3/9.
//  Copyright © 2017年 lifesense. All rights reserved.
//

#import "LSCircleWaveAnimationView.h"


@interface LSCircleWaveAnimationView ()
@property (nonatomic, strong) NSMutableArray<UIImageView *> *stopedWaveImageView;
@property (nonatomic, assign) CGPoint waveCenter;
@property (nonatomic, strong) UIImage *waveImage;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation LSCircleWaveAnimationView

- (void)dealloc {
    if (_timer != nil) {
        [_timer invalidate];
    }
}

- (void)startAnimationWithCircleWaveCenter:(CGPoint)circleWaveCenter {
    [self stopAnimation];
    self.waveCenter = circleWaveCenter;
    [self appendWave];
    [self startTimer];
}

- (void)appendWave {
    [self animateWaveImageView:[self nextInitialStateWaveImageView]];
}

- (void)stopAnimation {
    [self stopTimer];
    count = 0;
    [self.stopedWaveImageView enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(UIImageView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [obj.layer removeAnimationForKey:@"searchGroupAnimation"];
            [obj removeFromSuperview];
        });
    }];
}

- (void)animateWaveImageView:(UIImageView *)imageView {
    if (imageView == nil) return;
    [self addSubview:imageView];

    [self.stopedWaveImageView addObject:imageView];
    
    CABasicAnimation *expandAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    expandAnimation.fromValue = [NSNumber numberWithFloat:1];
    expandAnimation.toValue = [NSNumber numberWithFloat:30];
    expandAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [expandAnimation setRemovedOnCompletion:YES];

    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = [NSNumber numberWithFloat:1];
    opacityAnimation.toValue = [NSNumber numberWithFloat:0];
    [opacityAnimation setRemovedOnCompletion:YES];

    CAAnimationGroup *groups = [CAAnimationGroup animation];
    groups.animations = @[expandAnimation,opacityAnimation];
    groups.removedOnCompletion = NO;
    groups.duration = 4.9;
    groups.repeatCount = CGFLOAT_MAX;
    groups.fillMode = kCAFillModeForwards;
    [imageView.layer addAnimation:groups forKey:@"searchGroupAnimation"];

}


#pragma mark - Timer Manegement
- (void)startTimer {
    [self stopTimer];
    self.timer = nil;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.7 target:self selector:@selector(timerTimeout:) userInfo:nil repeats:YES];
}

- (void)stopTimer {
    if (self.timer != nil) {
        [self.timer invalidate];
    }
    self.timer = nil;
}

static int count = 0;
- (void)timerTimeout:(NSTimer *)timer {
    count ++;
    if (count == 20) {
        [self stopAnimation];
        return;
    }
    [self appendWave];
}

#pragma mark - Image View Menopulation
- (UIImageView *)nextInitialStateWaveImageView {
    UIImageView *imageView = [self generateWaveImageView];
    return imageView;
}

- (UIImageView *)generateWaveImageView {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:[self defaultLayerFrame]];
    imageView.image = self.waveImage;
    imageView.center = self.waveCenter;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    return imageView;
}

- (CGRect)defaultLayerFrame {
    return CGRectMake(0, 0, 50, 50);
}

- (UIImage *)waveImage {
    if (_waveImage == nil) {
        _waveImage = [UIImage imageNamed:@"DB_Wave_Circle"];
    }
    return _waveImage;
}

- (NSMutableArray<UIImageView *> *)stopedWaveImageView {
    if (!_stopedWaveImageView) {
        _stopedWaveImageView = [[NSMutableArray alloc] init];
    }
    return _stopedWaveImageView;
}
@end
