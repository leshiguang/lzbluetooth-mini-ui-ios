//
//  LZSettingCellModel.m
//  LSBluetoothUI_iOS
//
//  Created by wm on 2020/12/2.
//

#import "LZSettingCellModel.h"


@implementation LZSettingCellModel

+ (NSArray<LZSettingCellModel *> *)cellModelList {
    NSMutableArray *mAry = [[NSMutableArray alloc] init];
    
    LZSettingCellModel *model1 = [[LZSettingCellModel alloc] initModelWithSetType:DEVICESETTYPE_DEVICE_NAME cellStyle:DEVICESETCELLSTYLE_RIGHT_SUBTITLE titleStr:@"设备名称" subStr:@"乐心手环Mambo HR 2"];
    [mAry addObject:model1];
    
    LZSettingCellModel *model2 = [[LZSettingCellModel alloc] initModelWithSetType:DEVICESETTYPE_MAC cellStyle:DEVICESETCELLSTYLE_RIGHT_SUBTITLE titleStr:@"MAC地址" subStr:@"C4:03:53:20:39:ID"];
    [mAry addObject:model2];
    
    LZSettingCellModel *model4 = [[LZSettingCellModel alloc] initModelWithSetType:LZBraceletSettingTypeDial cellStyle:DEVICESETCELLSTYLE_RIGHT_IMG titleStr:@"表盘样式" subStr:nil];
    [mAry addObject:model4];
    
    LZSettingCellModel *model5 = [[LZSettingCellModel alloc] initModelWithSetType:LZBraceletSettingTypeTargetEncourage cellStyle:DEVICESETCELLSTYLE_RIGHT_IMG titleStr:@"目标设置" subStr:nil];
    [mAry addObject:model5];
    
    LZSettingCellModel *model6 = [[LZSettingCellModel alloc] initModelWithSetType:LZBraceletSettingTypeEventReminder cellStyle:DEVICESETCELLSTYLE_RIGHT_IMG titleStr:@"事件提醒" subStr:nil];
    [mAry addObject:model6];
    
    LZSettingCellModel *model7 = [[LZSettingCellModel alloc] initModelWithSetType:LZBraceletSettingTypeCustomSportHrReminder cellStyle:DEVICESETCELLSTYLE_RIGHT_IMG titleStr:@"心率预警" subStr:nil];
    [mAry addObject:model7];
    
    LZSettingCellModel *model8 = [[LZSettingCellModel alloc] initModelWithSetType:LZBraceletSettingTypeSmartHrDetection cellStyle:DEVICESETCELLSTYLE_RIGHT_IMG titleStr:@"心率监测" subStr:nil];
    [mAry addObject:model8];
    
    LZSettingCellModel *model9 = [[LZSettingCellModel alloc] initModelWithSetType:LZBraceletSettingTypeCallReminder cellStyle:DEVICESETCELLSTYLE_RIGHT_IMG titleStr:@"消息提醒" subStr:nil];
    [mAry addObject:model9];
    
    LZSettingCellModel *model10 = [[LZSettingCellModel alloc] initModelWithSetType:LZBraceletSettingTypeNightMode cellStyle:DEVICESETCELLSTYLE_RIGHT_IMG titleStr:@"夜间模式" subStr:nil];
    [mAry addObject:model10];
    
    LZSettingCellModel *model11 = [[LZSettingCellModel alloc] initModelWithSetType:LZBraceletSettingTypeNoDisturb cellStyle:DEVICESETCELLSTYLE_RIGHT_IMG titleStr:@"勿扰模式" subStr:nil];
    [mAry addObject:model11];
    
    LZSettingCellModel *model12 = [[LZSettingCellModel alloc] initModelWithSetType:LZBraceletSettingTypeScreenDirection cellStyle:DEVICESETCELLSTYLE_RIGHT_IMG titleStr:@"屏幕方向" subStr:nil];
    [mAry addObject:model12];

    LZSettingCellModel *model14 = [[LZSettingCellModel alloc] initModelWithSetType:LZBraceletSettingTypeCustomScreen cellStyle:DEVICESETCELLSTYLE_RIGHT_IMG titleStr:@"屏幕内容" subStr:nil];
    [mAry addObject:model14];

    LZSettingCellModel *model15 = [[LZSettingCellModel alloc] initModelWithSetType:LZBraceletSettingTypeTimeMode cellStyle:DEVICESETCELLSTYLE_RIGHT_IMG titleStr:@"时间制式" subStr:nil];
    [mAry addObject:model15];
    
    LZSettingCellModel *model16 = [[LZSettingCellModel alloc] initModelWithSetType:LZBraceletSettingTypeWristHabit cellStyle:DEVICESETCELLSTYLE_RIGHT_IMG titleStr:@"佩戴习惯" subStr:nil];
    [mAry addObject:model16];
    
    LZSettingCellModel *model17 = [[LZSettingCellModel alloc] initModelWithSetType:LZBraceletSettingTypeLanguage cellStyle:DEVICESETCELLSTYLE_RIGHT_IMG titleStr:@"语言" subStr:nil];
    [mAry addObject:model17];
    
    LZSettingCellModel *otaModel = [[LZSettingCellModel alloc] initModelWithSetType:DEVICESETTYPE_FOTA cellStyle:DEVICESETCELLSTYLE_RIGHT_IMG_SUBTITLE titleStr:@"固件升级" subStr:@"T14"];
    [mAry addObject:otaModel];
    
    
    
    LZSettingCellModel *unbindModel = [[LZSettingCellModel alloc] initModelWithSetType:DEVICESETTYPE_UNBIND cellStyle:DEVICESETCELLSTYLE_UNBIND_DEVICE titleStr:nil subStr:nil];
    [mAry addObject:unbindModel];
    
    return [mAry copy];
}

@end
