//
//  LSWEnterRandomCodeView.m
//  LSWearable
//
//  Created by Wenzheng Zhang on 2017/2/24.
//  Copyright © 2017年 lifesense. All rights reserved.
//

#import "LSWEnterRandomCodeView.h"
#import <Masonry/Masonry.h>
#import "LSRandomCodeInputView.h"
#import "LSWGradientView.h"
#import "LSWAppAppearanceConfigrationMacro.h"

CGFloat const _LSWERCVTextFieldKeyboardSpace = 50;


#pragma mark - LSWEnterRandomCodeView
@interface LSWEnterRandomCodeView () <LSRandomCodeInputViewDelegate>

@property (nonatomic, assign) BOOL hasAddedConstraints;
@property (nonatomic, strong) UILabel *hintContentLabel;
@property (nonatomic, strong) LSRandomCodeInputView *inputView;

@property (nonatomic, assign) BOOL shouldhandleKeyboradEvents;
@property (nonatomic, assign) BOOL hasAddedKeybordNotificationObservers;
@property (nonatomic, assign) CGFloat currentInputViewBottomToViewBottomOffset;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) LSWGradientView *gradientView;
@property (nonatomic, assign) NSInteger codeLength;

@end

@implementation LSWEnterRandomCodeView

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

#pragma mark - Life Cycle
- (instancetype)initWithCodeLength:(NSInteger)codeLength frame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _codeLength = codeLength;
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithCodeLength:4 frame:frame];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        _codeLength = 4;
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    
    self.backgroundColor = [UIColor whiteColor];
    if (!self.hasAddedKeybordNotificationObservers) {
        [self registerKeyboardNotification];
        self.hasAddedKeybordNotificationObservers = YES;
    }
    _currentInputViewBottomToViewBottomOffset = [self inputViewBottomToViewBottomMinOffset];
    [self initializedPrivateViews];
    [self addSubview:_gradientView];
    [self addSubview:_activityIndicator];
    [self addSubview:_hintContentLabel];
    [self addSubview:_inputView];
}

- (void)updateConstraints {
    
    if (!self.hasAddedConstraints) {
        
        [self.gradientView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        [self.inputView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom).with.offset(-[self inputViewBottomToViewBottomMinOffset]);
            make.centerX.equalTo(self.mas_centerX);
        }];
        
        CGSize activityIndicatorSize = CGSizeMake(16, 16);
        CGFloat offset = self.activityIndicator.hidden ? 0 : (activityIndicatorSize.width + 5) / 2.0;

        [self.hintContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.inputView.mas_bottom).with.offset(25);
            make.centerX.equalTo(self.mas_centerX).with.offset(offset);
        }];
        
        [self.activityIndicator mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(self.hintContentLabel.mas_leading).with.offset(-5);
            make.centerY.equalTo(self.hintContentLabel.mas_centerY);
            make.size.mas_equalTo(activityIndicatorSize);
        }];

        self.hasAddedConstraints = YES;
    }
    
    [super updateConstraints];
}

- (void)dealloc {
    if (_hasAddedKeybordNotificationObservers) {
        [self unregisterKeyboardNotification];
    }
}

#pragma mark - Public APIs

- (void)setHintContent:(NSString *)hintContent showActivityIndicator:(BOOL)showActivityIndicator {
    self.hintContentLabel.text = hintContent;
    self.activityIndicator.hidden = showActivityIndicator ? NO : YES;
    
    if (showActivityIndicator) {
        [self.activityIndicator startAnimating];
    } else {
        [self.activityIndicator stopAnimating];
    }
    
    if (self.hasAddedConstraints) {
        CGSize activityIndicatorSize = CGSizeMake(16, 16);
        CGFloat offset = self.activityIndicator.hidden ? 0 : (activityIndicatorSize.width + 5) / 2.0;
        
        [self.hintContentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX).with.offset(offset);
        }];
    }
    [self layoutIfNeeded];
}

- (void)showKeyboard {
    [self.inputView showKeyboard];
}

- (void)hideKeyboard {
    [self.inputView hideKeyboard];
}

- (void)clearAndReset {
    [self.inputView clearAndReset];
}

#pragma mark - LSRandomCodeInputViewDelegate
- (void)randomCodeInoputViewWillBeginEditing:(LSRandomCodeInputView *)randomCodeInputView {
    self.shouldhandleKeyboradEvents = YES;
}

- (void)randomCodeInoputView:(LSRandomCodeInputView *)randomCodeInputView didInputCode:(NSString *)code {
    if ([self.delegate respondsToSelector:@selector(enterRandomCodeView:didEnterCode:)]) {
        [self.delegate enterRandomCodeView:self didEnterCode:code];
    }
}

