//
//  LZLongSitViewController.m
//  LSBluetoothUI_iOS
//
//  Created by wm on 2020/12/8.
//

#import "LZLongSitViewController.h"
#import <Masonry/Masonry.h>

#import "LZSetPickerViewController.h"
#import "LZPickerAnimator.h"
#import "LZSetPopUpViewController.h"
#import "LZSetPopUpAnimator.h"

typedef enum : NSUInteger {
    LZADDEVENTTOREMINDTYPE_OPENR_EMIND,      //打开提醒
    LZADDEVENTTOREMINDTYPE_REMIND_EACH_TIME,   // 频次
    LZADDEVENTTOREMINDTYPE_REMIND_START_TIME,        //开始提醒时间
    LZADDEVENTTOREMINDTYPE_REMIND_END_TIME, // 结束时间
    LZADDEVENTTOREMINDTYPE_REPEAT_TIME,         //每周重复时间
    LZADDEVENTTOREMINDTYPE_VIBRATION_MODE,      //震动方式
    LZADDEVENTTOREMINDTYPE_VIBRATION_LEAVE1,    //震动等级1
    LZADDEVENTTOREMINDTYPE_VIBRATION_LEAVE2,    //震动等级2
    LZADDEVENTTOREMINDTYPE_VIBRATION_TIME       //震动时长
} LZADDEVENTTOREMINDTYPE;

@interface LZLongSitViewController () <LZBaseSetTableViewCellDelegate, LZSetPickerDelegate>

@property (nonatomic, copy) NSArray <LZBaseSetCellModel *> *modelAry;

@property (nonatomic, strong) LZA5SettingSedentaryReminderData *data;

@property (nonatomic, copy) NSArray *weekAry;
@property (nonatomic, copy) NSArray *vibrationModelAry;
@property (nonatomic, copy) NSArray *vibrationModelLeaveAry;
@property (nonatomic, copy) NSArray *vibrationTimeAry;

@property (nonatomic, assign) NSInteger currentPickerType;

@end

@implementation LZLongSitViewController

@synthesize data;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"久坐提醒";
    self.view.backgroundColor = [UIColor whiteColor];
 
    [self updateUI];
}

- (void)updateUI {
    LZBaseSetCellModel *model0 = self.modelAry[0];
    model0.switchIsOpne = self.data.enable;
    LZBaseSetCellModel *model1 = self.modelAry[1];
    model1.subStr = [NSString stringWithFormat:@"%dmin", self.data.eachTimeAlert];
    LZBaseSetCellModel *model2 = self.modelAry[2];
    model2.subStr = [NSString stringWithFormat:@"%02d:%02d", self.data.startHour, self.data.startMinute];
    LZBaseSetCellModel *model3 = self.modelAry[3];
    model3.subStr = [NSString stringWithFormat:@"%02d:%02d", self.data.endHour, self.data.endMinute];
    LZBaseSetCellModel *model4 = self.modelAry[4];
    model4.subStr = [self repeatTimeStringWithFlag:self.data.repeatFlag];
    LZBaseSetCellModel *model5 = self.modelAry[5];
    model5.subStr = self.vibrationModelAry[self.data.vibrationType];
    LZBaseSetCellModel *model6 = self.modelAry[6];
    model6.subStr = self.vibrationModelLeaveAry[self.data.vibrationLevel1];
    LZBaseSetCellModel *model7 = self.modelAry[7];
    model7.subStr = self.vibrationModelLeaveAry[self.data.vibrationLevel1];
    LZBaseSetCellModel *model8 = self.modelAry[8];
    model8.subStr = self.vibrationTimeAry[MAX(0, self.data.vibrationTime - 1)];
    [self.tableView reloadData];
    
}

#pragma mark - LZNightModelCellModelDelegate
- (void)switchOn:(BOOL)isOn cellModle:(LZBaseSetCellModel *_Nonnull)cellModel {
    self.data.enable = isOn;
    
    [self sendData:self.data];
}

#pragma mark - LZSetPickerDelegate


