//
//  LZWearingHabitsCell.m
//  LSBluetoothUI_iOS
//
//  Created by wm on 2020/12/11.
//

#import "LZWearingHabitsCell.h"

@interface LZWearingHabitsCell ()
@property (nonatomic, strong) LZWearingHabitsModel *cellModel;
@end

@implementation LZWearingHabitsCell

- (void)createUI {
    [super createUI];
}

- (void)updateCellWithModel:(__kindof LZBaseSetCellModel *)cellModle {
    self.cellModel = cellModle;
    [super updateCellWithModel:cellModle];
}

@end
