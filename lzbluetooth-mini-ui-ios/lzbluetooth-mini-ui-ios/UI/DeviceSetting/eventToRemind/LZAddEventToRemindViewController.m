//
//  LZAddEventToRemindViewController.m
//  LSBluetoothUI_iOS
//
//  Created by wm on 2020/12/8.
//

#import "LZAddEventToRemindViewController.h"

#import <Masonry/Masonry.h>
#import "LZAddEventToRemindContentTableViewCell.h"
#import "LZSetPickerViewController.h"
#import "LZPickerAnimator.h"
#import "LZSetPopUpAnimator.h"
#import "LZSetPopUpViewController.h"
#import "LSWAppFontConfigrationMacro.h"
#import "LSWAppColorConfigrationMacro.h"


typedef enum : NSUInteger {
    LZADDEVENTTOREMINDTYPE_OPENR_EMIND,      //打开提醒
    LZADDEVENTTOREMINDTYPE_REMIND_TIME,        //提醒时间
    LZADDEVENTTOREMINDTYPE_REPEAT_TIME,         //每周重复时间
    LZADDEVENTTOREMINDTYPE_VIBRATION_MODE,      //震动方式
    LZADDEVENTTOREMINDTYPE_VIBRATION_LEAVE1,    //震动等级1
    LZADDEVENTTOREMINDTYPE_VIBRATION_LEAVE2,    //震动等级2
    LZADDEVENTTOREMINDTYPE_VIBRATION_TIME       //震动时长
} LZADDEVENTTOREMINDTYPE;


@interface LZAddEventToRemindViewController () <LZSetPickerDelegate>
@property (nonatomic, strong) NSArray <LZBaseSetCellModel *> * modelAry;
@property (nonatomic, strong) UIButton *sureBtn;
@property (nonatomic, strong) LZPickerAnimator *pickerAnimotor;
@property (nonatomic, assign) LZADDEVENTTOREMINDTYPE currentPickerType;

@property (nonatomic, copy) NSArray *weekAry;
@property (nonatomic, copy) NSArray *vibrationModelAry;
@property (nonatomic, copy) NSArray *vibrationModelLeaveAry;
@property (nonatomic, copy) NSArray *vibrationTimeAry;

@property (nonatomic, assign) BOOL isCreate;

@end

@implementation LZAddEventToRemindViewController

@synthesize data;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"事件提醒";
    self.view.backgroundColor = [UIColor whiteColor];
    [self createUI];
    
    [self.tableView registerClass:[LZAddEventToRemindContentTableViewCell class] forCellReuseIdentifier:NSStringFromClass(LZAddEventToRemindContentTableViewCell.class)];
    
    [self updateUI];
}

- (void)updateUIWithResult:(LZBluetoothErrorCode)result {
    if (result == LZBluetoothErrorCodeSuccess) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)createUI {

    [self.view addSubview:self.sureBtn];
    
    [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-24);
        make.left.equalTo(self.view).offset(70);
        make.right.equalTo(self.view).offset(-70);
        make.height.equalTo(@50);
    }];
}

- (void)updateUI {
    LZBaseSetCellModel *model0 = self.modelAry[0];
    model0.switchIsOpne = self.contentData.enable;
    
    LZBaseSetCellModel *model1 = self.modelAry[1];
    model1.subStr = [NSString stringWithFormat:@"%02d:%02d", self.contentData.hour, self.contentData.minute];
    LZBaseSetCellModel *model2 = self.modelAry[2];
    model2.subStr = [self repeatTimeStringWithFlag:self.contentData.repeatFlag];
    LZBaseSetCellModel *model3 = self.modelAry[3];
    model3.subStr = self.vibrationModelAry[self.contentData.vibrationType];
    LZBaseSetCellModel *model4 = self.modelAry[4];
    model4.subStr = self.vibrationModelLeaveAry[self.contentData.vibrationLevel1];
    LZBaseSetCellModel *model5 = self.modelAry[5];
    model5.subStr = self.vibrationModelLeaveAry[self.contentData.vibrationLevel1];
    LZBaseSetCellModel *model6 = self.modelAry[6];
    model6.subStr = self.vibrationTimeAry[MAX(0, self.contentData.vibrationTime - 1)];
    
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
    return self.modelAry.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < self.modelAry.count) {
        LZBaseSetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LZBaseSetTableViewCell class]) forIndexPath:indexPath];
        [cell updateCellWithModel:self.modelAry[indexPath.row]];
        return cell;
    } else if (indexPath.row == self.modelAry.count) {
        LZAddEventToRemindContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LZAddEventToRemindContentTableViewCell class]) forIndexPath:indexPath];
        cell.textView.text = self.contentData.des;
        
        __weak typeof(self) weakSelf = self;
        cell.textViewDidChangeBlock = ^(NSString * _Nonnull text) {
            weakSelf.contentData.des = text;
        };
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

