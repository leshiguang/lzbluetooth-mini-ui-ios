//
//  LZMessageToRemindViewController.m
//  LSBluetoothUI_iOS
//
//  Created by wm on 2020/12/8.
//

#import "LZMessageToRemindViewController.h"
#import "LZMessageToRemindCell.h"
#import "LZMessageToRemindCellModel.h"
#import <Masonry/Masonry.h>

@interface LZMessageToRemindViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray <LZMessageToRemindCellModel *> *modelAry;
@end

@implementation LZMessageToRemindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息提醒";
    self.view.backgroundColor = [UIColor whiteColor];
    [self createUI];
}

- (void)createUI {
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.modelAry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LZMessageToRemindCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LZMessageToRemindCell class]) forIndexPath:indexPath];
    [cell updateCellWithModel:self.modelAry[indexPath.row]];
    return cell;
}

#pragma mark - getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[LZMessageToRemindCell class] forCellReuseIdentifier:NSStringFromClass([LZMessageToRemindCell class])];
    }
    return _tableView;
}

- (NSArray<LZMessageToRemindCellModel *> *)modelAry {
    if (!_modelAry) {
        _modelAry = [[NSArray alloc] init];
        _modelAry = [LZMessageToRemindCellModel cellModelList];
    }
    return _modelAry;
}

@end
