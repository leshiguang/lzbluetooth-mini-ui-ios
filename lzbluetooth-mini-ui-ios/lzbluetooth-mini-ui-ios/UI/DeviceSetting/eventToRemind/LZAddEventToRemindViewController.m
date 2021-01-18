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

@property (nonatomic, assign) BOOL isCreate;

@end

@implementation LZAddEventToRemindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"事件提醒";
    self.view.backgroundColor = [UIColor whiteColor];
    [self createUI];
    
    if (!self.contentData) {
        self.isCreate = YES;
        LZA5SettingEventRemindContentData *contentData = [[LZA5SettingEventRemindContentData alloc] init];
        contentData.des = @"闹钟1";
        contentData.index = self.data.contentDatas.lastObject.index + 1;
        contentData.enable = YES;
        contentData.hour = 8;
        contentData.minute = 0;
        contentData.repeatFlag = LZA5RepeatTimeFlagAll;
        contentData.vibrationType = LZA5VibrationTypeAlways;
        contentData.vibrationTime = 60;
        contentData.vibrationLevel1 = 9;
        contentData.vibrationLevel2 = 9;
        self.contentData = contentData;
    }
    
    [self updateUI];
    
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

- (void)updateUI {
    LZAddEventToRemindCellModel *model0 = self.modelAry[0];
    model0.switchIsOpne = self.contentData.enable;
    
    LZAddEventToRemindCellModel *model1 = self.modelAry[1];
    model1.subStr = [NSString stringWithFormat:@"%02d:%02d", self.contentData.hour, self.contentData.minute];
    LZAddEventToRemindCellModel *model2 = self.modelAry[2];
    model2.subStr = [self repeatTimeStringWithFlag:self.contentData.repeatFlag];
    LZAddEventToRemindCellModel *model3 = self.modelAry[3];
    model3.subStr = self.vibrationModelAry[self.contentData.vibrationType];
    LZAddEventToRemindCellModel *model4 = self.modelAry[4];
    model4.subStr = self.vibrationModelLeaveAry[self.contentData.vibrationLevel1];
    LZAddEventToRemindCellModel *model5 = self.modelAry[5];
    model5.subStr = self.vibrationModelLeaveAry[self.contentData.vibrationLevel1];
    LZAddEventToRemindCellModel *model6 = self.modelAry[6];
    model6.subStr = self.minutesOrSecondsAry[self.contentData.vibrationTime];
    
    [self.tableView reloadData];
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
        cell.textView.text = self.contentData.des;
        return cell;
    }
    return nil;
}

#pragma mark - LZSetPickerDelegate
- (void)pickerViewControllerDidSelect:(LZSetPickerViewController *)vc {
    NSInteger row = [vc selectedRowInComponent:0];
    switch (self.currentPickerType) {
        case LZADDEVENTTOREMINDTYPE_REMIND_TIME: {
            NSInteger min = [vc selectedRowInComponent:1];
            self.contentData.hour = row;
            self.contentData.minute = min;
            break;
        }
        case LZADDEVENTTOREMINDTYPE_VIBRATION_MODE:
            self.contentData.vibrationType = row;
            break;
        case LZADDEVENTTOREMINDTYPE_VIBRATION_LEAVE1:
            self.contentData.vibrationLevel1 = row;
            break;
        case LZADDEVENTTOREMINDTYPE_VIBRATION_LEAVE2:
            self.contentData.vibrationLevel2 = row ;
            break;
        case LZADDEVENTTOREMINDTYPE_VIBRATION_TIME:
            self.contentData.vibrationTime = row;
            break;
        default:
            break;
    }
    [vc dismissViewControllerAnimated:YES completion:nil];
    [self updateUI];
}

#pragma mark - Privates Methods

- (void)showSetPopupWeek:(LZAddEventToRemindCellModel *)model {
    LZSetPopUpViewController *vc = [[LZSetPopUpViewController alloc] init];
    vc.modalPresentationStyle = UIModalPresentationCustom;
    LZSetPopUpAnimator *popUpAnimator = [[LZSetPopUpAnimator alloc] initWithPresentedViewController:self presentingViewController:vc];
    vc.transitioningDelegate = popUpAnimator;
    vc.dataSoureAry = self.weekAry;
    __weak typeof(self) weakSelf = self;
    vc.sureBlock = ^(NSArray<NSIndexPath *> * _Nonnull ary) {
        NSLog(@"%@", ary);
        __block LZA5RepeatTimeFlag flag = LZA5RepeatTimeFlagNon;
        [ary enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            flag |= (1 << obj.row);
        }];
        weakSelf.contentData.repeatFlag = flag;
        [weakSelf updateUI];
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
            [vc selectRow:self.contentData.hour inComponent:0 animated:NO];
            [vc selectRow:self.contentData.minute inComponent:1 animated:NO];
            break;
        case LZADDEVENTTOREMINDTYPE_VIBRATION_MODE:
            vc.dataSoureAry = @[self.vibrationModelAry];
            [vc selectRow:self.contentData.vibrationType inComponent:0 animated:NO];
            break;
        case LZADDEVENTTOREMINDTYPE_VIBRATION_LEAVE1:
            vc.dataSoureAry = @[self.vibrationModelLeaveAry];
            [vc selectRow:self.contentData.vibrationLevel1 inComponent:0 animated:NO];
            break;
        case LZADDEVENTTOREMINDTYPE_VIBRATION_LEAVE2:
            vc.dataSoureAry = @[self.vibrationModelLeaveAry];
            [vc selectRow:self.contentData.vibrationLevel2 inComponent:0 animated:NO];
            break;
        case LZADDEVENTTOREMINDTYPE_VIBRATION_TIME:
            vc.dataSoureAry = @[self.minutesOrSecondsAry];
            [vc selectRow:self.contentData.vibrationTime inComponent:0 animated:NO];
            break;
        default:
            break;
    }
    [self presentViewController:vc animated:YES completion:^{

    }];
}

#pragma mark - evnet
- (void)clickSureBtn:(UIButton *)btn {
    if (self.isCreate) {
        NSMutableArray *array = [NSMutableArray array];
        if (self.data.contentDatas) {
            [array addObjectsFromArray:self.data.contentDatas];
        }
        [array addObject:self.contentData];
        self.data.contentDatas = array;
        [self sendData:self.data];
    } else {
        [self sendData:self.data];
    }
    
}

#pragma mark - getter
- (NSString *)repeatTimeStringWithFlag:(LZA5RepeatTimeFlag)flag {
    if (flag == LZA5RepeatTimeFlagAll) {
        return @"每天";
    }
    
    if ((flag & 0b11111) == 0b11111) {
        return @"工作日";
    }
    
    if ((flag & 0b1100000) == 0b1100000) {
        return @"周末";
    }
    
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < 7; i++) {
        if (flag & (1 << i)) {
            [array addObject:[self weekStringWithIndex:i]];
        }
    }
    return [array componentsJoinedByString:@","];
}

- (NSString *)weekStringWithIndex:(NSInteger)index {
    switch (index) {
        case 0:
            return @"一";
            break;
        case 1:
            return @"二";
        case 2:
            return @"三";
            break;
        case 3:
            return @"四";
        case 4:
            return @"五";
        case 5:
            return @"六";
        case 6:
            return @"日";
            break;
            
            
        default:
            break;
    }
    return @"";
}

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
