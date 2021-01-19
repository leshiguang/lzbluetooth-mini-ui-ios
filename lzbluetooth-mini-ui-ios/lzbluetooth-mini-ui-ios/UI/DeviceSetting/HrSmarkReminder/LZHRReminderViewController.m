//
//  LZHRReminderViewController.m
//  lzbluetooth-mini-ui-ios
//
//  Created by tanjian on 2021/1/18.
//

#import "LZHRReminderViewController.h"
#import "LZBaseSetTableViewCell.h"
#import <Masonry/Masonry.h>

@interface LZHRReminderViewController ()

@property (nonatomic, strong) LZA5SettingSmartHRDetectionData *data;

@property (nonatomic, strong) NSArray <NSString *> *modes;

@end

@implementation LZHRReminderViewController

@dynamic data;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateUI];
}

- (void)updateUI {
    NSInteger mode = self.data.mode;
    [self.tableView reloadData];
    if (self.modes.count > mode) {
        [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:mode inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.modes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LZBaseSetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(LZBaseSetTableViewCell.class) forIndexPath:indexPath];
    cell.rightSelectImageView.hidden = NO;
    cell.titleLabel.text = self.modes[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.data.mode = indexPath.row;
    
    [self sendData:self.data];
}

#pragma mark - getter
- (NSArray <NSString *> *)modes {
    if (!_modes) {
        _modes = @[@"关闭", @"开启", @"智能监控"];
    }
    return _modes;
}

@end
