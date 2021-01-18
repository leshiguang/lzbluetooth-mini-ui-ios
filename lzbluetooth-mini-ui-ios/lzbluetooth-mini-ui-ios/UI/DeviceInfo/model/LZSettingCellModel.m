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
    
    LZSettingCellModel *model3 = [[LZSettingCellModel alloc] initModelWithSetType:DEVICESETTYPE_PHONE_CALL_REMINDING cellStyle:DEVICESETCELLSTYLE_RIGHT_SWITCH titleStr:@"来电提醒" subStr:@"C4:03:53:20:39:ID"];
    [mAry addObject:model3];
    
    LZSettingCellModel *model4 = [[LZSettingCellModel alloc] initModelWithSetType:DEVICESETTYPE_DIAL_SET cellStyle:DEVICESETCELLSTYLE_RIGHT_IMG titleStr:@"表盘样式" subStr:nil];
    [mAry addObject:model4];
    
    LZSettingCellModel *model5 = [[LZSettingCellModel alloc] initModelWithSetType:DEVICESETTYPE_GOAL_SETTING cellStyle:DEVICESETCELLSTYLE_RIGHT_IMG titleStr:@"目标设置" subStr:nil];
    [mAry addObject:model5];
    
    LZSettingCellModel *model6 = [[LZSettingCellModel alloc] initModelWithSetType:DEVICESETTYPE_EVENT_TO_REMIND cellStyle:DEVICESETCELLSTYLE_RIGHT_IMG titleStr:@"事件提醒" subStr:nil];
    [mAry addObject:model6];
    
    LZSettingCellModel *model7 = [[LZSettingCellModel alloc] initModelWithSetType:DEVICESETTYPE_HEART_RATE_WARNING cellStyle:DEVICESETCELLSTYLE_RIGHT_IMG titleStr:@"心率预警" subStr:nil];
    [mAry addObject:model7];
    
    LZSettingCellModel *model8 = [[LZSettingCellModel alloc] initModelWithSetType:DEVICESETTYPE_HEART_RATE__MONITOR cellStyle:DEVICESETCELLSTYLE_RIGHT_SWITCH titleStr:@"心率监测" subStr:nil];
    [mAry addObject:model8];
    
    LZSettingCellModel *model9 = [[LZSettingCellModel alloc] initModelWithSetType:DEVICESETTYPE_MESSAGE_TO_REMIND cellStyle:DEVICESETCELLSTYLE_RIGHT_IMG titleStr:@"消息提醒" subStr:nil];
    [mAry addObject:model9];
    
    LZSettingCellModel *model10 = [[LZSettingCellModel alloc] initModelWithSetType:DEVICESETTYPE_NIGHT_MODE cellStyle:DEVICESETCELLSTYLE_RIGHT_IMG titleStr:@"夜间模式" subStr:nil];
    [mAry addObject:model10];
    
    LZSettingCellModel *model11 = [[LZSettingCellModel alloc] initModelWithSetType:DEVICESETTYPE_DND_MODE cellStyle:DEVICESETCELLSTYLE_RIGHT_IMG titleStr:@"勿扰模式" subStr:nil];
    [mAry addObject:model11];
    
    LZSettingCellModel *model12 = [[LZSettingCellModel alloc] initModelWithSetType:DEVICESETTYPE_SCREEN_ORIENTATION cellStyle:DEVICESETCELLSTYLE_RIGHT_IMG titleStr:@"屏幕方向" subStr:nil];
    [mAry addObject:model12];

    LZSettingCellModel *model13 = [[LZSettingCellModel alloc] initModelWithSetType:DEVICESETTYPE_SPORT_TYPE cellStyle:DEVICESETCELLSTYLE_RIGHT_IMG titleStr:@"运动类型" subStr:nil];
    [mAry addObject:model13];

    LZSettingCellModel *model14 = [[LZSettingCellModel alloc] initModelWithSetType:DEVICESETTYPE_SCREEN_CONTENT cellStyle:DEVICESETCELLSTYLE_RIGHT_IMG titleStr:@"屏幕内容" subStr:nil];
    [mAry addObject:model14];

    LZSettingCellModel *model15 = [[LZSettingCellModel alloc] initModelWithSetType:DEVICESETTYPE_TIME_FORMAT cellStyle:DEVICESETCELLSTYLE_RIGHT_IMG titleStr:@"时间制式" subStr:nil];
    [mAry addObject:model15];
    
    LZSettingCellModel *model16 = [[LZSettingCellModel alloc] initModelWithSetType:DEVICESETTYPE_WEARING_HABITS cellStyle:DEVICESETCELLSTYLE_RIGHT_IMG titleStr:@"佩戴习惯" subStr:nil];
    [mAry addObject:model16];
    
    LZSettingCellModel *model17 = [[LZSettingCellModel alloc] initModelWithSetType:DEVICESETTYPE_FOTA cellStyle:DEVICESETCELLSTYLE_RIGHT_IMG_SUBTITLE titleStr:@"固件升级" subStr:@"T14"];
    [mAry addObject:model17];
    
    LZSettingCellModel *model18 = [[LZSettingCellModel alloc] initModelWithSetType:DEVICESETTYPE_UNBIND cellStyle:DEVICESETCELLSTYLE_UNBIND_DEVICE titleStr:nil subStr:nil];
    [mAry addObject:model18];
    
    return [mAry copy];
}

@end
