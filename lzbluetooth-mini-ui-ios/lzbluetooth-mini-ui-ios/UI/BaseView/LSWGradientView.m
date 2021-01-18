//
//  LSWGradientView.m
//  LSWearable
//
//  Created by wenZheng Zhang on 16/1/14.
//  Copyright © 2016年 lifesense. All rights reserved.
//

#import "LSWGradientView.h"

@interface LSWGradientView ()
@property (nonatomic) CAGradientLayer *gradientLayer;
@end

@implementation LSWGradientView

+ (Class)layerClass
{
    return [CAGradientLayer class];
}

#pragma mark - life cycle
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
    
}

- (void)commonInit
{
    _locations = nil;
    _gradientLayer = (CAGradientLayer *)self.layer;
    _startPoint = CGPointMake(1.0f, 0.0f);
    _endPoint   = CGPointMake(1.0f, 1.0f);
    
    _gradientLayer.locations  = _locations;
    _gradientLayer.startPoint = _startPoint;
    _gradientLayer.endPoint   = _endPoint;
}

- (void)setColors:(NSArray *)colors
{
    [self setColors:colors duration:0 animationCurve:0];
}

- (void)setStartPoint:(CGPoint)startPoint
{
    _startPoint = startPoint;
    self.gradientLayer.startPoint = startPoint;
}

- (void)setEndPoint:(CGPoint)endPoint
{
    _endPoint = endPoint;
    self.gradientLayer.endPoint = endPoint;
}

#pragma mark - Public API
- (void)setColors:(NSArray *)colors duration:(NSTimeInterval)duration animationCurve:(UIViewAnimationCurve)animationCurve
{
    
    NSMutableArray *cgColors = [[NSMutableArray alloc] init];
    for (UIColor *color in colors) {
        [cgColors addObject:(__bridge id)color.CGColor];
    }
    
    NSArray *preColors = self.gradientLayer.colors;
    self.gradientLayer.colors = cgColors;
    if (duration > 0) {
        CABasicAnimation *basicAnimation = [CABasicAnimation animation];
        basicAnimation.keyPath           = @"colors";
        basicAnimation.duration          = duration;
        basicAnimation.timingFunction    = [self timeingFunctionWithAnimationCurve:animationCurve];
        basicAnimation.toValue           = cgColors;
        basicAnimation.fromValue         = preColors;
        
        [self.gradientLayer addAnimation:basicAnimation forKey:@"basicAnimation"];
    }

    _colors = colors;
    
}

#pragma mark - Private MEthods
- (CAMediaTimingFunction *)timeingFunctionWithAnimationCurve:(UIViewAnimationCurve)animationCurve
{
    
    switch (animationCurve) {
        case UIViewAnimationCurveEaseInOut:
            return [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            break;
            
        case UIViewAnimationCurveEaseIn:
            return [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
            break;
            
        case UIViewAnimationCurveEaseOut:
            return [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
            break;
            
        case UIViewAnimationCurveLinear:
            return [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
            break;
            
        default:
            return [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            break;
    }
}

#pragma mark - setter
- (void)setLocations:(NSArray *)locations
{
    _locations = locations;
    self.gradientLayer.locations = locations;
}


@end
