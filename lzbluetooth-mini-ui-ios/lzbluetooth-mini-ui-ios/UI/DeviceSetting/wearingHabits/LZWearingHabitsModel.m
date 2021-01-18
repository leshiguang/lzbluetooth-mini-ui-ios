//
//  LZWearingHabitsModel.m
//  LSBluetoothUI_iOS
//
//  Created by wm on 2020/12/11.
//

#import "LZWearingHabitsModel.h"

@implementation LZWearingHabitsModel

+ (NSArray<__kindof LZBaseSetCellModel *> *)cellModelList {
    NSMutableArray *mAry = [[NSMutableArray alloc] init];
    LZWearingHabitsModel *model1 = [[LZWearingHabitsModel alloc] initModelWithSetType:LZWearingHabitsSetTypeleftHand cellStyle:DEVICESETCELLSTYLE_RIGHT_SELECTIMAGE titleStr:@"左手佩戴" subStr:nil];
    [mAry addObject:model1];
    
    LZWearingHabitsModel *model2 = [[LZWearingHabitsModel alloc] initModelWithSetType:LZWearingHabitsSetTypeRightHand cellStyle:DEVICESETCELLSTYLE_RIGHT_SELECTIMAGE titleStr:@"右手佩戴" subStr:nil];
    [mAry addObject:model2];
    
    return [mAry copy];
}

@end
