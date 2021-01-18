//
//  LSWBindingDeviceView.m
//  LSWearable
//
//  Created by symons on 2019/10/29.
//  Copyright © 2019 lifesense. All rights reserved.
//

#import "LSWBindingDeviceView.h"
#import <SDWebImage/UIImageView+WebCache.h>

#import <Masonry/Masonry.h>
#import "LSWButton.h"
#import "LSWAppColorConfigrationMacro.h"
#import "LSWAppAppearanceConfigrationMacro.h"


typedef NS_ENUM(NSInteger, LSWBindingViewButtonTag){
    LSWBindingViewButtonTagAction = 1001,
    LSWBindingViewButtonTagOk, //
    LSWBindingViewButtonTagNo, //
    LSWBindingViewButtonTagGuide,
};

@interface LSWBindingDeviceView()

@property (nonatomic, strong) UIImageView *imageView; //设备图片

@property (nonatomic, strong) UILabel *firstLabel;  // 设备名称、设备绑定状态字段

@property (nonatomic, strong) UILabel *secondLabel;

@property (nonatomic, strong) UILabel *bindFailLabel; //绑定失败

@property (nonatomic, strong) LSWButton *actionButton;

@property (nonatomic, strong) LSWButton *okBtn;

@property (nonatomic, strong) LSWButton *noBtn;

@property (nonatomic, strong) UIButton *guideBtn;

@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;  //绑定状态

@property (nonatomic, copy) NSString *deviceName;

@property (nonatomic, copy) UIView *bindingView;


@end


@implementation LSWBindingDeviceView

#pragma mark - Life Cycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    
    self.inputCodeLength = 4;
    self.backgroundColor = [UIColor whiteColor];

    
    if (_bindingView == nil){
        _bindingView = [[UIView alloc]init];
        _bindingView.backgroundColor = [UIColor clearColor];
    }
    
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    
    if (_firstLabel == nil) {
        _firstLabel = [[UILabel alloc] init];
        _firstLabel.textColor = UIColorFromHex(0x4A4A4A);
        _firstLabel.textAlignment = NSTextAlignmentCenter;
        _firstLabel.font = [UIFont boldSystemFontOfSize:20];
        _firstLabel.numberOfLines = 0;
    }
    if (_secondLabel == nil) {
        _secondLabel = [[UILabel alloc] init];
        _secondLabel.font = [UIFont systemFontOfSize:14];
        _secondLabel.textColor = UIColorFromHex(0x9F9F9F);
    }
    
    if (_actionButton == nil) {
        _actionButton = [[LSWButton alloc] initWithButtonStyle:LSWButtonStyleNewPrimaryButtonWithDeepBlueColor];
        _actionButton.layer.cornerRadius = 25.0;
        [_actionButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        _actionButton.tag = LSWBindingViewButtonTagAction;
    }
    
    if (_okBtn == nil) {
        _okBtn = [[LSWButton alloc] initWithButtonStyle:LSWButtonStyleNewPrimaryButtonWithDeepBlueColor];
        [_okBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        _okBtn.tag = LSWBindingViewButtonTagOk;
        [_okBtn setTitle:@"是的" forState:UIControlStateNormal];
        
    }
    
    if (_noBtn == nil) {
        _noBtn = [[LSWButton alloc] initWithButtonStyle:LSWButtonStyleNewPrimaryButtonWithWhiteColor];
        [_noBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        _noBtn.tag = LSWBindingViewButtonTagNo;
        [_noBtn setTitle:@"不了" forState:UIControlStateNormal];
    }
    
    if (_guideBtn == nil) {
        _guideBtn = [[UIButton alloc] init];
        [_guideBtn setTitleColor:LSWKeyColor forState:UIControlStateNormal];
        [_guideBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        _guideBtn.titleLabel.font = [UIFont systemFontOfSize:14];
         [_guideBtn setTitle:@"了解设备如何操作" forState:UIControlStateNormal];
        _guideBtn.tag = LSWBindingViewButtonTagGuide;
    }
    
    if (_bindFailLabel == nil) {
        _bindFailLabel = [[UILabel alloc] init];
        _bindFailLabel.font = [UIFont systemFontOfSize:15];
        _bindFailLabel.textColor = UIColorFromHex(0xFD5E45);
        _bindFailLabel.text = @"*请将手机靠近设备，尝试重新绑定";
    }
    
    if (_activityIndicator == nil) {
        _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    }
    [self addSubview:self.bindingView];
    [self addSubview:self.enterRandomCodeView];
    
    [self.bindingView addSubview:self.imageView];
    [self.bindingView addSubview:self.firstLabel];
    [self.bindingView addSubview:self.secondLabel];
    [self.bindingView addSubview:self.actionButton];
    [self.bindingView addSubview:self.okBtn];
    [self.bindingView addSubview:self.noBtn];
    [self.bindingView addSubview:self.guideBtn];
    [self.bindingView addSubview:self.bindFailLabel];
    [self.bindingView addSubview:self.activityIndicator];
    
    self.currentState = LSWDeviceBindingStateNone;
    
    CGFloat ratio = CGRectGetHeight([UIScreen mainScreen].bounds) / IPHONE_6_Height;
    
    [self.bindingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).with.offset(60 * ratio + LSW_NavigationBarHeight);
        make.centerX.equalTo(self.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(240, 240));
    }];
    
    [self.firstLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageView.mas_bottom).with.offset(28);
        make.centerX.equalTo(self);
    }];
    
    [self.actionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottom).offset(-70);
        make.height.mas_equalTo(@50);
        make.left.equalTo(self.mas_left).offset(70);
        make.right.equalTo(self.mas_right).offset(-70);
    }];
    
    
    [self.noBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@54);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-70);
        make.right.mas_equalTo(self.mas_right).offset(-30);
        make.left.mas_equalTo(self.mas_centerX).offset(5.5);
    }];
    
    [self.okBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@54);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-70);
        make.right.mas_equalTo(self.mas_right).offset(-30);
        make.left.mas_equalTo(self.mas_centerX).offset(-5.5);
    }];
    
    
    [self.secondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.firstLabel.mas_bottom).offset(10);
        make.centerX.equalTo(self);
    }];
    
    [self.activityIndicator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.mas_equalTo(self.secondLabel.mas_bottom).offset(15);
    }];
    
    [self.enterRandomCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.guideBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.bottom.equalTo(self.actionButton.mas_top).with.offset(-50);
    }];
    
    [self.bindFailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.firstLabel.mas_bottom).offset(20);
        make.centerX.equalTo(self);
    }];
}


