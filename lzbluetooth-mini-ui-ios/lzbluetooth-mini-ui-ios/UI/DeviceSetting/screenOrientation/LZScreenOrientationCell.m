//
//  LZScreenOrientationCell.m
//  LSBluetoothUI_iOS
//
//  Created by wm on 2020/12/10.
//

#import "LZScreenOrientationCell.h"

@interface LZScreenOrientationCell ()
@property (nonatomic, strong) LZScreenOrientationCellModel *cellModel;
@end

@implementation LZScreenOrientationCell


//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//}

- (void)createUI {
    [super createUI];
}

- (void)updateCellWithModel:(__kindof LZBaseSetCellModel *)cellModle {
    self.cellModel = (LZScreenOrientationCellModel *)cellModle;
    [super updateCellWithModel:cellModle];
}

@end
