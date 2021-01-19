//
//  LZBaseSettingViewController.h
//  lzbluetooth-mini-ui-ios
//
//  Created by tanjian on 2021/1/19.
//

#import "LZDeviceManagerViewController.h"
#import "LZBaseSetTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface LZBaseSettingViewController<T: LZA5SettingData *> : LZDeviceManagerViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, readonly) UITableView *tableView;

@property (nonatomic, readonly) NSMutableArray <NSMutableArray *> *dataSource;

/// 数据
@property (nonatomic, strong) T data;

/// 刷新UI
- (void)updateUI;

@end

NS_ASSUME_NONNULL_END
