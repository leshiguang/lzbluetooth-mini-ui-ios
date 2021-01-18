//
//  LSWGradientView.h
//  LSWearable
//
//  Created by wenZheng Zhang on 16/1/14.
//  Copyright © 2016年 lifesense. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSWGradientView : UIView
@property (nonatomic) NSArray *colors;
@property (nonatomic) NSArray *locations;
@property (nonatomic) CGPoint startPoint;
@property (nonatomic) CGPoint endPoint;

- (void)setColors:(NSArray *)colors duration:(NSTimeInterval)duration animationCurve:(UIViewAnimationCurve)animationCurve;
@end
