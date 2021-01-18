//
//  LZAddEventToRemindViewController.m
//  LSBluetoothUI_iOS
//
//  Created by wm on 2020/12/8.
//

#import "LZAddEventToRemindViewController.h"
#import "LZAddEventToRemindCell.h"
#import "LZAddEventToRemindCellModel.h"
#import <Masonry/Masonry.h>
#import "LZAddEventToRemindContentTableViewCell.h"
#import "LZSetPickerViewController.h"
#import "LZPickerAnimator.h"
#import "LZSetPopUpAnimator.h"
#import "LZSetPopUpViewController.h"
#import "LSWAppFontConfigrationMacro.h"
#import "LSWAppColorConfigrationMacro.h"

@interface LZAddEventToRemindViewController () <UITableViewDelegate, UITableViewDataSource, LZSetPickerDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray <LZAddEventToRemindCellModel *> * modelAry;
@property (nonatomic, strong) UIButton *sureBtn;
@property (nonatomic, strong) LZPickerAnimator *pickerAnimotor;
@property (nonatomic, assign) LZADDEVENTTOREMINDTYPE currentPickerType;

@property (nonatomic, copy) NSArray *hoursAry;
@property (nonatomic, copy) NSArray *minutesOrSecondsAry;
@property (nonatomic, copy) NSArray *weekAry;
@property (nonatomic, copy) NSArray *vibrationModelAry;
@property (nonatomic, copy) NSArray *vibrationModelLeaveAry;

@end

@implementation LZAddEventToRemindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"事件提醒";
    self.view.backgroundColor = [UIColor whiteColor];
    [self createUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)createUI {
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.sureBtn];
    
    [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-24);
        make.left.equalTo(self.view).offset(70);
        make.right.equalTo(self.view).offset(-70);
        make.height.equalTo(@50);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(0);
        make.left.and.right.equalTo(self.view);
        make.bottom.equalTo(self.sureBtn.mas_top).offset(-10);
    }];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == self.modelAry.count) {
        return 110;
    }
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.modelAry[indexPath.row].setType == LZADDEVENTTOREMINDTYPE_OPENR_EMIND) {
        return;
    }
    if (self.modelAry[indexPath.row].setType == LZADDEVENTTOREMINDTYPE_REPEAT_TIME) {
        [self showSetPopupWeek:self.modelAry[indexPath.row]];
        return;
    }
    [self selectCellWihtModel:self.modelAry[indexPath.row]];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.modelAry.count+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < self.modelAry.count) {
        LZAddEventToRemindCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LZAddEventToRemindCell class]) forIndexPath:indexPath];
        [cell updateCellWithModel:self.modelAry[indexPath.row]];
        return cell;
    } else if (indexPath.row == self.modelAry.count) {
        LZAddEventToRemindContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LZAddEventToRemindContentTableViewCell class]) forIndexPath:indexPath];
        return cell;
    }
    return nil;
}

#pragma mark - LZSetPickerDelegate
- (void)pickerEnd:(NSArray *)selectAry isSure:(BOOL)isSure {
    [self dismissViewControllerAnimated:YES completion:nil];
    if (!isSure) {
        return;
    }
    switch (self.currentPickerType) {
        case LZADDEVENTTOREMINDTYPE_REMIND_TIME:{
//            NSString *timeStr = [NSString stringWithFormat:@"%@:%@",selectAry[0],selectAry[1]];
        }
            break;
        case LZADDEVENTTOREMINDTYPE_VIBRATION_MODE:{
            
        }
            break;
        case LZADDEVENTTOREMINDTYPE_VIBRATION_LEAVE1:
            break;
        case LZADDEVENTTOREMINDTYPE_VIBRATION_LEAVE2:
            break;
        case LZADDEVENTTOREMINDTYPE_VIBRATION_TIME:
            break;
        default:
            break;
    }
}

#pragma mark - Privates Methods

- (void)showSetPopupWeek:(LZAddEventToRemindCellModel *)model {
    LZSetPopUpViewController *vc = [[LZSetPopUpViewController alloc] init];
    vc.modalPresentationStyle = UIModalPresentationCustom;
    LZSetPopUpAnimator *popUpAnimator = [[LZSetPopUpAnimator alloc] initWithPresentedViewController:self presentingViewController:vc];
    vc.transitioningDelegate = popUpAnimator;
    vc.dataSoureAry = self.weekAry;
    vc.sureBlock = ^(NSArray<NSIndexPath *> * _Nonnull ary) {
        NSLog(@"%@", ary);
        
        
    };
    self.currentPickerType = model.setType;
    [self presentViewController:vc animated:NO completion:nil];
}

