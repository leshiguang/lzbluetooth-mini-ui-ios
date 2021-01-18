//
//  LZHeartRateCell.m
//  LSBluetoothUI_iOS
//
//  Created by wm on 2020/12/9.
//

#import "LZHeartRateWarningCell.h"

@interface LZHeartRateWarningCell ()
@property (nonatomic, strong) LZHearRateWarningCellModel *currentModel;
@end

@implementation LZHeartRateWarningCell

- (void)createUI {
    [super createUI];
    [self.switchControl addTarget:self action:@selector(switchStatusChange:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)updateCellWithModel:(__kindof LZBaseSetCellModel *)cellModle {
    self.currentModel = cellModle;
    [super updateCellWithModel:cellModle];
}

- (void)switchStatusChange:(UISwitch *)switchContrl {
    if (self.delegate && [self.delegate respondsToSelector:@selector(switchOn:cellModle:)]) {
        [self.delegate switchOn:switchContrl.isOn cellModle:self.currentModel];
    }
}

@end
