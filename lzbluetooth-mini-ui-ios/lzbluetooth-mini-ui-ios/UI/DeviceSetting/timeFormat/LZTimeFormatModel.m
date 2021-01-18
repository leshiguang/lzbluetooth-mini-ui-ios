//
//  LZTimeFormatModel.m
//  LSBluetoothUI_iOS
//
//  Created by wm on 2020/12/11.
//

#import "LZTimeFormatModel.h"

@implementation LZTimeFormatModel

+ (NSArray<__kindof LZBaseSetCellModel *> *)cellModelList {
    NSMutableArray *mAry = [[NSMutableArray alloc] init];
    
    LZTimeFormatModel *model1 = [[LZTimeFormatModel alloc] initModelWithSetType:LZTimeFormatSetType24Hours cellStyle:DEVICESETCELLSTYLE_RIGHT_SELECTIMAGE titleStr:@"24小时制" subStr:nil];
    [mAry addObject:model1];
    
    LZTimeFormatModel *model2 = [[LZTimeFormatModel alloc] initModelWithSetType:LZTimeFormatSetType12Hours cellStyle:DEVICESETCELLSTYLE_RIGHT_SELECTIMAGE titleStr:@"12小时制" subStr:nil];
    [mAry addObject:model2];
    
    return mAry;
}

@end
