//
//  LZGoalSetModel.m
//  LSBluetoothUI_iOS
//
//  Created by wm on 2020/12/9.
//

#import "LZGoalSetModel.h"

@implementation LZGoalSetModel

+ (NSArray<__kindof LZBaseSetCellModel *> *)cellModelList {
    NSMutableArray <LZGoalSetModel *> *mAry = [[NSMutableArray alloc] init];
    LZGoalSetModel *model1 = [[LZGoalSetModel alloc] initModelWithSetType:LZGOALSETTYPE_GOALSWITCH cellStyle:DEVICESETCELLSTYLE_RIGHT_SWITCH titleStr:@"目标开关" subStr:nil];
    [mAry addObject:model1];
    
    LZGoalSetModel *model2 = [[LZGoalSetModel alloc] initModelWithSetType:LZGOALSETTYPE_GOALTYPE cellStyle:DEVICESETCELLSTYLE_RIGHT_IMG_SUBTITLE titleStr:@"目标类型" subStr:@"卡路里"];
    [mAry addObject:model2];
    
    LZGoalSetModel *model3 = [[LZGoalSetModel alloc] initModelWithSetType:LZGOALSETTYPE_GOALTNUM cellStyle:DEVICESETCELLSTYLE_RIGHT_IMG_SUBTITLE titleStr:@"目标值" subStr:@"31.0"];
    [mAry addObject:model3];
    
    return [mAry copy];
}

@end
