//
//  LZDndModeViewController.m
//  LSBluetoothUI_iOS
//
//  Created by wm on 2020/12/8.
//

#import "LZDndModeViewController.h"
#import <Masonry/Masonry.h>
#import "LZDndModelCell.h"
#import "LZDndModelCellModel.h"
#import "LZSetPickerViewController.h"
#import "LZPickerAnimator.h"

@interface LZDndModeViewController () <UITableViewDelegate, UITableViewDataSource, LZSetPickerDelegate, LZDndModelCellModelDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,copy) NSArray <LZDndModelCellModel *> *modelAry;

@property (nonatomic, strong) LZA5SettingNoDisturbData *data;

@property (nonatomic, assign) NSInteger currentPickerType;

@end

@implementation LZDndModeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"勿扰模式";
    self.view.backgroundColor = [UIColor whiteColor];
    [self createUI];
    
    self.data = [self settingData];
    [self updateUI];
}

- (void)createUI {
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

- (void)updateUI {
    LZDndModelCellModel *model0 = self.modelAry[0];
    model0.switchIsOpne = self.data.enable;
    LZDndModelCellModel *model1 = self.modelAry[1];
    model1.switchIsOpne = self.data.isEnableRaise;
    LZDndModelCellModel *model2 = self.modelAry[2];
    model2.subStr = [NSString stringWithFormat:@"%02d:%02d", self.data.startHour, self.data.startMinute];
    LZDndModelCellModel *model3 = self.modelAry[3];
    model3.subStr = [NSString stringWithFormat:@"%02d:%02d", self.data.endHour, self.data.endMinute];
    [self.tableView reloadData];
}

#pragma mark - LZDndModelCellModelDelegate
- (void)switchOn:(BOOL)isOn cellModel:(LZDndModelCellModel *)cellModel {
    if (cellModel.setType == LZDndModelSetTypeDndSwitch) {
        self.data.enable = isOn;
    } else if (cellModel.setType == LZDndModelSetTypeRaisedhandAgainstTheLight) {
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.modelAry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LZDndModelCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LZDndModelCell class]) forIndexPath:indexPath];
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
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[LZDndModelCell class] forCellReuseIdentifier:NSStringFromClass([LZDndModelCell class])];
    }
    return _tableView;
}

- (NSArray<LZDndModelCellModel *> *)modelAry {
    if (!_modelAry) {
        _modelAry = [[NSArray alloc] init];
        _modelAry = [LZDndModelCellModel cellModelList];
    }
    return _modelAry;
}



@end
