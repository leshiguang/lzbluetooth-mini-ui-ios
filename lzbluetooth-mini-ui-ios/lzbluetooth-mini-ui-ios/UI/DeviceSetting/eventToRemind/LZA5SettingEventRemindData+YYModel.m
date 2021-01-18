//
//  LZA5SettingEventRemindData+YYModel.m
//  lzbluetooth-mini-ui-ios
//
//  Created by tanjian on 2021/1/18.
//

#import "LZA5SettingEventRemindData+YYModel.h"

@implementation LZA5SettingEventRemindData (YYModel)

+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value should be Class or Class name.
    return @{@"contentDatas" : [LZA5SettingEventRemindContentData class]};
}

@end
