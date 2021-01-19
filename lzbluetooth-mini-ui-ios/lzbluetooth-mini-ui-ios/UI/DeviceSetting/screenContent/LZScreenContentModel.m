//
//  LZScreenContentModel.m
//  LSBluetoothUI_iOS
//
//  Created by wm on 2020/12/11.
//

#import "LZScreenContentModel.h"
#import <LZBluetooth/LZBluetooth.h>

@implementation LZScreenContentModel

- (LZScreenContentModel *)initModelWithTitleStr:(NSString *)titleStr isSelect:(BOOL)isSelect setType:(LZA5UIPageType)setType{
    LZScreenContentModel *model = [[LZScreenContentModel alloc] init];
    model.titleStr = titleStr;
    model.isSelect = isSelect;
    model.setType = setType;
    return model;
}


+ (NSArray <LZScreenContentModel *> *)cellModelList {
    NSMutableArray *mAry = [[NSMutableArray alloc] init];
    
    LZScreenContentModel *model1 = [[LZScreenContentModel alloc] initModelWithTitleStr:@"时间" isSelect:YES setType:LZA5UIPageTypeTime];
    [mAry addObject:model1];
    
    LZScreenContentModel *model2 = [[LZScreenContentModel alloc] initModelWithTitleStr:@"卡路里" isSelect:YES setType:LZA5UIPageTypeCalorise];
    [mAry addObject:model2];
     
    LZScreenContentModel *model3 = [[LZScreenContentModel alloc] initModelWithTitleStr:@"步数" isSelect:YES setType:LZA5UIPageTypeStep];
    [mAry addObject:model3];
    
    LZScreenContentModel *model4 = [[LZScreenContentModel alloc] initModelWithTitleStr:@"距离" isSelect:NO setType:LZA5UIPageTypeDistance];
    [mAry addObject:model4];
    
    LZScreenContentModel *model5 = [[LZScreenContentModel alloc] initModelWithTitleStr:@"心率" isSelect:NO setType:LZA5UIPageTypeHr];
    [mAry addObject:model5];
    
    LZScreenContentModel *model6 = [[LZScreenContentModel alloc] initModelWithTitleStr:@"每日数据" isSelect:NO setType:LZA5UIPageTypeDailyData];
    [mAry addObject:model6];
    
    LZScreenContentModel *model7 = [[LZScreenContentModel alloc] initModelWithTitleStr:@"秒表" isSelect:NO setType:LZA5UIPageTypeStopwatch];
    [mAry addObject:model7];
    
    LZScreenContentModel *model8 = [[LZScreenContentModel alloc] initModelWithTitleStr:@"天气" isSelect:NO setType:LZA5UIPageTypeWeather];
    [mAry addObject:model8];
    
    LZScreenContentModel *model9 = [[LZScreenContentModel alloc] initModelWithTitleStr:@"电量" isSelect:NO setType:LZA5UIPageTypeBattery];
    [mAry addObject:model9];
    
    LZScreenContentModel *model10 = [[LZScreenContentModel alloc] initModelWithTitleStr:@"12分钟跑" isSelect:NO setType:LZA5UIPageType12MinutesRunMode];
    [mAry addObject:model10];
    
    LZScreenContentModel *model11 = [[LZScreenContentModel alloc] initModelWithTitleStr:@"6分钟健走" isSelect:NO setType:LZA5UIPageType6MinutesRunMode];
    [mAry addObject:model11];
    
    LZScreenContentModel *model12 = [[LZScreenContentModel alloc] initModelWithTitleStr:@"支付宝" isSelect:NO setType:LZA5UIPageTypeAliPayMode];
    [mAry addObject:model12];
    
    return mAry;
}

@end
