//
//  LZNightModeViewController.m
//  LSBluetoothUI_iOS
//
//  Created by wm on 2020/12/8.
//

#import "LZNightModeViewController.h"
#import <Masonry/Masonry.h>

#import "LZSetPickerViewController.h"
#import "LZPickerAnimator.h"

@interface LZNightModeViewController () <LZBaseSetTableViewCellDelegate, LZSetPickerDelegate>

@property (nonatomic, copy) NSArray <LZBaseSetCellModel *> *modelAry;

@property (nonatomic, strong) LZA5SettingNightModeData *data;


@property (nonatomic, assign) NSInteger currentPickerType;

@end

@implementation LZNightModeViewController

@synthesize data;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"夜间模式";
    self.view.backgroundColor = [UIColor whiteColor];
 
    [self updateUI];
}

- (void)updateUI {
    LZBaseSetCellModel *model0 = self.modelAry[0];
    model0.switchIsOpne = self.data.enable;
    LZBaseSetCellModel *model1 = self.modelAry[1];
    model1.subStr = [NSString stringWithFormat:@"%02d:%02d", self.data.startHour, self.data.startMinute];
    LZBaseSetCellModel *model2 = self.modelAry[2];
    model2.subStr = [NSString stringWithFormat:@"%02d:%02d", self.data.endHour, self.data.endMinute];
    [self.tableView reloadData];
    
}

#pragma mark - LZNightModelCellModelDelegate
- (void)switchOn:(BOOL)isOn cellModle:(LZBaseSetCellModel *_Nonnull)cellModel {
    self.data.enable = isOn;
    
    [self sendData:self.data];
}

#pragma mark - LZSetPickerDelegate
- (void)pickerViewControllerDidSelect:(LZSetPickerViewController *)vc {
    if (self.currentPickerType == 1) {
        self.data.startHour = [vc selectedRowInComponent:0];
        self.data.startMinute = [vc selectedRowInComponent:1];
    } else if (self.currentPickerType == 2) {
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
    switch (indexPath.row) {
        case 0:
            break;
        case 1:
        case 2:
            [self showPopupViewControllerWithIndex:indexPath.row];
            break;
            
        default:
            break;
    }
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
        LZBaseSetCellModel *model1 = [[LZBaseSetCellModel alloc] initModelWithSetType:0 cellStyle:DEVICESETCELLSTYLE_RIGHT_SWITCH titleStr:@"夜间模式开关" subStr:nil];
        
        LZBaseSetCellModel *model2 = [[LZBaseSetCellModel alloc] initModelWithSetType:1 cellStyle:DEVICESETCELLSTYLE_RIGHT_IMG_SUBTITLE titleStr:@"开始时间" subStr:@"15:32"];

        
        LZBaseSetCellModel *model3 = [[LZBaseSetCellModel alloc] initModelWithSetType:2 cellStyle:DEVICESETCELLSTYLE_RIGHT_IMG_SUBTITLE titleStr:@"结束时间" subStr:@"00:00"];

        _modelAry = @[model1, model2, model3];
    }
    return _modelAry;
}

@end
