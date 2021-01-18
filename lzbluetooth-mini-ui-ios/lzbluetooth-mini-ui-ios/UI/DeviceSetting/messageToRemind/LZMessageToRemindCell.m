//
//  LZMessageToRemindCell.m
//  LSBluetoothUI_iOS
//
//  Created by wm on 2020/12/10.
//

#import "LZMessageToRemindCell.h"

@interface LZMessageToRemindCell ()
@property (nonatomic, strong) LZMessageToRemindCellModel *cellModel;
@end

@implementation LZMessageToRemindCell

- (void)createUI {
    [super createUI];
    [self.switchControl addTarget:self action:@selector(switchSatusChanged:) forControlEvents:UIControlEventValueChanged];
}

- (void)updateCellWithModel:(__kindof LZBaseSetCellModel *)cellModle {
    self.cellModel = (LZMessageToRemindCellModel *)cellModle;
    [super updateCellWithModel:cellModle];
}

- (void)switchSatusChanged:(UISwitch *)switchControl {
    if (self.delegate && [self.delegate respondsToSelector:@selector(switchOn:cellModle:)]) {
        [self.delegate switchOn:switchControl.on cellModle:self.cellModel];
    }
}
@end
