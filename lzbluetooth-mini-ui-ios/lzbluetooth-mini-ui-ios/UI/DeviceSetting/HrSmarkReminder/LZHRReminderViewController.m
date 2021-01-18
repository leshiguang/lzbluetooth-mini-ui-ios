//
//  LZHRReminderViewController.m
//  lzbluetooth-mini-ui-ios
//
//  Created by tanjian on 2021/1/18.
//

#import "LZHRReminderViewController.h"
#import "LZBaseSetTableViewCell.h"
#import <Masonry/Masonry.h>

@interface LZHRReminderViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) LZA5SettingSmartHRDetectionData *data;

@property (nonatomic, strong) NSArray <NSString *> *modes;

@end

@implementation LZHRReminderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    self.data = self.settingData;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.modes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LZBaseSetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LZBaseSetTableViewCell class]) forIndexPath:indexPath];
    if (indexPath.row == self.data.mode) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    cell.titleLabel.text = self.modes[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.data.mode = indexPath.row;
    
    [self sendData:self.data];
}

#pragma mark - getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[LZBaseSetTableViewCell class] forCellReuseIdentifier:NSStringFromClass([LZBaseSetTableViewCell class])];
    }
    return _tableView;
}

- (NSArray <NSString *> *)modes {
    if (!_modes) {
        _modes = @[@"关闭", @"开启", @"智能监控"];
    }
    return _modes;
}

@end
