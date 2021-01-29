//
//  LZDeviceManagerViewController.m
//  LZBluetooth Example
//
//  Created by tanjian on 2021/1/14.
//

#import "LZDeviceManagerViewController.h"
#import "UIViewController+MBProgressHUD.h"
#import "LZDeviceSettingDBUtil.h"

@interface LZDeviceManagerViewController ()

@end

@implementation LZDeviceManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
}

/// 可以重写方法刷新UI
- (void)updateUIWithResult:(LZBluetoothErrorCode)result {
//    NSAssert(NO, @"需要重写该方法来");
}

- (void)sendData:(id<LZDeviceSettingProtocol>)settingData {
    [self showActivityIndicatorHUDWithMessage:nil];
    __weak typeof(self) weakSelf = self;
    [self.deviceManager sendDataModel:settingData macString:self.device.mac completion:^(LZBluetoothErrorCode result) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf hideActivityIndicatorHUD];
            if (result == LZBluetoothErrorCodeSuccess) {
                [weakSelf saveSettingData:settingData];
                [weakSelf showHintMessage:@"设置成功" duration:1];
            } else {
                [weakSelf showHintMessage:@"设置失败" duration:1];
            }
            [weakSelf updateUIWithResult:result];
        });
    }];
}


- (void)saveSettingData:(id<LZDeviceSettingProtocol>)settingData {
    NSString *mac = self.device.mac;
    
    switch (settingData.settingType) {
        case LZDeviceSettingTypeMsgReminder:
            [LZDeviceSettingDBUtil setCallReminder:(LZA5SettingMessageReminderData *)settingData macString:mac];
            break;
        case LZDeviceSettingTypeEventReminder:
            [LZDeviceSettingDBUtil setEventReminder:(LZA5SettingEventRemindData *)settingData macString:mac];
            break;
        default:
            [LZDeviceSettingDBUtil saveSettingDatas:settingData withMacString:mac];
            break;
    }
    
}

- (id<LZDeviceManagerProtocol>)deviceManager {
    return [LZBluetooth getDeviceManagerWithDeviceType:LZDeviceTypeBracelet];
}

- (__kindof LZA5SettingData *)settingData {
    id data = [LZDeviceSettingDBUtil getConfigsWithMacString:self.device.mac settingType:self.settingType];
    if (data == nil) {
        return [self defaultData];
    } else {
        return data;
    }
}

- (nullable NSArray <__kindof LZA5SettingData *> *)settingDatas {
    NSArray *datas = [LZDeviceSettingDBUtil getConfigsWithMacString:self.device.mac settingType:self.settingType];
    return datas;
}

- (NSArray<NSString *> *)hours {
    if (!_hours) {
        NSMutableArray *array = [NSMutableArray array];
        for (int i = 0; i < 24; i++) {
            [array addObject:[NSString stringWithFormat:@"%d", i]];
        }
        _hours = array;
    }
    return _hours;
}

- (NSArray<NSString *> *)minutes {
    if (!_minutes) {
        NSMutableArray *array = [NSMutableArray array];
        for (int i = 0; i < 60; i++) {
            [array addObject:[NSString stringWithFormat:@"%d", i]];
        }
        _minutes = array;
    }
    return _minutes;
}

- (id)defaultData {
    NSString *clsName = lz_braceletSettingClass(self.settingType);
    return [[NSClassFromString(clsName) alloc] init];
}


@end
