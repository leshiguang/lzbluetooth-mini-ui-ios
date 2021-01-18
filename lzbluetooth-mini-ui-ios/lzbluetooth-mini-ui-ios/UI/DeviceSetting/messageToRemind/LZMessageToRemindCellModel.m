//
//  LZMessageToRemindCellModel.m
//  LSBluetoothUI_iOS
//
//  Created by wm on 2020/12/10.
//

#import "LZMessageToRemindCellModel.h"
#import <LZBluetooth/LZBluetooth.h>

@implementation LZMessageToRemindCellModel



+ (NSArray<__kindof LZBaseSetCellModel *> *)cellModelList {
    NSMutableArray *mAry = [[NSMutableArray alloc] init];
    
    
    LZMessageToRemindCellModel *model1 = [[LZMessageToRemindCellModel alloc] initModelWithSetType:LZA5CallReminderTypeWX cellStyle:DEVICESETCELLSTYLE_RIGHT_SWITCH titleStr:@"微信" subStr:nil];
    [mAry addObject:model1];
    
    LZMessageToRemindCellModel *model2 = [[LZMessageToRemindCellModel alloc] initModelWithSetType:LZA5CallReminderTypeQQ cellStyle:DEVICESETCELLSTYLE_RIGHT_SWITCH titleStr:@"QQ" subStr:nil];
    [mAry addObject:model2];
    
    LZMessageToRemindCellModel *model3 = [[LZMessageToRemindCellModel alloc] initModelWithSetType:LZA5CallReminderTypeSMS cellStyle:DEVICESETCELLSTYLE_RIGHT_SWITCH titleStr:@"短信" subStr:nil];
    [mAry addObject:model3];
    
    LZMessageToRemindCellModel *model4 = [[LZMessageToRemindCellModel alloc] initModelWithSetType:LZA5CallReminderTypeDefault cellStyle:DEVICESETCELLSTYLE_RIGHT_SWITCH titleStr:@"来电提醒" subStr:nil];
    [mAry addObject:model4];
    
    LZMessageToRemindCellModel *model5 = [[LZMessageToRemindCellModel alloc] initModelWithSetType:LZA5CallReminderTypeLost cellStyle:DEVICESETCELLSTYLE_RIGHT_SWITCH titleStr:@"断连提醒" subStr:nil];
    [mAry addObject:model5];
    
    
    
    return [mAry copy];
}

@end
