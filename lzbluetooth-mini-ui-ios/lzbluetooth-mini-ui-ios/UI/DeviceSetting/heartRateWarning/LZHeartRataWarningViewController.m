//
//  LZHeartRataWarningViewController.m
//  LSBluetoothUI_iOS
//
//  Created by wm on 2020/12/8.
//

#import "LZHeartRataWarningViewController.h"
#import "LZHeartRateWarningCell.h"
#import "LZHearRateWarningCellModel.h"
#import <Masonry/Masonry.h>
#import "LZPickerAnimator.h"
#import "LZSetPickerViewController.h"

@interface LZHeartRataWarningViewController () <UITableViewDelegate, UITableViewDataSource, LZHeartRateWarningCellDelegate, LZSetPickerDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray <LZHearRateWarningCellModel *> *modelAry;
@property (nonatomic, copy) NSArray *hearRateValueAry;
@end

@implementation LZHeartRataWarningViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"心率预警";
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
    [self handleCellClickWithModel:self.modelAry[indexPath.row]];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LZHeartRateWarningCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LZHeartRateWarningCell class]) forIndexPath:indexPath];
    [cell updateCellWithModel:self.modelAry[indexPath.row]];
    cell.delegate = self;
    return cell;
}

#pragma mark - LZHeartRateWarningCellDelegate
- (void)switchOn:(BOOL)isOn cellModle:(LZHearRateWarningCellModel *)cellModel {
    if (cellModel.setType == LZHearRateWarningStyleSwitch) {
        
    }
}

#pragma mark - Private Methods

- (void)handleCellClickWithModel:(LZHearRateWarningCellModel *)model {
    if (model.setType == LZHearRateWarningStyleZone) {
        LZSetPickerViewController *vc = [[LZSetPickerViewController alloc] init];
        vc.modalPresentationStyle = UIModalPresentationCustom;
        LZPickerAnimator *pickerAnimotor = [[LZPickerAnimator alloc] initWithPresentedViewController:self presentingViewController:vc];
        vc.transitioningDelegate = pickerAnimotor;
        vc.delegate = self;
//        self.currentPickerType = model.setType;
        vc.dataSoureAry = @[self.hearRateValueAry, self.hearRateValueAry];
        [self presentViewController:vc animated:YES completion:nil];
    }
}

#pragma mark - getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[LZHeartRateWarningCell class] forCellReuseIdentifier:NSStringFromClass([LZHeartRateWarningCell class])];
    }
    return _tableView;
}

- (NSArray<LZHearRateWarningCellModel *> *)modelAry {
    if (!_modelAry) {
        _modelAry = [[NSArray alloc] init];
        _modelAry = [LZHearRateWarningCellModel cellModelList];
    }
    return _modelAry;
}

- (NSArray *)hearRateValueAry {
    if (!_hearRateValueAry) {
        _hearRateValueAry = [[NSArray alloc] init];
        NSMutableArray *mAry = [[NSMutableArray alloc] init];
        for (int i = 20; i <= 300; i++) {
            [mAry addObject:[NSString stringWithFormat:@"%@%d",i<10 ? @"0": @"",i]];
        }
        _hearRateValueAry = [mAry copy];
    }
    return _hearRateValueAry;
}

@end
