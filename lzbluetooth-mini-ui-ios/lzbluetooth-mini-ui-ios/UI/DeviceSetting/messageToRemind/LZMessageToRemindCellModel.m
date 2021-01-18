//
//  LZMessageToRemindCellModel.m
//  LSBluetoothUI_iOS
//
//  Created by wm on 2020/12/10.
//

#import "LZMessageToRemindCellModel.h"

@implementation LZMessageToRemindCellModel

+ (NSArray<__kindof LZBaseSetCellModel *> *)cellModelList {
    NSMutableArray *mAry = [[NSMutableArray alloc] init];
    LZMessageToRemindCellModel *model1 = [[LZMessageToRemindCellModel alloc] initModelWithSetType:LZMessageToRemindCellSetTpyeWechat cellStyle:DEVICESETCELLSTYLE_RIGHT_SWITCH titleStr:@"微信" subStr:nil];
    [mAry addObject:model1];
    
    LZMessageToRemindCellModel *model2 = [[LZMessageToRemindCellModel alloc] initModelWithSetType:LZMessageToRemindCellSetTpyeQQ cellStyle:DEVICESETCELLSTYLE_RIGHT_SWITCH titleStr:@"QQ" subStr:nil];
    [mAry addObject:model2];
    
    LZMessageToRemindCellModel *model3 = [[LZMessageToRemindCellModel alloc] initModelWithSetType:LZMessageToRemindCellSetTpyeMessage cellStyle:DEVICESETCELLSTYLE_RIGHT_SWITCH titleStr:@"短信" subStr:nil];
    [mAry addObject:model3];
    
    return [mAry copy];
}

@end
