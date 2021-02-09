//
//  LZDeviceSettingDBUtil.m
//  LZBluetooth Example
//
//  Created by tanjian on 2021/1/18.
//

#import "LZDeviceSettingDBUtil.h"
#import <YYModel/YYModel.h>

@implementation LZDeviceSettingDBUtil

+ (nullable id)getConfigsWithMacString:(NSString *)macString settingType:(LZDeviceSettingType)settingType {
    NSUserDefaults *defalut = [NSUserDefaults standardUserDefaults];
    NSDictionary *temp = [defalut objectForKey:macString];
    NSDictionary *dic = [temp objectForKey:[NSString stringWithFormat:@"%@", @(settingType)]];
    NSString *clsName = lz_deviceSettingClass(settingType);
    Class cls = NSClassFromString(clsName);
    if (dic && [dic isKindOfClass:[NSDictionary class]]) {
        return [cls yy_modelWithDictionary:dic];
    } else if (dic && [dic isKindOfClass:[NSArray class]]) {
        NSArray *array = (NSArray *)dic;
        NSMutableArray *temp = [NSMutableArray array];
        [array enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            id settingData = [cls yy_modelWithDictionary:obj];
            if (settingData) {
                [temp addObject:settingData];
            }
        }];
        return temp.copy;
    }
    return nil;
}

+ (void)saveSettingDatas:(id)settingDatas withMacString:(NSString *)macString {
    NSUserDefaults *defalut = [NSUserDefaults standardUserDefaults];
    if ([settingDatas isKindOfClass:[NSArray class]]) {
//        NSArray *array = settingDatas;
        __block NSString *key = nil;
        NSMutableArray *array = [NSMutableArray array];
        [settingDatas enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj respondsToSelector:@selector(settingType)]) {
                NSObject <LZDeviceSettingProtocol> *settingData = obj;
                key = [NSString stringWithFormat:@"%@", @(settingData.settingType)];
                NSDictionary *dic = settingData.yy_modelToJSONObject;
                if (dic) {
                    [array addObject:dic];
                }
            }
        }];
        if (array.count > 0 && key) {
            NSDictionary *temp = [defalut objectForKey:macString];
            NSMutableDictionary *toSaveDic = [NSMutableDictionary dictionary];
            if (temp) {
                [toSaveDic setDictionary:temp];
            }
            [toSaveDic setObject:array forKey:key];
            [defalut setObject:toSaveDic forKey:macString];
        }
        
    } else if ([settingDatas respondsToSelector:@selector(settingType)]) {
        NSObject <LZDeviceSettingProtocol> *settingData = settingDatas;
        NSString *key = [NSString stringWithFormat:@"%@", @(settingData.settingType)];
        NSDictionary *temp = [defalut objectForKey:macString];
        NSMutableDictionary *toSaveDic = [NSMutableDictionary dictionary];
        if (temp) {
            [toSaveDic setDictionary:temp];
        }
        [toSaveDic setObject:settingData.yy_modelToJSONObject forKey:key];
        [defalut setObject:toSaveDic forKey:macString];
    }
}

/// 最加存储在某个数组里面
+ (void)setEventReminder:(LZA5SettingEventRemindData *)data macString:(NSString *)macString {
    
    NSDate *now = [NSDate date];
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute fromDate:now];
    components.hour = data.hour;
    components.minute = data.minute;
    
    NSDate *result = [[NSCalendar currentCalendar] dateFromComponents:components];
    if ([result compare:now] == NSOrderedAscending) {
        result = [result dateByAddingTimeInterval:24 * 60 * 60];
    }
    
    data.ringTime = result.timeIntervalSince1970 * 1000;
    
    NSArray <LZA5SettingEventRemindData *> *list = [self getConfigsWithMacString:macString settingType:LZDeviceSettingTypeEventReminder];
    
    if (list && [list isKindOfClass:[NSArray class]] && list.count > 0) {
        __block NSInteger index = NSNotFound;
        
        [list enumerateObjectsUsingBlock:^(LZA5SettingEventRemindData * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.index == data.index) {
                index = idx;
            }
        }];
        NSMutableArray *array = list.mutableCopy;
        if (index == NSNotFound) {
            [array addObject:data];
        } else {
            [array replaceObjectAtIndex:index withObject:data];
        }
        [self saveSettingDatas:array withMacString:macString];
    } else {
        [self saveSettingDatas:@[data] withMacString:macString];
    }
}

+ (void)removeEventReminder:(LZA5SettingEventRemindData *)contentData macString:(NSString *)macString {
    NSArray <LZA5SettingEventRemindData *> *list = [self getConfigsWithMacString:macString settingType:LZDeviceSettingTypeEventReminder];
    if (!list || ![list isKindOfClass:[NSArray class]] || !list.count) {
        return;
    }
    __block NSInteger index = NSNotFound;
    [list enumerateObjectsUsingBlock:^(LZA5SettingEventRemindData * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.index == contentData.index) {
            index = idx;
            *stop = YES;
        }
    }];
    
    if (index != NSNotFound) {
        NSMutableArray *array = [list mutableCopy];
        [array removeObjectAtIndex:index];
        [self saveSettingDatas:contentData withMacString:macString];
    }
}

+ (void)setCallReminder:(LZA5SettingMessageReminderData *)data macString:(NSString *)macString {
    NSArray *list = [self getConfigsWithMacString:macString settingType:LZDeviceSettingTypeMsgReminder];
    if (list && list.count > 0) {
        __block NSInteger index = NSNotFound;
        [list enumerateObjectsUsingBlock:^(LZA5SettingMessageReminderData * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.reminderType == data.reminderType) {
                index = idx;
            }
        }];
        NSMutableArray *array = list.mutableCopy;
        if (index == NSNotFound) {
            [array addObject:data];
        } else {
            [array replaceObjectAtIndex:index withObject:data];
        }
        [self saveSettingDatas:array withMacString:macString];
    } else {
        [self saveSettingDatas:@[data] withMacString:macString];
    }
}

+ (NSString *)titleWithSettingType:(LZDeviceSettingType)settingType {
    switch (settingType) {
        case LZDeviceSettingTypeDial: return @"表盘样式";
        case LZDeviceSettingTypeTargetEncourage: return @"目标设置";
        case LZDeviceSettingTypeEventReminder: return @"闹钟";
        case LZDeviceSettingTypeCustomSportHrReminder: return @"心率预警";
        case LZDeviceSettingTypeSmartHrDetection: return @"心率监测";
        case LZDeviceSettingTypeMsgReminder: return @"消息提醒";
        case LZDeviceSettingTypeNightMode: return @"夜间模式";
        case LZDeviceSettingTypeNoDisturb: return @"勿扰模式";
        case LZDeviceSettingTypeScreenDirection: return @"屏幕方向";
        case LZDeviceSettingTypeTimeMode: return @"时间制式";
        case LZDeviceSettingTypeWristHabit: return @"佩戴习惯";
        case LZDeviceSettingTypeCustomScreen: return @"自定义屏幕";
        case LZDeviceSettingTypeLanguage: return @"语言";
        case LZDeviceSettingTypeSwiming: return @"游泳";
        case LZDeviceSettingTypeWeather: return @"天气";
        case LZDeviceSettingTypeUnit: return @"单位";

        case LZDeviceSettingTypeScaleUnit: return @"体重单位";
        case LZDeviceSettingTypeWifiScan: return @"扫描wifi热点";

            
        default:
            NSAssert(NO, @"未处理类型 %@", @(settingType));
            break;
    }
    return @"";
}

@end



