//
//  LZHearRateCellModel.m
//  LSBluetoothUI_iOS
//
//  Created by wm on 2020/12/9.
//

#import "LZHearRateWarningCellModel.h"

@implementation LZHearRateWarningCellModel

+ (NSArray<__kindof LZBaseSetCellModel *> *)cellModelList {
    
    NSMutableArray *mAry = [[NSMutableArray alloc] init];
    LZHearRateWarningCellModel *model1 = [[LZHearRateWarningCellModel alloc] initModelWithSetType:LZHearRateWarningStyleSwitch cellStyle:DEVICESETCELLSTYLE_RIGHT_SWITCH titleStr:@"预警开关" subStr:nil];
    [mAry addObject:model1];
    
    LZHearRateWarningCellModel *model2 = [[LZHearRateWarningCellModel alloc] initModelWithSetType:LZHearRateWarningStyleZone cellStyle:DEVICESETCELLSTYLE_RIGHT_IMG_SUBTITLE titleStr:@"心率区间" subStr:@"20~30"];
    [mAry addObject:model2];
    
    return [mAry copy];
}

@end
