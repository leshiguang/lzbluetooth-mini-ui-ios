//
//  LZSettingTableViewCell.m
//  LSBluetoothUI_iOS
//
//  Created by wm on 2020/12/2.
//

#import "LZSettingTableViewCell.h"
#import <Masonry/Masonry.h>

@interface LZSettingTableViewCell ()

@property (nonatomic, strong) LZSettingCellModel *cellModel;
@end

@implementation LZSettingTableViewCell

- (void)createUI {
    [super createUI];
    [self.unbindButton addTarget:self action:@selector(clickUnbindBut) forControlEvents:UIControlEventTouchUpInside];
    [self.switchControl addTarget:self action:@selector(switchSatusChanged:) forControlEvents:UIControlEventValueChanged];
}

#pragma mark - public Mehods
- (void)updateCellWithModel:(LZBaseSetCellModel *)cellModle {
    self.cellModel = (LZSettingCellModel *)cellModle;
    [super updateCellWithModel:cellModle];
}

#pragma mark - event
- (void)switchSatusChanged:(UISwitch *)switchControl {
    if (self.delegate && [self.delegate respondsToSelector:@selector(switchOn:cellModle:)]) {
        [self.delegate switchOn:switchControl.on cellModle:self.cellModel];
    }
}

- (void)clickUnbindBut {
    if (self.delegate && [self.delegate respondsToSelector:@selector(unbindClick:)]) {
        [self.delegate unbindClick:self.cellModel];
    }
}

@end