#pragma mark - Key Board Notification
- (void)registerKeyboardNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hanldeKeyboardWillShowNotification:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hanldeKeyboardWillHideNotification:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)unregisterKeyboardNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - handle keyboard event
- (void)hanldeKeyboardWillShowNotification:(NSNotification *)notification {
    
    if (!self.shouldhandleKeyboradEvents) return;
    
    NSDictionary *userInfo = notification.userInfo;
    CGRect keyboardBounds = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat offset = CGRectGetHeight(keyboardBounds) + _LSWERCVTextFieldKeyboardSpace;

    if (offset == self.currentInputViewBottomToViewBottomOffset) {
        return;
    }
    
    [self.inputView mas_updateConstraints:^(MASConstraintMaker *make) {
        if (offset > [self inputViewBottomToViewBottomMinOffset]) {
            make.bottom.equalTo(self.mas_bottom).with.offset(-offset);
        }
    }];
    
    NSTimeInterval duration  = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    NSInteger aniamtionCurve = [userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    [UIView animateKeyframesWithDuration:duration delay:0 options:aniamtionCurve animations:^{
        [self layoutIfNeeded];
    } completion:nil];
    self.currentInputViewBottomToViewBottomOffset = offset;
}

- (void)hanldeKeyboardWillHideNotification:(NSNotification *)notification {
    
    
    CGFloat offset = [self inputViewBottomToViewBottomMinOffset];
    
    if (offset == self.currentInputViewBottomToViewBottomOffset) {
        return;
    }
    
    [self.inputView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).with.offset(-offset);
    }];
    
    NSDictionary *userInfo = notification.userInfo;
    NSTimeInterval duration  = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    NSInteger aniamtionCurve = [userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    [UIView animateKeyframesWithDuration:duration delay:0 options:aniamtionCurve animations:^{
        [self layoutIfNeeded];
    } completion:nil];
    
    self.shouldhandleKeyboradEvents = NO;
    self.currentInputViewBottomToViewBottomOffset = offset;
}

#pragma mark - Private Methods

- (CGFloat)inputViewBottomToViewBottomMinOffset {
    CGFloat ratio = CGRectGetHeight([UIScreen mainScreen].bounds) / IPHONE_6_Height;
    CGFloat offset = CGRectGetHeight([UIScreen mainScreen].bounds) - LSW_NavigationBarHeight - 100 * ratio - 50 - 25 - 18;
    return offset;
}

#pragma mark - Private Method
- (void)initializedPrivateViews {

    if (_gradientView == nil) {
        _gradientView = [[LSWGradientView alloc] init];
        _gradientView.colors = @[UIColorFromHex(0xFFFFFF), UIColorFromHex(0xF2F2F2)];
    }
    
    if (_activityIndicator == nil) {
        _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    }
    
    if (_hintContentLabel == nil) {
        _hintContentLabel = [[UILabel alloc] init];
        _hintContentLabel.font = [UIFont systemFontOfSize:17];
        _hintContentLabel.textColor = LSWImportantContentFontColor;
        _hintContentLabel.textAlignment = NSTextAlignmentCenter;
        _hintContentLabel.text = @"请在30s内输入设备显示的4位随机码";
    }
    
    if (_inputView == nil) {
        
        NSInteger space = self.codeLength > 4 ? 15 : 20;
        CGSize cellSize = self.codeLength > 4 ? CGSizeMake(40, 40) : CGSizeMake(50, 50);
        
        _inputView = [[LSRandomCodeInputView alloc] initWithCodeLength:self.codeLength
                                                              cellSize:cellSize
                                                        interItemSpace:space];
        _inputView.delegate = self;
    }
}

- (void)reloadInputViewWithLength:(NSInteger)length{
    [_inputView removeFromSuperview];
    self.codeLength = length;
    if (_inputView == nil) {
        NSInteger space = self.codeLength > 4 ? 15 : 20;
        CGSize cellSize = self.codeLength > 4 ? CGSizeMake(40, 40) : CGSizeMake(50, 50);
        
        _inputView = [[LSRandomCodeInputView alloc] initWithCodeLength:self.codeLength
                                                              cellSize:cellSize
                                                        interItemSpace:space];
        _inputView.delegate = self;
    }
    [self addSubview:_inputView];
    
    self.hasAddedConstraints = NO;
    
    [self layoutIfNeeded];
    
}

- (LSRandomCodeInputView *)inputView{
    if (_inputView == nil) {
        
        NSInteger space = self.codeLength > 4 ? 15 : 20;
        CGSize cellSize = self.codeLength > 4 ? CGSizeMake(40, 40) : CGSizeMake(50, 50);
        
        _inputView = [[LSRandomCodeInputView alloc] initWithCodeLength:self.codeLength
                                                              cellSize:cellSize
                                                        interItemSpace:space];

        _inputView.delegate = self;
    }
    return _inputView;
}

@end
