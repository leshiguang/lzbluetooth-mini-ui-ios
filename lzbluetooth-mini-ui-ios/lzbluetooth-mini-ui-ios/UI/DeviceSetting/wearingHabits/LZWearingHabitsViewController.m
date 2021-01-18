//
//  LZWearingHabitsViewController.m
//  LSBluetoothUI_iOS
//
//  Created by wm on 2020/12/8.
//

#import "LZWearingHabitsViewController.h"
#import <Masonry/Masonry.h>
#import "LZWearingHabitsModel.h"
#import "LZWearingHabitsCell.h"

@interface LZWearingHabitsViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray <LZWearingHabitsModel *> * modelAry;

@property (nonatomic, strong) LZA5SettingWristHabitData *data;
@end

@implementation LZWearingHabitsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"佩戴习惯";
    self.view.backgroundColor = [UIColor whiteColor];
    [self createUI];
    
    self.data = [self settingData];
    NSInteger index = self.data.displayMode == LZA5DisplayModeLeft ? 0 : 1;
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
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
    LZWearingHabitsCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LZWearingHabitsCell class]) forIndexPath:indexPath];
    [cell updateCellWithModel:self.modelAry[indexPath.row]];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.data.displayMode = indexPath.row == 0 ? LZA5DisplayModeLeft : LZA5DisplayModeRight;
    
    [self sendData:self.data];
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
        [_tableView registerClass:[LZWearingHabitsCell class] forCellReuseIdentifier:NSStringFromClass([LZWearingHabitsCell class])];
    }
    return _tableView;
}

- (NSArray<LZWearingHabitsModel *> *)modelAry {
    if (!_modelAry) {
        _modelAry = [[NSArray alloc] init];
        _modelAry = [LZWearingHabitsModel cellModelList];
    }
    return _modelAry;
}

@end
