//
//  LZSettingTableViewCell.m
//  LSBluetoothUI_iOS
//
//  Created by wm on 2020/12/2.
//

#import "LZSettingTableViewCell.h"
#import <Masonry/Masonry.h>

@interface LZSettingTableViewCell ()

@end

@implementation LZSettingTableViewCell

@synthesize delegate;

- (void)createUI {
    [super createUI];
    [self.unbindButton addTarget:self action:@selector(clickUnbindBut) forControlEvents:UIControlEventTouchUpInside];
  
}

#pragma mark - public Mehods


- (void)clickUnbindBut {
    if (self.delegate && [self.delegate respondsToSelector:@selector(unbindClick:)]) {
        [self.delegate unbindClick:self.cellModel];
    }
}

@end
