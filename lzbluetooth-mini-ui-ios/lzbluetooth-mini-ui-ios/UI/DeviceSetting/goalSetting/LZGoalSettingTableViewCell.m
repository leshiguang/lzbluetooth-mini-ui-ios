//
//  LZGoalSettingTableViewCell.m
//  LSBluetoothUI_iOS
//
//  Created by wm on 2020/12/9.
//

#import "LZGoalSettingTableViewCell.h"

@interface LZGoalSettingTableViewCell ()
@property (nonatomic, strong) LZGoalSetModel *cellModel;
@end


@implementation LZGoalSettingTableViewCell

- (void)createUI {
    [super createUI];
    [self.switchControl addTarget:self action:@selector(switchSatusChanged:) forControlEvents:UIControlEventValueChanged];
}

#pragma mark - public Mehods
- (void)updateCellWithModel:(LZBaseSetCellModel *)cellModle {
    self.cellModel = (LZGoalSetModel *)cellModle;
    [super updateCellWithModel:cellModle];
}

#pragma mark - event
- (void)switchSatusChanged:(UISwitch *)switchControl {
    if (self.delegate && [self.delegate respondsToSelector:@selector(switchOn:cellModle:)]) {
        [self.delegate switchOn:switchControl.on cellModle:self.cellModel];
    }
}


@end
