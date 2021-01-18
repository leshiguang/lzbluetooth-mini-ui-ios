//
//  LZTimeFormatCell.m
//  LSBluetoothUI_iOS
//
//  Created by wm on 2020/12/11.
//

#import "LZTimeFormatCell.h"

@interface LZTimeFormatCell ()
@property (nonatomic, strong) LZTimeFormatModel *cellModel;
@end

@implementation LZTimeFormatCell

- (void)createUI {
    [super createUI];
}

- (void)updateCellWithModel:(__kindof LZBaseSetCellModel *)cellModle {
    self.cellModel = cellModle;
    [super updateCellWithModel:cellModle];
}

@end
