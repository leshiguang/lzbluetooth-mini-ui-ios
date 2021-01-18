//
//  LZSetPopUpTableViewCell.m
//  LSBluetoothUI_iOS
//
//  Created by wm on 2020/12/17.
//

#import "LZSetPopUpTableViewCell.h"

@implementation LZSetPopUpTableViewCell

- (void)layoutSubviews {
    [super layoutSubviews];
    [self updateSelectImage];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    [self updateSelectImage];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

//- (void)updateCellWithModel {
//    [self setSelected:YES animated:YES];
//}

- (void)updateSelectImage {
    for (UIControl *control in self.subviews) {
        if (![control isMemberOfClass:NSClassFromString(@"UITableViewCellEditControl")]) {
            continue;
        }
        for (UIView *subView in control.subviews) {
            if (![subView isKindOfClass: [UIImageView class]]) {
                continue;
            }
            UIImageView *imageView = (UIImageView *)subView;
            imageView.image = [UIImage imageNamed:(self.selected ? @"DB_ic_multiselect_gray" : @"DB_ic_unselect_gray")];
        }
    }
}

@end
