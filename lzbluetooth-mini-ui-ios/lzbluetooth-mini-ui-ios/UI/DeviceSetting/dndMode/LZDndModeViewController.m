//
//  LZDndModeViewController.m
//  LSBluetoothUI_iOS
//
//  Created by wm on 2020/12/8.
//

#import "LZDndModeViewController.h"
#import <Masonry/Masonry.h>
#import "LZSetPickerViewController.h"
#import "LZPickerAnimator.h"

@interface LZDndModeViewController () <LZSetPickerDelegate, LZBaseSetTableViewCellDelegate>

@property (nonatomic,copy) NSArray <LZBaseSetCellModel *> *modelAry;

@property (nonatomic, strong) LZA5SettingNoDisturbData *data;

@property (nonatomic, assign) NSInteger currentPickerType;

@end

@implementation LZDndModeViewController

@synthesize data;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"勿扰模式";
    self.view.backgroundColor = [UIColor whiteColor];
    [self updateUI];
}


- (void)updateUI {
    LZBaseSetCellModel *model0 = self.modelAry[0];
    model0.switchIsOpne = self.data.enable;
    LZBaseSetCellModel *model1 = self.modelAry[1];
    model1.switchIsOpne = self.data.isEnableRaise;
    LZBaseSetCellModel *model2 = self.modelAry[2];
    model2.subStr = [NSString stringWithFormat:@"%02d:%02d", self.data.startHour, self.data.startMinute];
    LZBaseSetCellModel *model3 = self.modelAry[3];
    model3.subStr = [NSString stringWithFormat:@"%02d:%02d", self.data.endHour, self.data.endMinute];
    [self.tableView reloadData];
}

#pragma mark - LZBaseSetTableViewCellDelegate
- (void)switchOn:(BOOL)isOn cellModle:(LZBaseSetCellModel *)cellModel {
    if (cellModel.setType == 0) {
        self.data.enable = isOn;
    } else if (cellModel.setType == 1) {
        self.data.isEnableRaise = isOn;
    }
    [self sendData:self.data];
}

#pragma mark - LZSetPickerDelegate
- (void)pickerViewControllerDidSelect:(LZSetPickerViewController *)vc {
    if (self.currentPickerType == 2) {
        self.data.startHour = [vc selectedRowInComponent:0];
        self.data.startMinute = [vc selectedRowInComponent:1];
    } else if (self.currentPickerType == 3) {
        self.data.endHour = [vc selectedRowInComponent:0];
        self.data.endMinute = [vc selectedRowInComponent:1];
    }
    
    [self updateUI];
    
    [vc dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row >= 2) {
        [self showPopupViewControllerWithIndex:indexPath.row];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.modelAry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LZBaseSetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LZBaseSetTableViewCell class]) forIndexPath:indexPath];
    [cell updateCellWithModel:self.modelAry[indexPath.row]];
    cell.delegate = self;
    return cell;
}

#pragma mark - Private
- (void)showPopupViewControllerWithIndex:(NSInteger)index {
    LZSetPickerViewController *vc = [[LZSetPickerViewController alloc] init];
    vc.modalPresentationStyle = UIModalPresentationCustom;
    LZPickerAnimator *pickerAnimotor = [[LZPickerAnimator alloc] initWithPresentedViewController:self presentingViewController:vc];
    vc.transitioningDelegate = pickerAnimotor;
    vc.delegate = self;
    self.currentPickerType = index;
    vc.dataSoureAry = @[self.hours, self.minutes];
    [self presentViewController:vc animated:YES completion:^{

    }];
}

#pragma mark - getter
- (NSArray<LZBaseSetCellModel *> *)modelAry {
    if (!_modelAry) {
        NSMutableArray *array = [NSMutableArray array];
        
        LZBaseSetCellModel *model1 = [[LZBaseSetCellModel alloc] initModelWithSetType:0 cellStyle:DEVICESETCELLSTYLE_RIGHT_SWITCH titleStr:@"勿扰模式开关" subStr:nil];
        [array addObject:model1];
        
        LZBaseSetCellModel *model2 = [[LZBaseSetCellModel alloc] initModelWithSetType:1 cellStyle:DEVICESETCELLSTYLE_RIGHT_SWITCH titleStr:@"是否允许抬手亮屏" subStr:nil];
        [array addObject:model2];
        
        LZBaseSetCellModel *model3 = [[LZBaseSetCellModel alloc] initModelWithSetType:2 cellStyle:DEVICESETCELLSTYLE_RIGHT_SUBTITLE titleStr:@"开始时间" subStr:nil];
        [array addObject:model3];
        
        LZBaseSetCellModel *model4 = [[LZBaseSetCellModel alloc] initModelWithSetType:3 cellStyle:DEVICESETCELLSTYLE_RIGHT_SUBTITLE titleStr:@"结束时间" subStr:nil];
        [array addObject:model4];
        _modelAry = array;
    }
    return _modelAry;
}

@end
