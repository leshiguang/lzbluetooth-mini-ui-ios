//
//  LZInputStringTableViewCell.m
//  lzbluetooth-mini-ui-ios
//
//  Created by tanjian on 2021/1/22.
//

#import "LZInputStringTableViewCell.h"
#import <Masonry/Masonry.h>

@interface LZInputStringTableViewCell ()

@end

@implementation LZInputStringTableViewCell

@dynamic delegate;

- (void)createUI {
    [super createUI];
    
    [self.contentView addSubview:self.textField];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.leading.mas_equalTo(self.titleLabel.mas_trailing).offset(20);
        make.trailing.mas_equalTo(self.switchControl.mas_leading);
    }];
    
    [self.textField addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventEditingChanged];
}

- (void)updateCellWithModel:(__kindof LZBaseSetCellModel *)cellModle {
    [super updateCellWithModel:cellModle];
    self.subContentLabel.hidden = YES;
    self.textField.text = cellModle.subStr;
}

- (void)valueChanged:(UITextField *)textField {
    self.cellModel.subStr = textField.text;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(inputTableViewCellDidInputString:cellModle:)]) {
        [self.delegate inputTableViewCellDidInputString:textField.text cellModle:self.cellModel];
    }
}

- (UITextField *)textField {
    if (!_textField) {
        UITextField *textField = [[UITextField alloc] init];
        textField.placeholder = @"请输入appid";
        textField.text = @"";
        _textField = textField;
    }
    return _textField;
}

@end
