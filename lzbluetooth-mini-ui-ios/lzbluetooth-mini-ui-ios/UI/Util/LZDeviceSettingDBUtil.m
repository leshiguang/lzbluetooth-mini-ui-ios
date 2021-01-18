//
//  LZDeviceSettingDBUtil.m
//  LZBluetooth Example
//
//  Created by tanjian on 2021/1/18.
//

#import "LZDeviceSettingDBUtil.h"
#import <YYModel/YYModel.h>

@implementation LZDeviceSettingDBUtil

+ (nullable id<LZDeviceSettingProtocol>)getConfigWithMacString:(NSString *)macString
                                                   settingType:(LZDeviceSettingType)settingType {
    
    NSUserDefaults *defalut = [NSUserDefaults standardUserDefaults];
    NSDictionary *temp = [defalut objectForKey:macString];
    NSDictionary *dic = [temp objectForKey:[NSString stringWithFormat:@"%@", @(settingType)]];
    NSString *clsName = lz_braceletSettingClass(settingType);
    return [NSClassFromString(clsName) yy_modelWithDictionary:dic];
}

+ (void)saveSettingData:(id<LZDeviceSettingProtocol>)settingData withMacString:(NSString *)macString {
    NSUserDefaults *defalut = [NSUserDefaults standardUserDefaults];
    NSObject *obj = settingData;
    NSDictionary *settingDataDic = obj.yy_modelToJSONObject;
    NSDictionary *temp = [defalut objectForKey:macString];
    NSMutableDictionary *toSaveDic = [NSMutableDictionary dictionary];
    if (temp) {
        [toSaveDic setDictionary:temp];
    }
    [toSaveDic setObject:settingDataDic forKey:[NSString stringWithFormat:@"%@", @(settingData.settingType)]];
    [defalut setObject:toSaveDic forKey:macString];
}

@end



