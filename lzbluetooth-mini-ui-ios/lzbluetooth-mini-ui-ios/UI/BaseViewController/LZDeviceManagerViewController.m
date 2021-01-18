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

- (void)sendData:(__kindof LZA5SettingData *)settingData {
    [self showActivityIndicatorHUDWithMessage:nil];
    __weak typeof(self) weakSelf = self;
    NSString *mac = self.device.mac;
    [self.device sendDataModel:settingData completion:^(LZBluetoothErrorCode result) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf hideActivityIndicatorHUD];
            
            if (result == LZBluetoothErrorCodeSuccess) {
                [LZDeviceSettingDBUtil saveSettingData:settingData withMacString:mac];
                [weakSelf showHintMessage:@"设置成功" duration:1];
            } else {
                [weakSelf showHintMessage:@"设置失败" duration:1];
            }
            [weakSelf updateUIWithResult:result];
        });
    }];
}

- (id<LZDeviceManagerProtocol>)deviceManager {
    return [LZBluetooth getDeviceManagerWithDeviceType:LZDeviceTypeBracelet];
}

- (id<LZDeviceSettingProtocol>)getSettingDataWithType:(LZBraceletSettingType)settingType {
    return [LZDeviceSettingDBUtil getConfigWithMacString:self.device.mac settingType:settingType];
}

@end
