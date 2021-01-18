//
//  LZNightModelCellModel.m
//  LSBluetoothUI_iOS
//
//  Created by wm on 2020/12/10.
//

#import "LZNightModelCellModel.h"

@implementation LZNightModelCellModel

+ (NSArray<__kindof LZBaseSetCellModel *> *)cellModelList {
    NSMutableArray *mAry = [[NSMutableArray alloc] init];
    LZNightModelCellModel *model1 = [[LZNightModelCellModel alloc] initModelWithSetType:LZNightModelSetTypeSwitch cellStyle:DEVICESETCELLSTYLE_RIGHT_SWITCH titleStr:@"夜间模式开关" subStr:nil];
    [mAry addObject:model1];
    
    LZNightModelCellModel *model2 = [[LZNightModelCellModel alloc] initModelWithSetType:LZNightModelSetTypeStartTime cellStyle:DEVICESETCELLSTYLE_RIGHT_IMG_SUBTITLE titleStr:@"开始时间" subStr:@"15:32"];
    [mAry addObject:model2];
    
    LZNightModelCellModel *model3 = [[LZNightModelCellModel alloc] initModelWithSetType:LZNightModelSetTypeEndTime cellStyle:DEVICESETCELLSTYLE_RIGHT_IMG_SUBTITLE titleStr:@"结束时间" subStr:@"00:00"];
    [mAry addObject:model3];
    
    return mAry;
}

@end