- (void)showSetPopupWeek:(LZBaseSetCellModel *)model {
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

- (void)selectCellWihtModel:(LZBaseSetCellModel *)model {
    LZSetPickerViewController *vc = [[LZSetPickerViewController alloc] init];
    vc.modalPresentationStyle = UIModalPresentationCustom;
    LZPickerAnimator *pickerAnimotor = [[LZPickerAnimator alloc] initWithPresentedViewController:self presentingViewController:vc];
    vc.transitioningDelegate = pickerAnimotor;
    vc.delegate = self;
    self.currentPickerType = model.setType;
    switch (model.setType) {
        case LZADDEVENTTOREMINDTYPE_REMIND_TIME:
            vc.dataSoureAry = @[self.hours, self.minutes];
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
            vc.dataSoureAry = @[self.vibrationTimeAry];
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
    /// 目前闹钟只支持发送一个闹钟
    self.data.contentDatas = @[self.contentData];
    [self sendData:self.data];
//    if (self.isCreate) {
//        NSMutableArray *array = [NSMutableArray array];
//        if (self.data.contentDatas) {
//            [array addObjectsFromArray:self.data.contentDatas];
//        }
//        [array addObject:self.contentData];
//        self.data.contentDatas = array;
//        [self sendData:self.data];
//    } else {
//
//        NSInteger index = [self.data.contentDatas indexOfObject:self.contentData];
//        NSAssert(index != NSNotFound, @"出现了问题");
//        NSMutableArray *arr = self.data.contentDatas.mutableCopy;
//        [arr replaceObjectAtIndex:index withObject:self.contentData];
//        self.data.contentDatas = arr.copy;
//        [self sendData:self.data];
//    }
}

#pragma mark - getter
- (NSString *)repeatTimeStringWithFlag:(LZA5RepeatTimeFlag)flag {
    if (flag == LZA5RepeatTimeFlagNon) {
        return @"不重复";
    }
    
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
        case 1:
            return @"二";
        case 2:
            return @"三";
        case 3:
            return @"四";
        case 4:
            return @"五";
        case 5:
            return @"六";
        case 6:
            return @"日";
            
        default:
            break;
    }
    return @"";
}

- (NSArray<LZBaseSetCellModel *> *)modelAry {
    if (!_modelAry) {
        NSMutableArray <LZBaseSetCellModel *> *mAry = [[NSMutableArray alloc] init];
        
        LZBaseSetCellModel *model1 = [[LZBaseSetCellModel alloc] initModelWithSetType:LZADDEVENTTOREMINDTYPE_OPENR_EMIND cellStyle:DEVICESETCELLSTYLE_RIGHT_SWITCH titleStr:@"打开提醒" subStr:nil];
        [mAry addObject:model1];
        
        LZBaseSetCellModel *model2 = [[LZBaseSetCellModel alloc] initModelWithSetType:LZADDEVENTTOREMINDTYPE_REMIND_TIME cellStyle:DEVICESETCELLSTYLE_RIGHT_IMG_SUBTITLE titleStr:@"提醒时间" subStr:@"15:31"];
        [mAry addObject:model2];
        
        LZBaseSetCellModel *model3 = [[LZBaseSetCellModel alloc] initModelWithSetType:LZADDEVENTTOREMINDTYPE_REPEAT_TIME cellStyle:DEVICESETCELLSTYLE_RIGHT_IMG_SUBTITLE titleStr:@"每周重复时间" subStr:@"星期一 星期二 星期三 星期四 星期五 星期六 星期天"];
        [mAry addObject:model3];
        
        LZBaseSetCellModel *model4 = [[LZBaseSetCellModel alloc] initModelWithSetType:LZADDEVENTTOREMINDTYPE_VIBRATION_MODE cellStyle:DEVICESETCELLSTYLE_RIGHT_IMG_SUBTITLE titleStr:@"震动方式" subStr:nil];
        [mAry addObject:model4];
        
        LZBaseSetCellModel *model5 = [[LZBaseSetCellModel alloc] initModelWithSetType:LZADDEVENTTOREMINDTYPE_VIBRATION_LEAVE1 cellStyle:DEVICESETCELLSTYLE_RIGHT_IMG_SUBTITLE titleStr:@"震动等级1" subStr:nil];
        [mAry addObject:model5];
        
        LZBaseSetCellModel *model6 = [[LZBaseSetCellModel alloc] initModelWithSetType:LZADDEVENTTOREMINDTYPE_VIBRATION_LEAVE2 cellStyle:DEVICESETCELLSTYLE_RIGHT_IMG_SUBTITLE titleStr:@"震动等级2" subStr:nil];
        [mAry addObject:model6];
        
        LZBaseSetCellModel *model7 = [[LZBaseSetCellModel alloc] initModelWithSetType:LZADDEVENTTOREMINDTYPE_VIBRATION_TIME cellStyle:DEVICESETCELLSTYLE_RIGHT_IMG_SUBTITLE titleStr:@"震动时长" subStr:nil];
        [mAry addObject:model7];
        _modelAry = mAry;
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

- (NSArray *)weekAry {
    if (!_weekAry) {
        _weekAry = [[NSArray alloc] init];
        _weekAry = @[@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六",@"星期日"];
    }
    return _weekAry;
}

- (NSArray *)vibrationTimeAry {
    if (!_vibrationTimeAry) {
        NSMutableArray *array = [NSMutableArray array];
        for (int i = 1; i <= 60; i++) {
            [array addObject:[NSString stringWithFormat:@"%d", i]];
        }
        _vibrationTimeAry = array;
    }
    return _vibrationTimeAry;
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
