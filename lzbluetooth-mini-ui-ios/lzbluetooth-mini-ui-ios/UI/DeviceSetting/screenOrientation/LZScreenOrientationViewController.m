//
//  LZScreenOrientationViewController.m
//  LSBluetoothUI_iOS
//
//  Created by wm on 2020/12/8.
//

#import "LZScreenOrientationViewController.h"
#import <Masonry/Masonry.h>
#import "LZScreenOrientationCellModel.h"
#import "LZScreenOrientationCell.h"

@interface LZScreenOrientationViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray <LZScreenOrientationCellModel *> *modelAry;
@end

@implementation LZScreenOrientationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"屏幕方向";
    self.view.backgroundColor = [UIColor whiteColor];
    [self createUI];
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
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
    NSLog(@"点击了");
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.modelAry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LZScreenOrientationCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LZScreenOrientationCell class]) forIndexPath:indexPath];
    [cell updateCellWithModel:self.modelAry[indexPath.row]];
    return cell;
}

#pragma mark - getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[LZScreenOrientationCell class] forCellReuseIdentifier:NSStringFromClass([LZScreenOrientationCell class])];
    }
    return _tableView;
}

- (NSArray<LZScreenOrientationCellModel *> *)modelAry {
    if (!_modelAry) {
        _modelAry = [LZScreenOrientationCellModel cellModelList];
    }
    return _modelAry;
}
@end
