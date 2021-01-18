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

@interface LZMessageToRemindViewController () <UITableViewDelegate, UITableViewDataSource, LZMessageToRemindCellDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray <LZMessageToRemindCellModel *> *modelAry;

@property (nonatomic, strong) LZA5SettingCallReminderData *data;
@end

@implementation LZMessageToRemindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息提醒";
    self.view.backgroundColor = [UIColor whiteColor];
    /// 这里没有读取缓存，因为比较特殊，每个设置，都是单独的
    [self createUI];
}

- (void)createUI {
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

#pragma mark - LZMessageToRemindCellDelegate
- (void)switchOn:(BOOL)isOn cellModle:(LZMessageToRemindCellModel *)cellModel {
    self.data.reminderType = cellModel.setType;
    self.data.enable = isOn;
    self.data.delay = 3;
    self.data.vibrationType = LZA5VibrationTypeAlways;
    self.data.vibrationTime = 60;
    self.data.vibrationLevel1 = 9;
    self.data.vibrationLevel2 = 9;

    [self sendData:self.data];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.modelAry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LZMessageToRemindCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LZMessageToRemindCell class]) forIndexPath:indexPath];
    [cell updateCellWithModel:self.modelAry[indexPath.row]];
    cell.delegate = self;
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
