//
//  LZNightModelCell.m
//  LSBluetoothUI_iOS
//
//  Created by wm on 2020/12/10.
//

#import "LZNightModelCell.h"


@interface LZNightModelCell ()
@property (nonatomic, strong) LZNightModelCellModel *cellModel;
@end

@implementation LZNightModelCell

- (void)createUI {
    [super createUI];
    [self.switchControl addTarget:self action:@selector(switchStatusChanged:) forControlEvents:UIControlEventValueChanged];
}

- (void)updateCellWithModel:(__kindof LZBaseSetCellModel *)cellModle {
    self.cellModel = cellModle;
    [super updateCellWithModel:cellModle];
}

- (void)switchStatusChanged:(UISwitch *)switchControl {
    if (self.delegate && [self.delegate respondsToSelector:@selector(switchOn:cellModle:)]) {
        [self.delegate switchOn:switchControl.on cellModle:self.cellModel];
    }
}

@end
