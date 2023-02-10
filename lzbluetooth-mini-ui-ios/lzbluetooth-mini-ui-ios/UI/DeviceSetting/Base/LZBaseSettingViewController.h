//
//  LZBaseSettingViewController.h
//  lzbluetooth-mini-ui-ios
//
//  Created by tanjian on 2021/1/19.
//

#import "LZDeviceManagerViewController.h"
#import "LZBaseSetTableViewCell.h"
@import LZBracelet;

NS_ASSUME_NONNULL_BEGIN

@interface LZBaseSettingViewController<T: LZA5SettingData *> : LZDeviceManagerViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, readonly) UITableView *tableView;

/// 数据
@property (nonatomic, strong) T data;

/// 刷新UI
- (void)updateUI;

@end

NS_ASSUME_NONNULL_END
