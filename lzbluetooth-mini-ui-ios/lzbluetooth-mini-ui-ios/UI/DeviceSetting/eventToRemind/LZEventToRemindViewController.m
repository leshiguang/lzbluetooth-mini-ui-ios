//
//  LZEventToRemindViewController.m
//  LSBluetoothUI_iOS
//
//  Created by wm on 2020/12/8.
//

#import "LZEventToRemindViewController.h"
#import <Masonry/Masonry.h>
#import "LZEventToRemindTableViewCell.h"
#import "LZAddEventToRemindViewController.h"
#import "LSWAppFontConfigrationMacro.h"
#import "LSWAppColorConfigrationMacro.h"

@interface LZEventToRemindViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *addEventToRemindBtn;
@end

@implementation LZEventToRemindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"事件提醒";
    self.view.backgroundColor = [UIColor whiteColor];
    [self createUI];
}

- (void)createUI {
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.addEventToRemindBtn];
    
    [self.addEventToRemindBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-24);
        make.left.equalTo(self.view).offset(70);
        make.right.equalTo(self.view).offset(-70);
        make.height.equalTo(@50);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(0);
        make.left.and.right.equalTo(self.view);
        make.bottom.equalTo(self.addEventToRemindBtn.mas_top).offset(-10);
    }];
}

#pragma mark - UITableViewDelegate
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 50;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self pushToAddEventToRemind];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LZEventToRemindTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LZEventToRemindTableViewCell class]) forIndexPath:indexPath];
    if (!cell) {
        cell = [[LZEventToRemindTableViewCell alloc] init];
    }
    return cell;
}

#pragma mark - event
- (void)clickAddEventToRemindBtn {
    [self pushToAddEventToRemind];
}

#pragma mark - Private Methods
- (void)pushToAddEventToRemind {
    LZAddEventToRemindViewController *vc = [[LZAddEventToRemindViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [UIView new];
        _tableView.estimatedRowHeight = 50;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        [_tableView registerClass:[LZEventToRemindTableViewCell class] forCellReuseIdentifier:NSStringFromClass([LZEventToRemindTableViewCell class])];
    }
    return _tableView;
}

- (UIButton *)addEventToRemindBtn {
    if (!_addEventToRemindBtn) {
        _addEventToRemindBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addEventToRemindBtn setTitle:@"增加事件提醒" forState:UIControlStateNormal];
        [_addEventToRemindBtn.titleLabel setFont:LSWDefaultFontWithSize(16)];
        [_addEventToRemindBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_addEventToRemindBtn.layer setCornerRadius:25];
        [_addEventToRemindBtn setBackgroundColor:UIColorFromHex(0x5D8DE4)];
        [_addEventToRemindBtn addTarget:self action:@selector(clickAddEventToRemindBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addEventToRemindBtn;
}
@end
