//
//  LZTimeFormatViewController.m
//  LSBluetoothUI_iOS
//
//  Created by wm on 2020/12/8.
//

#import "LZTimeFormatViewController.h"
#import "LZTimeFormatModel.h"
#import "LZTimeFormatCell.h"
#import <Masonry/Masonry.h>

@interface LZTimeFormatViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray <LZTimeFormatModel *> *modelAry;
@end

@implementation LZTimeFormatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"时间制式";
    self.view.backgroundColor = [UIColor whiteColor];
    [self createUI];
}

- (void)createUI {
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.modelAry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LZTimeFormatCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LZTimeFormatCell class]) forIndexPath:indexPath];
    [cell updateCellWithModel:self.modelAry[indexPath.row]];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[LZTimeFormatCell class] forCellReuseIdentifier:NSStringFromClass([LZTimeFormatCell class])];
    }
    return _tableView;
}

- (NSArray<LZTimeFormatModel *> *)modelAry {
    if (!_modelAry) {
        _modelAry = [[NSArray alloc] init];
        _modelAry = [LZTimeFormatModel cellModelList];
    }
    return _modelAry;
}
@end
