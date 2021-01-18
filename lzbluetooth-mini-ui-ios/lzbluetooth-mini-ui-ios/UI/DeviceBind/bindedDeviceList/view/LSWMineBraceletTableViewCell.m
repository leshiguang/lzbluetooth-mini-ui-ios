//
//  LSWMineBraceletTableViewCell.m
//  LSWearable
//
//  Created by malai on 2016/12/10.
//  Copyright © 2016年 lifesense. All rights reserved.
//

#import "LSWMineBraceletTableViewCell.h"
#import <Masonry/Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <LZBluetooth/LZBluetooth.h>


static CGFloat iconImageViewSize = 36;
//static CGFloat rightArrowImageViewTrailing = 20;
static CGFloat deviceNameLabelFontSize = 18;

@interface LSWMineBraceletTableViewCell ()

@property (nonatomic) UIView *wrapperView;

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UILabel *deviceNameLabel;

@property (nonatomic, strong) UIImageView *rightArrowImageView;

@property (nonatomic, strong) UILabel *connectLabel;

@property (nonatomic, strong) UILabel *dataFromLabel;

@property (nonatomic, assign) BOOL connecting;

@property (nonatomic, strong) UIImageView *typeImageView;

@property (nonatomic) LZBaseDevice *device;

/**
 是否是唯一一个，如果是唯一一个则不显示数据来源
 */
@property (nonatomic, assign) BOOL isOnlyOne;

/**
 手机蓝牙是否打开
 */
@property (nonatomic, assign) BOOL bluetoothEnabled;


@end

@implementation LSWMineBraceletTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self setupUI];
    }
    return self;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    self.connectLabel.hidden = NO;
}

#pragma mark - Public
- (void)updateUIWithDevice:(LZBaseDevice *)device isOnlyOne:(BOOL)isOnlyOne bluetoothEnabled:(BOOL)bluetoothEnabled{
    self.isOnlyOne = isOnlyOne;
    self.device = device;
    self.bluetoothEnabled = bluetoothEnabled;
    UIImage * image = [UIImage imageNamed:@"DB_device_placeholder"];
    self.iconImageView.image = image;
    self.deviceNameLabel.text = device.name;

    [self processConnectStatuDisplayStrings:self.device.connectStatus];

}

#pragma mark - Private
- (void)setupUI {
    
    [self.contentView addSubview:self.connectLabel];
    [self.contentView addSubview:self.typeImageView];
    [self.contentView addSubview:self.iconImageView];
    [self.contentView addSubview:self.deviceNameLabel];
    [self.contentView addSubview:self.rightArrowImageView];
    
    iconImageViewSize = 48;
    [self.iconImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.contentView).offset(20);
        make.size.mas_equalTo(iconImageViewSize);
        make.centerY.mas_equalTo(self.contentView);
    }];
    
    [self.deviceNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.contentView.mas_centerY).offset(0);
        make.leading.mas_equalTo(self.iconImageView.mas_trailing).offset(19);
    }];
    
    [self.rightArrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self.contentView).offset(-15);
        make.centerY.mas_equalTo(self.contentView);
    }];
    
    [_typeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.deviceNameLabel);
        make.top.mas_equalTo(self.contentView.mas_centerY).offset(4);
        make.height.equalTo(@16);
        make.width.equalTo(@16);
    }];
    
    [self.connectLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.typeImageView.mas_right).offset(5);
        make.top.mas_equalTo(_typeImageView);
    }];
    
}

- (void)updateSelectUIWithAnimation:(BOOL)animation {
    
    
    [self setNeedsUpdateConstraints];
    
    if (animation) {
        [UIView animateWithDuration:0.2 animations:^{
            [self layoutIfNeeded];
        }];
    }
}

// 1 网络  2 wifi 3 GPRS 4 蓝牙 5 GPRS - Wifi 6 NB
- (void)processConnectStatuDisplayStrings:(LZDeviceConnectStatus)connectState{
    NSString *string = @"";
    switch (connectState) {
        case LZDeviceConnectStatusConnected:
            string = @"已连接";
            break;
        case LZDeviceConnectStatusConnecting:
            string = @"连接中";
            break;
        case LZDeviceConnectStatusDisconnecting:
            string = @"断开连接中";
            break;
        case LZDeviceConnectStatusDisconnected:
            string = @"未连接";
            break;
            
        default:
            break;
    }
   
    self.connectLabel.text = string;
    
    BOOL connected = connectState == LZDeviceConnectStatusConnected;
    if (connected) {
        _typeImageView.image = [UIImage imageNamed:@""];
    } else {
        _typeImageView.image = [UIImage imageNamed:@""];
    }
}

#pragma mark - getter
- (UILabel *)connectLabel {
    if (!_connectLabel) {
        _connectLabel = [[UILabel alloc] init];
        _connectLabel.textColor = [UIColor blackColor];
        _connectLabel.font = [UIFont systemFontOfSize:15];
    }
    return _connectLabel;
}

- (UIImageView *)typeImageView {
    if (!_typeImageView) {
        _typeImageView = [[UIImageView alloc]init];
        [_typeImageView setContentMode:UIViewContentModeScaleAspectFit];
        _typeImageView.image = [UIImage imageNamed:@"home_page_bluetooth_gray"];
    }
    return _typeImageView;
}

- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
    }
    return _iconImageView;
}

- (UILabel *)deviceNameLabel {
    if (!_deviceNameLabel) {
        _deviceNameLabel = [[UILabel alloc] init];
        _deviceNameLabel.textColor = [UIColor blackColor];
        
        _deviceNameLabel.font = [UIFont boldSystemFontOfSize:deviceNameLabelFontSize];
        
    }
    return _deviceNameLabel;
}

- (UIImageView *)rightArrowImageView {
    if (!_rightArrowImageView) {
        _rightArrowImageView = [[UIImageView alloc] init];
        _rightArrowImageView.image = [UIImage imageNamed:@"Mine_zh_icn_arrow"];
    }
    return _rightArrowImageView;
}

@end
