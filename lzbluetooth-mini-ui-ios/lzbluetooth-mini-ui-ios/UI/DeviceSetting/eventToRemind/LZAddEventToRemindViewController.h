//
//  LZAddEventToRemindViewController.h
//  LSBluetoothUI_iOS
//
//  Created by wm on 2020/12/8.
//

#import "LZDeviceManagerViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface LZAddEventToRemindViewController : LZDeviceManagerViewController

@property (nonatomic, strong) LZA5SettingEventRemindData *data;

/// 如果没有就是新加
@property (nonatomic, strong, nullable) LZA5SettingEventRemindContentData *contentData;


@end

NS_ASSUME_NONNULL_END
