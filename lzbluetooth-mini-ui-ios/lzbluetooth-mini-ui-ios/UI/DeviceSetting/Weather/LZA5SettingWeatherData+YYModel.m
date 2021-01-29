//
//  LZA5SettingWeatherData+YYModel.m
//  lzbluetooth-mini-ui-ios
//
//  Created by tanjian on 2021/1/19.
//

#import "LZA5SettingWeatherData+YYModel.h"

@implementation LZWeatherData (YYModel)

+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value should be Class or Class name.
    return @{@"weatherFutures" : [LZWeatherDayData class]};
}


@end
