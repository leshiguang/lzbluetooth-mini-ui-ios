//
//  LZDndModelCellModel.m
//  LSBluetoothUI_iOS
//
//  Created by wm on 2020/12/10.
//

#import "LZDndModelCellModel.h"

@implementation LZDndModelCellModel

+ (NSArray<__kindof LZBaseSetCellModel *> *)cellModelList {
    NSMutableArray *mAry = [[NSMutableArray alloc] init];
    LZDndModelCellModel *model1 = [[LZDndModelCellModel alloc] initModelWithSetType:LZDndModelSetTypeDndSwitch cellStyle:DEVICESETCELLSTYLE_RIGHT_SWITCH titleStr:@"勿扰模式开关" subStr:nil];
    [mAry addObject:model1];
    
    LZDndModelCellModel *model2 = [[LZDndModelCellModel alloc] initModelWithSetType:LZDndModelSetTypeRaisedhandAgainstTheLight cellStyle:DEVICESETCELLSTYLE_RIGHT_SWITCH titleStr:@"是否允许抬手亮屏" subStr:nil];
    [mAry addObject:model2];
    
    LZDndModelCellModel *model3 = [[LZDndModelCellModel alloc] initModelWithSetType:LZDndModelSetTypeStartTime cellStyle:DEVICESETCELLSTYLE_RIGHT_IMG_SUBTITLE titleStr:@"开始时间" subStr:@"15:45"];
    [mAry addObject:model3];
    
    LZDndModelCellModel *model4 = [[LZDndModelCellModel alloc] initModelWithSetType:LZDndModelSetTypeDndSwitch cellStyle:DEVICESETCELLSTYLE_RIGHT_IMG_SUBTITLE titleStr:@"结束时间" subStr:@"00:00"];
    [mAry addObject:model4];
    
    return mAry;
}

@end