#pragma mark - Button Action
- (void)buttonAction:(UIButton *)button{
    if (!self.delegate || ![self.delegate respondsToSelector:@selector(lswBindingDeviceViewDidTapAtionType:)]){
        return;
    }
    LSWBindingViewDeviceTapActionType actionType = LSWBindingViewDeviceTapActionTypeBindNone;

    switch (button.tag) {
        case LSWBindingViewButtonTagNo:
            actionType = LSWBindingViewDeviceTapActionTypeBindSetActiveDeviceNo;
            break;
        case LSWBindingViewButtonTagOk:
            actionType = LSWBindingViewDeviceTapActionTypeBindSetActiveDeviceYes;
            break;
        case LSWBindingViewButtonTagAction:{
            if (self.currentState == LSWDeviceBindingStateWaitingBind){
                actionType = LSWBindingViewDeviceTapActionTypeBindNow;
            }else if (self.currentState == LSWDeviceBindingStateBindSucceed){
                actionType = LSWBindingViewDeviceTapActionTypeBindDone;
            }else if (self.currentState == LSWDeviceBindingStateBindFailed){
                actionType = LSWBindingViewDeviceTapActionTypeBindReBind;
            }
        }
            break;
        case LSWBindingViewButtonTagGuide:
            actionType = LSWBindingViewDeviceTapActionTypeBindGuideAction;
            break;
        default:
            break;
    }
    [self.delegate lswBindingDeviceViewDidTapAtionType:actionType];

}

- (void)guideButtonAction:(UIButton *)button{
    
}

#pragma mark - Public
- (void)setDeviceName:(NSString *)deviceName imageUrl:(NSString *)imageUrl placeHolderImage:(UIImage *)placeHolderImage{
    self.deviceName = deviceName;
    self.firstLabel.text = self.deviceName;
    if (imageUrl == nil) {
         self.imageView.image = placeHolderImage;
    }else{
        NSURL *url = [[NSURL alloc]initWithString:imageUrl];
        [self.imageView sd_setImageWithURL:url placeholderImage:placeHolderImage];
    }
}

- (void)changeBindingStateTo:(LSWDeviceBindingState)state{
    self.currentState = state;
    switch (self.currentState) {
        case LSWDeviceBindingStateWaitingBind:
            [self waitBindingUI];
            break;
        case LSWDeviceBindingStateBinding:
            [self bindingUI];
            break;
        case LSWDeviceBindingStateBindSucceed:
            [self bindSucceedUI];
            break;
        case LSWDeviceBindingStateBindFailed:
            [self bindFailedUI];
            break;
        case LSWDeviceBindingStateWaitingInput:
            [self waitingInputUI];
            break;
        case LSWDeviceBindingStateSwitchActiveDevice:
            [self waitingSwitchActiveUI];
            break;
        default:
            break;
    }
}

