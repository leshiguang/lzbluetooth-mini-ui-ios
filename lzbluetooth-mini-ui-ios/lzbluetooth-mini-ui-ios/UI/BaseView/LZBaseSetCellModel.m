//
//  LZBaseSetCellModel.m
//  LSBluetoothUI_iOS
//
//  Created by wm on 2020/12/9.
//

#import "LZBaseSetCellModel.h"

@implementation LZBaseSetCellModel

- (LZBaseSetCellModel *)initModelWithSetType:(NSInteger)setType cellStyle:(DEVICESETCELLSTYLE)cellStyle titleStr:(NSString *)titleStr subStr:(NSString *)subStr {
    LZBaseSetCellModel *model = [[LZBaseSetCellModel alloc] init];
    model.setType = setType;
    model.cellStyle = cellStyle;
    model.titleStr = titleStr;
    model.subStr = subStr;
    model.switchIsOpne = NO;
    return model;
}

+ (NSArray <LZBaseSetCellModel *> *)cellModelList {
    return nil;
}
@end
