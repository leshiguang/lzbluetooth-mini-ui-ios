//
//  LZNightModeViewController.m
//  LSBluetoothUI_iOS
//
//  Created by wm on 2020/12/8.
//

#import "LZNightModeViewController.h"
#import <Masonry/Masonry.h>
#import "LZNightModelCell.h"
#import "LZNightModelCellModel.h"
#import "LZSetPickerViewController.h"
#import "LZPickerAnimator.h"

@interface LZNightModeViewController () <UITableViewDelegate, UITableViewDataSource, LZNightModelCellModelDelegate, LZSetPickerDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic, copy) NSArray <LZNightModelCellModel *> *modelAry;

@property (nonatomic, strong) LZA5SettingNightModeData *data;
@property (nonatomic, strong) NSArray <NSString *> *hours;
@property (nonatomic, strong) NSArray <NSString *> *minutes;

@property (nonatomic, assign) NSInteger currentPickerType;

@end

@implementation LZNightModeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"夜间模式";
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
    LZNightModelCellModel *model0 = self.modelAry[0];
    model0.switchIsOpne = self.data.enable;
    LZNightModelCellModel *model1 = self.modelAry[1];
    model1.subStr = [NSString stringWithFormat:@"%02d:%02d", self.data.startHour, self.data.startMinute];
    LZNightModelCellModel *model2 = self.modelAry[2];
    model2.subStr = [NSString stringWithFormat:@"%02d:%02d", self.data.endHour, self.data.endMinute];
    [self.tableView reloadData];
    
}

#pragma mark - LZNightModelCellModelDelegate
- (void)switchOn:(BOOL)isOn cellModle:(LZNightModelCellModel *_Nonnull)cellModel {
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
    LZNightModelCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LZNightModelCell class]) forIndexPath:indexPath];
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
        [_tableView registerClass:[LZNightModelCell class] forCellReuseIdentifier:NSStringFromClass([LZNightModelCell class])];
    }
    return _tableView;
}

- (NSArray<LZNightModelCellModel *> *)modelAry {
    if (!_modelAry) {
        _modelAry = [[NSArray alloc] init];
        _modelAry = [LZNightModelCellModel cellModelList];
    }
    return _modelAry;
}

- (NSArray<NSString *> *)hours {
    if (!_hours) {
        NSMutableArray *array = [NSMutableArray array];
        for (int i = 0; i < 24; i++) {
            [array addObject:[NSString stringWithFormat:@"%d", i]];
        }
        _hours = array;
    }
    return _hours;
}

- (NSArray<NSString *> *)minutes {
    if (!_minutes) {
        NSMutableArray *array = [NSMutableArray array];
        for (int i = 0; i < 60; i++) {
            [array addObject:[NSString stringWithFormat:@"%d", i]];
        }
        _minutes = array;
    }
    return _minutes;
}


@end
