//
//  LZAddEventToRemindCellModel.m
//  LSBluetoothUI_iOS
//
//  Created by wm on 2020/12/9.
//

#import "LZAddEventToRemindCellModel.h"

@implementation LZAddEventToRemindCellModel

+ (NSArray<__kindof LZBaseSetCellModel *> *)cellModelList {
    NSMutableArray <LZAddEventToRemindCellModel *> *mAry = [[NSMutableArray alloc] init];
    
    LZAddEventToRemindCellModel *model1 = [[LZAddEventToRemindCellModel alloc] initModelWithSetType:LZADDEVENTTOREMINDTYPE_OPENR_EMIND cellStyle:DEVICESETCELLSTYLE_RIGHT_SWITCH titleStr:@"打开提醒" subStr:nil];
    [mAry addObject:model1];
    
    LZAddEventToRemindCellModel *model2 = [[LZAddEventToRemindCellModel alloc] initModelWithSetType:LZADDEVENTTOREMINDTYPE_REMIND_TIME cellStyle:DEVICESETCELLSTYLE_RIGHT_IMG_SUBTITLE titleStr:@"提醒时间" subStr:@"15:31"];
    [mAry addObject:model2];
    
    LZAddEventToRemindCellModel *model3 = [[LZAddEventToRemindCellModel alloc] initModelWithSetType:LZADDEVENTTOREMINDTYPE_REPEAT_TIME cellStyle:DEVICESETCELLSTYLE_RIGHT_IMG_SUBTITLE titleStr:@"每周重复时间" subStr:@"星期一 星期二 星期三 星期四 星期五 星期六 星期天"];
    [mAry addObject:model3];
    
    LZAddEventToRemindCellModel *model4 = [[LZAddEventToRemindCellModel alloc] initModelWithSetType:LZADDEVENTTOREMINDTYPE_VIBRATION_MODE cellStyle:DEVICESETCELLSTYLE_RIGHT_IMG_SUBTITLE titleStr:@"震动方式" subStr:nil];
    [mAry addObject:model4];
    
    LZAddEventToRemindCellModel *model5 = [[LZAddEventToRemindCellModel alloc] initModelWithSetType:LZADDEVENTTOREMINDTYPE_VIBRATION_LEAVE1 cellStyle:DEVICESETCELLSTYLE_RIGHT_IMG_SUBTITLE titleStr:@"震动等级1" subStr:nil];
    [mAry addObject:model5];
    
    LZAddEventToRemindCellModel *model6 = [[LZAddEventToRemindCellModel alloc] initModelWithSetType:LZADDEVENTTOREMINDTYPE_VIBRATION_LEAVE2 cellStyle:DEVICESETCELLSTYLE_RIGHT_IMG_SUBTITLE titleStr:@"震动等级2" subStr:nil];
    [mAry addObject:model6];
    
    LZAddEventToRemindCellModel *model7 = [[LZAddEventToRemindCellModel alloc] initModelWithSetType:LZADDEVENTTOREMINDTYPE_VIBRATION_TIME cellStyle:DEVICESETCELLSTYLE_RIGHT_IMG_SUBTITLE titleStr:@"震动时长" subStr:nil];
    [mAry addObject:model7];
    
    return [mAry copy];
}

@end
