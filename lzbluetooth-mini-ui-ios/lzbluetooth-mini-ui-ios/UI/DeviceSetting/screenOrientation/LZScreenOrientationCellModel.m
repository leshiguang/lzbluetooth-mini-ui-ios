//
//  LZScreenOrientationCellModel.m
//  LSBluetoothUI_iOS
//
//  Created by wm on 2020/12/10.
//

#import "LZScreenOrientationCellModel.h"

@implementation LZScreenOrientationCellModel

+ (NSArray<__kindof LZBaseSetCellModel *> *)cellModelList {
    NSMutableArray *mAry = [[NSMutableArray alloc] init];
    LZScreenOrientationCellModel *model1 = [[LZScreenOrientationCellModel alloc] initModelWithSetType:LZScreenOrientationSetStyleHorizontal cellStyle:DEVICESETCELLSTYLE_RIGHT_SELECTIMAGE titleStr:@"水平" subStr:nil];
    [mAry addObject:model1];
    
    LZScreenOrientationCellModel *model2 = [[LZScreenOrientationCellModel alloc] initModelWithSetType:LZScreenOrientationSetStyleVertical cellStyle:DEVICESETCELLSTYLE_RIGHT_SELECTIMAGE titleStr:@"垂直" subStr:nil];
    [mAry addObject:model2];
    
    return mAry;
}

@end
