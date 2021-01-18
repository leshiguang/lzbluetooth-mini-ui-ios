//
//  LSWButton.m
//  LSWearable
//
//  Created by ZhangWenzheng on 16/6/28.
//  Copyright © 2016年 lifesense. All rights reserved.
//

#import "LSWButton.h"
#import "LSWAppColorConfigrationMacro.h"

NSInteger const kLSWButtonPadding = 30;
NSInteger const kLSWButtonHeight = 54;
NSInteger const kLSWButtonWidth = 132;

@interface LSWButton ()
@property (nonatomic, assign, readwrite) LSWButtonStyle style;


@property (nonatomic, strong) UIColor *normalStateTitleColor;


@property (nonatomic, strong) UIColor *disableStateTitleColor;


@property (nonatomic, strong) UIColor *highlightStateTitleColor;

@property (nonatomic, strong) CAGradientLayer *backGradientLayer;

@property (nonatomic, strong) NSArray *normalBackGradientLayerColors;
@property (nonatomic, strong) NSArray *highlightedBackGradientLayerColors;
@property (nonatomic, strong) NSArray *disabledBackGradientLayerColors;


@end



@implementation LSWButton

- (instancetype)init {
    return [self initWithButtonStyle:LSWButtonStylePrimaryButtonWithDeepColor];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInitWithStyle:LSWButtonStylePrimaryButtonWithDeepColor];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInitWithStyle:LSWButtonStylePrimaryButtonWithDeepColor];
        
    }
    return self;
    
}