- (void)waitBindingUI{
    self.firstLabel.text = self.deviceName;
    self.secondLabel.text = @"等待绑定";
    [self.actionButton setTitle:@"立即绑定" forState:UIControlStateNormal];
    
    
    self.actionButton.hidden = NO;
    self.bindFailLabel.hidden = YES;
    self.guideBtn.hidden = YES;
    self.okBtn.hidden = YES;
    self.noBtn.hidden = YES;
    self.activityIndicator.hidden = YES;
    self.bindingView.hidden = NO;
    self.enterRandomCodeView.hidden = YES;
    
    [self.activityIndicator stopAnimating];
}

- (void)bindingUI{
     self.firstLabel.text = self.deviceName;
    self.secondLabel.hidden = NO;
    self.secondLabel.text = @"正在绑定";
    self.actionButton.hidden = YES;
    [self.activityIndicator startAnimating];
    
    self.firstLabel.hidden = NO;
    self.actionButton.hidden = NO;
    self.bindFailLabel.hidden = YES;
    self.activityIndicator.hidden = NO;
    self.guideBtn.hidden = YES;
    self.okBtn.hidden = YES;
    self.noBtn.hidden = YES;
    self.actionButton.hidden = YES;
    self.bindingView.hidden = NO;
    self.enterRandomCodeView.hidden = YES;
}

- (void)bindFailedUI{
    self.firstLabel.text = @"绑定失败";
    [self.actionButton setTitle:@"重新绑定" forState:UIControlStateNormal];
   
    self.actionButton.hidden = NO;
    self.secondLabel.hidden = YES;
    self.bindFailLabel.hidden = NO;
    self.guideBtn.hidden = YES;
    self.okBtn.hidden = YES;
    self.noBtn.hidden = YES;
    self.activityIndicator.hidden = YES;
    self.bindingView.hidden = NO;
    self.enterRandomCodeView.hidden = YES;
    
    [self.activityIndicator stopAnimating];
}

- (void)bindSucceedUI{
    self.firstLabel.text = @"绑定成功";
    

    self.actionButton.hidden = NO;
    self.bindFailLabel.hidden = YES;
    self.secondLabel.hidden = YES;
    self.okBtn.hidden = YES;
    self.noBtn.hidden = YES;
    self.activityIndicator.hidden = YES;
    self.bindingView.hidden = NO;
    self.enterRandomCodeView.hidden = YES;
    
    [self.activityIndicator stopAnimating];
    
    self.guideBtn.hidden = NO;
    
    [self.actionButton setTitle:@"完成" forState:UIControlStateNormal];
}

- (void)waitingInputUI{
   
    [self updateInputRandomCodeView];

    self.enterRandomCodeView.hidden = NO;
    self.bindingView.hidden = YES;
}

- (void)waitingSwitchActiveUI{
    self.firstLabel.text = @"更换活跃设备";
    self.secondLabel.text = [NSString stringWithFormat:@"是否将%@设置为\n你的活动追踪器？", self.deviceName];

    self.actionButton.hidden = YES;
    self.bindFailLabel.hidden = YES;
    self.guideBtn.hidden = YES;
    self.secondLabel.hidden = NO;
    self.okBtn.hidden = NO;
    self.noBtn.hidden = NO;
    self.bindingView.hidden = NO;
    self.enterRandomCodeView.hidden = YES;
}

- (void)updateInputRandomCodeView{
    [self.enterRandomCodeView removeFromSuperview];
    self.enterRandomCodeView = nil;
    [self addSubview:self.enterRandomCodeView];
//    if (self.hasAddedConstraints){
//        [self.enterRandomCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.edges.equalTo(self);
//        }];
//    }
}

- (void)setInputCodeLength:(NSInteger)inputCodeLength {
    _inputCodeLength = inputCodeLength;
    [self.enterRandomCodeView reloadInputViewWithLength:inputCodeLength];
}

#pragma mark - Setter
-(LSWEnterRandomCodeView *)enterRandomCodeView{
    if (_enterRandomCodeView == nil){
        _enterRandomCodeView = [[LSWEnterRandomCodeView alloc]initWithCodeLength:self.inputCodeLength frame:self.frame];
        _enterRandomCodeView.hidden = YES;
    }
    return _enterRandomCodeView;
}

@end
