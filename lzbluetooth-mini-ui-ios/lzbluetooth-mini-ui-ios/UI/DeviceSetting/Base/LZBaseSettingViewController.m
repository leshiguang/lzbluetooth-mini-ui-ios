//
//  LZBaseSettingViewController.m
//  lzbluetooth-mini-ui-ios
//
//  Created by tanjian on 2021/1/19.
//

#import "LZBaseSettingViewController.h"
#import <Masonry/Masonry.h>

@interface LZBaseSettingViewController ()

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation LZBaseSettingViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    if (!self.data) {
        self.data = [self settingData];
    }
}

- (void)updateUIWithResult:(LZBluetoothErrorCode)result {
    if (result != LZBluetoothErrorCodeSuccess) {
        self.data = [self settingData];
        [self updateUI];
    }
}

- (void)updateUI {
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LZBaseSetTableViewCell class]) forIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

#pragma mark - getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
        [_tableView registerClass:[LZBaseSetTableViewCell class] forCellReuseIdentifier:NSStringFromClass([LZBaseSetTableViewCell class])];

    }
    return _tableView;
}


@end
