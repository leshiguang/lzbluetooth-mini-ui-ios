//
//  LZAddEventToRemindContentTableViewCell.m
//  LSBluetoothUI_iOS
//
//  Created by wm on 2020/12/9.
//

#import "LZAddEventToRemindContentTableViewCell.h"
#import <Masonry/Masonry.h>
#import "LSWAppColorConfigrationMacro.h"
#import "LSWAppFontConfigrationMacro.h"

@interface LZAddEventToRemindContentTableViewCell () <UITextFieldDelegate>

@end

@implementation LZAddEventToRemindContentTableViewCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createUI];
    }
    return self;
}

- (void)createUI {
    
    [self.contentView addSubview:self.textView];
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@110);
        make.top.equalTo(self).offset(0);
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-15);
        make.bottom.equalTo(self).offset(0);
    }];
}

#pragma mark - UITextViewDelegates
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *temp = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (temp.length < 100) {
        if (self.textViewDidChangeBlock) {
            self.textViewDidChangeBlock(temp);
        }
        return YES;
    }
    return NO;
}

#pragma mark - getter
- (UITextField *)textView {
    if (!_textView) {
        _textView = [[UITextField alloc] init];
        _textView.delegate = self;
        _textView.placeholder = @"请输入提醒内容";
        _textView.textColor = UIColorFromHex(0xA3A3A3);
        _textView.font = LSWDefaultFontWithSize(16);
    }
    return _textView;
}

@end
