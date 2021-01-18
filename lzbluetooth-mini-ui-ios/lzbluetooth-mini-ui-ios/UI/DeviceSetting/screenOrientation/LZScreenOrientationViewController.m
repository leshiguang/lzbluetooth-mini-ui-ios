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
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray <LZScreenOrientationCellModel *> *modelAry;
@property (nonatomic, strong) LZA5SettingScreenDirectionData *data;

@end

@implementation LZScreenOrientationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"屏幕方向";
    self.view.backgroundColor = [UIColor whiteColor];
    [self createUI];
    self.data = [self settingData];
    NSInteger index = self.data.screenDirection == LZA5ScreenDirectionH ? 0 : 1;
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
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
    self.data.screenDirection = indexPath.row == 0 ? LZA5ScreenDirectionH : LZA5ScreenDirectionV;
    
    [self sendData:self.data];
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
