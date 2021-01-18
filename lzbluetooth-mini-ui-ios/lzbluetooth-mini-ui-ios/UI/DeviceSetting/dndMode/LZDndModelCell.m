//
//  LZDndModelCell.m
//  LSBluetoothUI_iOS
//
//  Created by wm on 2020/12/10.
//

#import "LZDndModelCell.h"

@interface LZDndModelCell ()
@property (nonatomic, strong) LZDndModelCellModel *cellModel;
@end

@implementation LZDndModelCell

- (void)createUI {
    [super createUI];
    [self.switchControl addTarget:self action:@selector(switchStatusChange:) forControlEvents:UIControlEventValueChanged];
}

- (void)updateCellWithModel:(__kindof LZBaseSetCellModel *)cellModle {
    self.cellModel = (LZDndModelCellModel *)cellModle;
    [super updateCellWithModel:cellModle];
}

- (void)switchStatusChange:(UISwitch *)switchControl {
    if (self.delegate && [self.delegate respondsToSelector:@selector(switchOn:cellModel:)]) {
        [self.delegate switchOn:switchControl.on cellModel:self.cellModel];
    }
}

@end