- (void)pickerViewControllerDidSelect:(LZSetPickerViewController *)vc {
    NSInteger row = [vc selectedRowInComponent:0];
    switch (self.currentPickerType) {
        case LZADDEVENTTOREMINDTYPE_REMIND_START_TIME: {
            NSInteger min = [vc selectedRowInComponent:1];
            self.data.startHour = row;
            self.data.startMinute = min;
            break;
        }
        case LZADDEVENTTOREMINDTYPE_REMIND_END_TIME: {
            NSInteger min = [vc selectedRowInComponent:1];
            self.data.endHour = row;
            self.data.endMinute = min;
            break;
        }
        case LZADDEVENTTOREMINDTYPE_VIBRATION_MODE:
            self.data.vibrationType = row;
            break;
        case LZADDEVENTTOREMINDTYPE_VIBRATION_LEAVE1:
            self.data.vibrationLevel1 = row;
            break;
        case LZADDEVENTTOREMINDTYPE_VIBRATION_LEAVE2:
            self.data.vibrationLevel2 = row ;
            break;
        case LZADDEVENTTOREMINDTYPE_VIBRATION_TIME:
            self.data.vibrationTime = row;
            break;
        case LZADDEVENTTOREMINDTYPE_REMIND_EACH_TIME:
            self.data.eachTimeAlert = row + 1;
        default:
            break;
    }
    [self updateUI];
    
    [vc dismissViewControllerAnimated:YES completion:nil];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    LZBaseSetCellModel *model = self.modelAry[indexPath.row];
    if (model.cellStyle == DEVICESETCELLSTYLE_RIGHT_SWITCH) {
        return;
    }
    if (model.setType == LZADDEVENTTOREMINDTYPE_REPEAT_TIME) {
        [self showSetPopupWeek:model];
        return;
    }
    [self selectCellWihtModel:model];
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
    LZBaseSetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LZBaseSetTableViewCell class]) forIndexPath:indexPath];
    [cell updateCellWithModel:self.modelAry[indexPath.row]];
    cell.delegate = self;
    return cell;
}



- (void)selectCellWihtModel:(LZBaseSetCellModel *)model {
    self.currentPickerType = model.setType;
    LZSetPickerViewController *vc = [[LZSetPickerViewController alloc] init];
    vc.modalPresentationStyle = UIModalPresentationCustom;
    LZPickerAnimator *pickerAnimotor = [[LZPickerAnimator alloc] initWithPresentedViewController:self presentingViewController:vc];
    vc.transitioningDelegate = pickerAnimotor;
    vc.delegate = self;
    self.currentPickerType = model.setType;
    switch (model.setType) {
        case LZADDEVENTTOREMINDTYPE_REMIND_START_TIME:
            vc.dataSoureAry = @[self.hours, self.minutes];
            [vc selectRow:self.data.startHour inComponent:0 animated:NO];
            [vc selectRow:self.data.startMinute inComponent:1 animated:NO];
            break;
        case LZADDEVENTTOREMINDTYPE_REMIND_END_TIME:
            vc.dataSoureAry = @[self.hours, self.minutes];
            [vc selectRow:self.data.endHour inComponent:0 animated:NO];
            [vc selectRow:self.data.endMinute inComponent:1 animated:NO];
            break;
        case LZADDEVENTTOREMINDTYPE_VIBRATION_MODE:
            vc.dataSoureAry = @[self.vibrationModelAry];
            [vc selectRow:self.data.vibrationType inComponent:0 animated:NO];
            break;
        case LZADDEVENTTOREMINDTYPE_VIBRATION_LEAVE1:
            vc.dataSoureAry = @[self.vibrationModelLeaveAry];
            [vc selectRow:self.data.vibrationLevel1 inComponent:0 animated:NO];
            break;
        case LZADDEVENTTOREMINDTYPE_VIBRATION_LEAVE2:
            vc.dataSoureAry = @[self.vibrationModelLeaveAry];
            [vc selectRow:self.data.vibrationLevel2 inComponent:0 animated:NO];
            break;
        case LZADDEVENTTOREMINDTYPE_VIBRATION_TIME:
            vc.dataSoureAry = @[self.vibrationTimeAry];
            [vc selectRow:self.data.vibrationTime inComponent:0 animated:NO];
            break;
        case LZADDEVENTTOREMINDTYPE_REMIND_EACH_TIME:
            vc.dataSoureAry = @[self.eachTimeAry];
            [vc selectRow:self.data.eachTimeAlert - 1 inComponent:0 animated:NO];
            break;
        default:
            break;
    }
    [self presentViewController:vc animated:YES completion:^{

    }];
}