- (instancetype)initWithButtonStyle:(LSWButtonStyle)style {
    self = [super init];
    if (self) {
        [self commonInitWithStyle:style];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat width = CGRectGetWidth(self.bounds);
    _backGradientLayer.frame = CGRectMake(0, 0, width, width);
    
    if (self.cornerRediu == -1) {
        self.layer.cornerRadius = CGRectGetHeight(self.bounds) / 2;
    }
    
    self.layer.masksToBounds = YES;
    
    
    
}

- (void)commonInitWithStyle:(LSWButtonStyle)style {
    
    self.cornerRediu = -1;
    
    _style = style;
    
    self.titleLabel.font = [UIFont systemFontOfSize:16];
    
    if (_backGradientLayer == nil) {
        _backGradientLayer = [[CAGradientLayer alloc] init];
        
        _backGradientLayer.startPoint = CGPointMake(0, 0);
        _backGradientLayer.endPoint = CGPointMake(1, 1);
        
        
        
        [self.layer insertSublayer:_backGradientLayer atIndex:0];
    }
    
    switch (style) {
        case LSWButtonStyleClearColorWithLineBorder: {
            self.backgroundColor = [UIColor clearColor];
            self.layer.borderColor = UIColorFromHex(0xffffff).CGColor;
            self.layer.borderWidth = 1;
            
            self.backGradientLayer.hidden = YES;
            
            self.normalStateTitleColor = UIColorFromHex(0xffffff);
            
            self.highlightStateTitleColor = UIColorFromHex(0xb6b6b6);
            break;
        }
        case LSWButtonStyleClearColorWithGrayLineBorder: {
            self.backgroundColor = [UIColor clearColor];
            self.layer.borderColor = UIColorFromHex(0x9B9B9B).CGColor;
            self.layer.borderWidth = 1;
            
            self.backGradientLayer.hidden = YES;
            
            self.normalStateTitleColor = UIColorFromHex(0x9B9B9B);
            
            self.highlightStateTitleColor = UIColorFromHex(0xb6b6b6);
            break;
        }

            
            
            
        case LSWButtonStylePrimaryButtonWithDeepColor: {
            
            
            self.normalBackGradientLayerColors = @[((__bridge id)LSWHEXRGB(0x2EBAFF).CGColor),
                                                   ((__bridge id)LSWHEXRGB(0x2479ff).CGColor)];
            
            self.highlightedBackGradientLayerColors = @[((__bridge id)LSWHEXRGB(0x1d6ce2).CGColor),
                                                        ((__bridge id)LSWHEXRGB(0x1d6ce2).CGColor)];
            
            self.disabledBackGradientLayerColors = @[((__bridge id)LSWHEXRGB(0x90deff).CGColor),
                                                     ((__bridge id)LSWHEXRGB(0x87acff).CGColor)];
            
            self.normalStateTitleColor = [UIColor whiteColor];
            
            self.highlightStateTitleColor = [UIColor whiteColor];
            
            self.disableStateTitleColor = [UIColor whiteColor];
            
            break;
        }
            
        
            
        case LSWButtonStylePrimaryButtonWithWhiteColor: {
            
            
            self.normalBackGradientLayerColors = @[((__bridge id)LSWHEXRGB(0xFFFFFF).CGColor),
                                                   ((__bridge id)LSWHEXRGB(0xFFFFFF).CGColor)];
            
            self.highlightedBackGradientLayerColors = @[((__bridge id)LSWHEXRGB(0xf8f8f8).CGColor),
                                                        ((__bridge id)LSWHEXRGB(0xf8f8f8).CGColor)];
            
            self.disabledBackGradientLayerColors = @[((__bridge id)LSWHEXRGB(0xFFFFFF).CGColor),
                                                     ((__bridge id)LSWHEXRGB(0xFFFFFF).CGColor)];
            
            
            self.normalStateTitleColor = UIColorFromHex(0x0093cb);
            
            
            self.highlightStateTitleColor = UIColorFromHex(0x46b4dd);
            
            
            self.disableStateTitleColor = UIColorFromHex(0x0093cb);
            
            break;
        }
            
        case LSWButtonStyleSecondaryButton: {
            self.backgroundColor = [UIColor whiteColor];
            self.layer.borderColor = UIColorFromHex(0x9b9b9b).CGColor;
            self.layer.borderWidth = 1;
            
            self.backGradientLayer.hidden = YES;
            
            self.normalStateTitleColor = UIColorFromHex(0x414141);
            
            self.highlightStateTitleColor = UIColorFromHex(0xb6b6b6);
            
            break;
        }
            
        case LSWBUttonStyleLineColor: {
            self.backgroundColor = [UIColor whiteColor];
            self.layer.borderColor = LSWKeyColor.CGColor;
            self.layer.borderWidth = 1;
            
            self.backGradientLayer.hidden = YES;
            
            self.normalStateTitleColor = LSWKeyColor;
            
            self.highlightStateTitleColor = UIColorFromHex(0xb6b6b6);
            
            break;
        }
        case LSWButtonStyleNewPrimaryButtonWithDeepBlueColor: {
            
            self.backgroundColor = LSWHEXRGB(0x5D8DE4);
            
            self.backGradientLayer.hidden = YES;
            
            self.normalStateTitleColor = [UIColor whiteColor];
            
            self.cornerRediu = 6;

            break;
        }
        case LSWButtonStyleNewPrimaryButtonWithWhiteColor:{
            

            self.layer.borderColor = LSWHEXRGB(0x5D8DE4).CGColor;
            
            self.layer.borderWidth = 1;
            
            self.backgroundColor = [UIColor clearColor];
            
            self.backGradientLayer.hidden = YES;
            
            self.normalStateTitleColor = LSWHEXRGB(0x5D8DE4);
            
            self.cornerRediu = 6;
            
            break;
        }
            
    }
    
    _backGradientLayer.colors = self.normalBackGradientLayerColors;
    
    [self setTitleColor:self.disableStateTitleColor forState:UIControlStateDisabled];
    [self setTitleColor:self.normalStateTitleColor forState:UIControlStateNormal];
    [self setTitleColor:self.highlightStateTitleColor forState:UIControlStateHighlighted];
    
}

- (void)setEnabled:(BOOL)enabled {
    [super setEnabled:enabled];
    
    if (enabled) {
        self.backGradientLayer.colors = self.normalBackGradientLayerColors;
    } else {
        self.backGradientLayer.colors = self.disabledBackGradientLayerColors;
    }
}

- (void)setGrayEnble:(BOOL)grayEnble {
    _grayEnble = grayEnble;
    
    if (grayEnble) {
        self.backGradientLayer.colors = self.disabledBackGradientLayerColors;
    } else {
        self.backGradientLayer.colors = self.normalBackGradientLayerColors;
        
    }
}

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    if (self.grayEnble) {
        return;
    }
    if (highlighted) {
        self.backGradientLayer.colors = self.highlightedBackGradientLayerColors;
    } else {
        
        self.backGradientLayer.colors = self.normalBackGradientLayerColors;
        if (self.grayEnble == YES) {
            self.backGradientLayer.colors = self.disabledBackGradientLayerColors;
        }
    }
    
    
    
    if (self.style == LSWButtonStyleSecondaryButton) {
        if (highlighted) {
            self.layer.borderColor = UIColorFromHex(0xb6b6b6).CGColor;
            
        } else {
            self.layer.borderColor = UIColorFromHex(0x9b9b9b).CGColor;
        }
    }
    
}

- (void)setCornerRediu:(CGFloat)cornerRediu {
    _cornerRediu = cornerRediu;
    
    self.layer.cornerRadius = cornerRediu;
}

@end