- (void)selectCellWihtModel:(LZAddEventToRemindCellModel *)model {
    LZSetPickerViewController *vc = [[LZSetPickerViewController alloc] init];
    vc.modalPresentationStyle = UIModalPresentationCustom;
    LZPickerAnimator *pickerAnimotor = [[LZPickerAnimator alloc] initWithPresentedViewController:self presentingViewController:vc];
    vc.transitioningDelegate = pickerAnimotor;
    vc.delegate = self;
    self.currentPickerType = model.setType;
    switch (model.setType) {
        case LZADDEVENTTOREMINDTYPE_REMIND_TIME:
            vc.dataSoureAry = @[self.hoursAry, self.minutesOrSecondsAry];
            break;
        case LZADDEVENTTOREMINDTYPE_VIBRATION_MODE:
            vc.dataSoureAry = @[self.vibrationModelAry];
            break;
        case LZADDEVENTTOREMINDTYPE_VIBRATION_LEAVE1:
        case LZADDEVENTTOREMINDTYPE_VIBRATION_LEAVE2:
            vc.dataSoureAry = @[self.vibrationModelLeaveAry];
            break;
        case LZADDEVENTTOREMINDTYPE_VIBRATION_TIME:
            vc.dataSoureAry = @[self.minutesOrSecondsAry];
            break;
        default:
            break;
    }
    [self presentViewController:vc animated:YES completion:^{

    }];
}

#pragma mark - evnet
- (void)clickSureBtn:(UIButton *)btn {
    
    
}

#pragma mark - getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[LZAddEventToRemindCell class] forCellReuseIdentifier:NSStringFromClass([LZAddEventToRemindCell class])];
        [_tableView registerClass:[LZAddEventToRemindContentTableViewCell class] forCellReuseIdentifier:NSStringFromClass([LZAddEventToRemindContentTableViewCell class])];
    }
    return _tableView;
}

- (NSArray<LZAddEventToRemindCellModel *> *)modelAry {
    if (!_modelAry) {
        _modelAry = [[NSArray alloc] init];
        _modelAry = [LZAddEventToRemindCellModel cellModelList];
    }
    return _modelAry;
}

- (UIButton *)sureBtn {
    if (!_sureBtn) {
        _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_sureBtn.titleLabel setFont:LSWDefaultFontWithSize(16)];
        [_sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_sureBtn.layer setCornerRadius:25];
        [_sureBtn setBackgroundColor:UIColorFromHex(0x5D8DE4)];
        [_sureBtn addTarget:self action:@selector(clickSureBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureBtn;
}

- (NSArray *)hoursAry {
    if (!_hoursAry) {
        _hoursAry = [[NSArray alloc] init];
        NSMutableArray *mAry = [[NSMutableArray alloc] init];
        for (int i = 0; i <= 24; i++) {
            [mAry addObject:[NSString stringWithFormat:@"%@%d",i<10 ? @"0": @"",i]];
        }
        _hoursAry = [mAry copy];
    }
    return _hoursAry;
}

- (NSArray *)minutesOrSecondsAry {
    if (!_minutesOrSecondsAry) {
        _minutesOrSecondsAry = [[NSArray alloc] init];
        NSMutableArray *mAry = [[NSMutableArray alloc] init];
        for (int i = 0; i <= 60; i++) {
            [mAry addObject:[NSString stringWithFormat:@"%@%d",i<10 ? @"0": @"",i]];
        }
        _minutesOrSecondsAry = [mAry copy];
    }
    return _minutesOrSecondsAry;
}

- (NSArray *)weekAry {
    if (!_weekAry) {
        _weekAry = [[NSArray alloc] init];
        _weekAry = @[@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六",@"星期日"];
    }
    return _weekAry;
}

- (NSArray *)vibrationModelAry {
    if (!_vibrationModelAry) {
        _vibrationModelAry = @[@"持续震动",@"间歇震动，震动强度不变",@"间歇震动，震动强度由小变大",@"间歇震动，震动强度由大变小",@"震动强度大小循环"];
    }
    return _vibrationModelAry;
}

- (NSArray *)vibrationModelLeaveAry {
    if (!_vibrationModelLeaveAry) {
        _vibrationModelLeaveAry = @[@"00",@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09"];
    }
    return _vibrationModelLeaveAry;
}

@end