- (void)showSetPopupWeek:(LZBaseSetCellModel *)model {
    LZSetPopUpViewController *vc = [[LZSetPopUpViewController alloc] init];
    vc.modalPresentationStyle = UIModalPresentationCustom;
    LZSetPopUpAnimator *popUpAnimator = [[LZSetPopUpAnimator alloc] initWithPresentedViewController:self presentingViewController:vc];
    vc.transitioningDelegate = popUpAnimator;
    vc.dataSoureAry = self.weekAry;
    __weak typeof(self) weakSelf = self;
    vc.sureBlock = ^(NSArray<NSIndexPath *> * _Nonnull ary) {
//        NSLog(@"%@", ary);
        __block LZA5RepeatTimeFlag flag = LZA5RepeatTimeFlagNon;
        [ary enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            flag |= (1 << obj.row);
        }];
        weakSelf.data.repeatFlag = flag;
        [weakSelf updateUI];
    };
    self.currentPickerType = model.setType;
    [self presentViewController:vc animated:NO completion:nil];
}

#pragma mark - getter
- (NSArray<LZBaseSetCellModel *> *)modelAry {
    if (!_modelAry) {
        LZBaseSetCellModel *model0 = [[LZBaseSetCellModel alloc] initModelWithSetType:LZADDEVENTTOREMINDTYPE_OPENR_EMIND cellStyle:DEVICESETCELLSTYLE_RIGHT_SWITCH titleStr:@"夜间模式开关" subStr:nil];
        LZBaseSetCellModel *model1 = [[LZBaseSetCellModel alloc] initModelWithSetType:LZADDEVENTTOREMINDTYPE_REMIND_EACH_TIME cellStyle:DEVICESETCELLSTYLE_RIGHT_IMG_SUBTITLE titleStr:@"频次" subStr:@"60分钟"];
        LZBaseSetCellModel *model2 = [[LZBaseSetCellModel alloc] initModelWithSetType:LZADDEVENTTOREMINDTYPE_REMIND_START_TIME cellStyle:DEVICESETCELLSTYLE_RIGHT_IMG_SUBTITLE titleStr:@"开始时间" subStr:@"15:32"];

        
        LZBaseSetCellModel *model3 = [[LZBaseSetCellModel alloc] initModelWithSetType:LZADDEVENTTOREMINDTYPE_REMIND_END_TIME cellStyle:DEVICESETCELLSTYLE_RIGHT_IMG_SUBTITLE titleStr:@"结束时间" subStr:@"00:00"];

        LZBaseSetCellModel *model4 = [[LZBaseSetCellModel alloc] initModelWithSetType:LZADDEVENTTOREMINDTYPE_REPEAT_TIME cellStyle:DEVICESETCELLSTYLE_RIGHT_IMG_SUBTITLE titleStr:@"每周重复时间" subStr:@"星期一 星期二 星期三 星期四 星期五 星期六 星期天"];
        
        LZBaseSetCellModel *model5 = [[LZBaseSetCellModel alloc] initModelWithSetType:LZADDEVENTTOREMINDTYPE_VIBRATION_MODE cellStyle:DEVICESETCELLSTYLE_RIGHT_IMG_SUBTITLE titleStr:@"震动方式" subStr:nil];
        
        LZBaseSetCellModel *model6 = [[LZBaseSetCellModel alloc] initModelWithSetType:LZADDEVENTTOREMINDTYPE_VIBRATION_LEAVE1 cellStyle:DEVICESETCELLSTYLE_RIGHT_IMG_SUBTITLE titleStr:@"震动等级1" subStr:nil];
        
        LZBaseSetCellModel *model7 = [[LZBaseSetCellModel alloc] initModelWithSetType:LZADDEVENTTOREMINDTYPE_VIBRATION_LEAVE2 cellStyle:DEVICESETCELLSTYLE_RIGHT_IMG_SUBTITLE titleStr:@"震动等级2" subStr:nil];
        
        LZBaseSetCellModel *model8 = [[LZBaseSetCellModel alloc] initModelWithSetType:LZADDEVENTTOREMINDTYPE_VIBRATION_TIME cellStyle:DEVICESETCELLSTYLE_RIGHT_IMG_SUBTITLE titleStr:@"震动时长" subStr:nil];
        _modelAry = @[model0, model1, model2, model3, model4, model5, model6, model7, model8];
    }
    return _modelAry;
}

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

- (NSArray *)eachTimeAry {
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 1; i < 240; i++) {
        [array addObject:[NSString stringWithFormat:@"%@", @(i)]];
    }
    return array;
}

@end
