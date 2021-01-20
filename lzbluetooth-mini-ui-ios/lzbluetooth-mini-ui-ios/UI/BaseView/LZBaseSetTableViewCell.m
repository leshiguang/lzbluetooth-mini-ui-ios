//
//  LZBaseSetTableViewCell.m
//  LSBluetoothUI_iOS
//
//  Created by wm on 2020/12/8.
//

#import "LZBaseSetTableViewCell.h"
#import <Masonry/Masonry.h>
#import "LSWAppColorConfigrationMacro.h"

@interface LZBaseSetTableViewCell ()

@property (nonatomic, strong) LZBaseSetCellModel *cellModel;

@end

@implementation LZBaseSetTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (!self.rightSelectImageView.hidden) {
        self.rightSelectImageView.image = [UIImage imageNamed:(selected ? @"DB_ic_multiselect_gray" : @"DB_ic_unselect_gray")];
    }
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:NO];

    //隐藏修改编辑模式下删除按钮图片
    for (UIControl *control in self.subviews) {
        if ([control isMemberOfClass:NSClassFromString(@"UITableViewCellEditControl")]) {
            for (UIView *v in control.subviews)  {
                if ([v isKindOfClass:[UIImageView class]]) {
                    UIImageView *img = (UIImageView *)v;
                    //网上有的方法让在这边修改图片，而不是再创建一个按钮，自己尝试了下发现有图片变形，或者移动cell时仍然会显示系统图片等问题，所以我没有采用这种方法，而是在这里设置为nil
                    img.image = nil;
                }
            }
        }
    }
}

- (void)createUI {
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.subContentLabel];
    [self.contentView addSubview:self.rightImage];
    [self.contentView addSubview:self.switchControl];
    [self.contentView addSubview:self.unbindButton];
    [self.contentView addSubview:self.rightSelectImageView];
    
    [self.switchControl addTarget:self action:@selector(switchSatusChanged:) forControlEvents:UIControlEventValueChanged];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView.mas_leading).with.offset(15);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    
    [self.subContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.titleLabel.mas_trailing).with.offset(20);
        make.trailing.equalTo(self.contentView.mas_trailing).with.offset(-15);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    
    [self.rightImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.contentView.mas_trailing).with.offset(-15);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.size.mas_equalTo(self.rightImage.image.size);
    }];
    
    [self.switchControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.contentView.mas_trailing).with.offset(-15);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    
    [self.unbindButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.contentView);
        make.width.offset(220);
        make.height.offset(50);
    }];
    
    [self.rightSelectImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.trailing.mas_equalTo(self.contentView).with.offset(-15);
        make.size.mas_equalTo(self.rightSelectImageView.image.size);
    }];
}

#pragma mark - public methods
- (void)updateCellWithModel:(LZBaseSetCellModel *)cellModle {
    self.cellModel = cellModle;
    
    self.rightImage.hidden = YES;
    self.subContentLabel.hidden = YES;
    self.switchControl.hidden = YES;
    self.unbindButton.hidden = YES;
    self.titleLabel.hidden = YES;
    self.rightSelectImageView.hidden = YES;
    switch (cellModle.cellStyle) {
        case DEVICESETCELLSTYLE_RIGHT_IMG: {
            self.titleLabel.hidden = NO;
            self.titleLabel.text = cellModle.titleStr;
            self.rightImage.hidden = NO;
        }
            break;
        case DEVICESETCELLSTYLE_RIGHT_SWITCH: {
            self.titleLabel.hidden = NO;
            self.titleLabel.text = cellModle.titleStr;
            self.switchControl.hidden = NO;
            [self.switchControl setOn:cellModle.switchIsOpne];
        }
            break;
        case DEVICESETCELLSTYLE_RIGHT_SUBTITLE: {
            self.titleLabel.hidden = NO;
            self.titleLabel.text = cellModle.titleStr;
            self.subContentLabel.hidden = NO;
            self.subContentLabel.text = cellModle.subStr;
            [self.subContentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.trailing.equalTo(self.contentView.mas_trailing).with.offset(-15);
            }];
        }
            break;
        case DEVICESETCELLSTYLE_RIGHT_IMG_SUBTITLE: {
            self.titleLabel.hidden = NO;
            self.titleLabel.text = cellModle.titleStr;
            self.subContentLabel.hidden = NO;
            self.subContentLabel.text = cellModle.subStr;
            self.rightImage.hidden = NO;
            [self.subContentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.trailing.equalTo(self.contentView.mas_trailing).with.offset(-10-self.rightImage.image.size.width -15);
            }];
        }
            break;
        case DEVICESETCELLSTYLE_UNBIND_DEVICE: {
            self.unbindButton.hidden = NO;
        }
            break;
        case DEVICESETCELLSTYLE_RIGHT_SELECTIMAGE: {
            self.titleLabel.hidden = NO;
            self.titleLabel.text = cellModle.titleStr;
            self.rightSelectImageView.hidden = NO;
        }
            break;
        default:
            break;
    }
}

#pragma mark - Event
- (void)switchSatusChanged:(UISwitch *)switchControl {
    if (self.delegate && [self.delegate respondsToSelector:@selector(switchOn:cellModle:)]) {
        [self.delegate switchOn:switchControl.on cellModle:self.cellModel];
    }
}

#pragma mark - getter
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"";
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}

- (UILabel *)subContentLabel {
    if (!_subContentLabel) {
        _subContentLabel = [[UILabel alloc] init];
        _subContentLabel.text = @"";
        _subContentLabel.font = [UIFont systemFontOfSize:14];
        _subContentLabel.textColor = UIColorFromHex(0xB6B6B6);
        _subContentLabel.textAlignment = NSTextAlignmentRight;
        _subContentLabel.hidden = YES;
    }
    return _subContentLabel;
}

- (UIImageView *)rightImage {
    if (!_rightImage) {
        _rightImage = [[UIImageView alloc] init];
        _rightImage.image = [UIImage imageNamed:@"Mine_zh_icn_arrow"];
        _rightImage.hidden = YES;
    }
    return _rightImage;
}

- (UISwitch *)switchControl {
    if (!_switchControl) {
        _switchControl = [[UISwitch alloc] init];
        _switchControl.onTintColor = UIColorFromHex(0x1EABE1);
        _switchControl.hidden = YES;
    }
    return _switchControl;
}

- (UIButton *)unbindButton {
    if (!_unbindButton) {
        _unbindButton = [[UIButton alloc] init];
        _unbindButton.layer.cornerRadius = 25;
        _unbindButton.layer.borderWidth = 1;
        _unbindButton.layer.borderColor = UIColorFromHex(0xb6b6b6).CGColor;
        [_unbindButton setTitle:@"解除绑定" forState:UIControlStateNormal];
        [_unbindButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _unbindButton.titleLabel.font = [UIFont systemFontOfSize:16];
        _unbindButton.hidden = YES;
    }
    return _unbindButton;
}

- (UIImageView *)rightSelectImageView {
    if (!_rightSelectImageView) {
        _rightSelectImageView = [[UIImageView alloc] init];
        _rightSelectImageView.image = [UIImage imageNamed:@"DB_ic_unselect_gray"];
        _rightSelectImageView.hidden = YES;
    }
    return _rightSelectImageView;
}

@end
