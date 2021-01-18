//
//  LSWBluetoothSearchingDeviceView.m
//  LSWearable
//
//  Created by Wenzheng Zhang on 2017/2/27.
//  Copyright © 2017年 lifesense. All rights reserved.
//

#import "LSWBluetoothSearchingDeviceView.h"
#import "LSCircleWaveAnimationView.h"
#import <Masonry/Masonry.h>
#import "LSWAppAppearanceConfigrationMacro.h"

@interface LSWBluetoothSearchingDeviceView ()
@property (nonatomic, strong, readwrite) UILabel *titleLabel;
@property (nonatomic, strong, readwrite) UILabel *hintContentLabel;
@property (nonatomic, strong, readwrite) UIImageView *iconImageButton;
@property (nonatomic, strong) LSCircleWaveAnimationView *circleAnimationView;
@property (nonatomic, assign) CGFloat titleAndHintContentPadding;
@end

@implementation LSWBluetoothSearchingDeviceView

#pragma mark - Life Cycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    self.backgroundColor = [UIColor whiteColor];
    _titleAndHintContentPadding = 7;
    [self initializedPrivateViews];
    [self addSubview:_circleAnimationView];
    [self addSubview:_titleLabel];
    [self addSubview:_hintContentLabel];
    [self addSubview:_iconImageButton];
    
    CGFloat ratio = CGRectGetHeight([UIScreen mainScreen].bounds) / IPHONE_6_Height;
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.equalTo(self).with.insets(UIEdgeInsetsMake(114 * ratio, 15, 0, 15));
    }];
    
    [self.hintContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self).with.insets(UIEdgeInsetsMake(0, 15, 0, 15));
        make.top.equalTo(self.titleLabel.mas_bottom).with.offset(self.titleAndHintContentPadding);
    }];
    
    [self.iconImageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).with.offset(-68);
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    [self.circleAnimationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

#pragma mark - Public APIs

- (void)startWaveAnimation {
    [self layoutIfNeeded];
    [self.circleAnimationView startAnimationWithCircleWaveCenter:self.iconImageButton.center];
}

- (void)stopWaveAnimation {
    [self.circleAnimationView stopAnimation];
}

#pragma mark - Private Method
- (void)initializedPrivateViews {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = LSWDefaultMediumFontWithSize(32);
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = @"正在搜索";
    }
    
    if (_hintContentLabel == nil) {
        _hintContentLabel = [[UILabel alloc] init];
        _hintContentLabel.font = [UIFont systemFontOfSize:20];
        _hintContentLabel.textColor = [UIColor blackColor];
        _hintContentLabel.textAlignment = NSTextAlignmentCenter;
        _hintContentLabel.text = @"请让手机靠近设备";
        _hintContentLabel.numberOfLines = 0;
    }
    
    if (_iconImageButton == nil) {
        _iconImageButton = [[UIImageView alloc] init];
        _iconImageButton.image = [UIImage imageNamed:@"DB_ic_phone"];
    }
    
    if (_circleAnimationView == nil) {
        _circleAnimationView = [[LSCircleWaveAnimationView alloc] init];
    }
}


@end
