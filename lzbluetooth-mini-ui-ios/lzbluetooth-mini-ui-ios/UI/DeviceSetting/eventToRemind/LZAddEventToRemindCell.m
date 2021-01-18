//
//  LZAddEventToRemindCell.m
//  LSBluetoothUI_iOS
//
//  Created by wm on 2020/12/9.
//

#import "LZAddEventToRemindCell.h"

@interface LZAddEventToRemindCell ()
@property (nonatomic, strong) LZAddEventToRemindCellModel *cellModel;
@end

@implementation LZAddEventToRemindCell


- (void)createUI {
    [super createUI];
    [self.switchControl addTarget:self action:@selector(switchSatusChanged:) forControlEvents:UIControlEventValueChanged];
}

#pragma mark - public Mehods
- (void)updateCellWithModel:(LZBaseSetCellModel *)cellModle {
    self.cellModel = (LZAddEventToRemindCellModel *)cellModle;
    [super updateCellWithModel:cellModle];
}

#pragma mark - event
- (void)switchSatusChanged:(UISwitch *)switchControl {
    if (self.delegate && [self.delegate respondsToSelector:@selector(switchOn:cellModle:)]) {
        [self.delegate switchOn:switchControl.on cellModle:self.cellModel];
    }
}
@end
