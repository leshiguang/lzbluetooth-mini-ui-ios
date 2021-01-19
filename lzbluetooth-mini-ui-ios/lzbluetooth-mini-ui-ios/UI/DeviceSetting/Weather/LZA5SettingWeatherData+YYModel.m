//
//  LZA5SettingWeatherData+YYModel.m
//  lzbluetooth-mini-ui-ios
//
//  Created by tanjian on 2021/1/19.
//

#import "LZA5SettingWeatherData+YYModel.h"

@implementation LZA5SettingWeatherData (YYModel)

+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value should be Class or Class name.
    return @{@"contentDatas" : [LZA5SettingWeatherContentData class]};
}


@end
