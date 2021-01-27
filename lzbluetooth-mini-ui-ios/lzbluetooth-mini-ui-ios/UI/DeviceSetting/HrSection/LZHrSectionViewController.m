//
//  LZHrSectionViewController.m
//  lzbluetooth-mini-ui-ios
//
//  Created by tanjian on 2021/1/27.
//

#import "LZHrSectionViewController.h"
#import <Masonry/Masonry.h>
#import "LZPickerAnimator.h"
#import "LZSetPickerViewController.h"

static int minHr = 20;
static int maxHr = 300;

@interface LZHrSectionViewController () <LZSetPickerDelegate>

@property (nonatomic, copy) NSArray <LZBaseSetCellModel *> *modelAry;
@property (nonatomic, copy) NSArray *hearRateValueAry;

@property (nonatomic, strong) LZA5SettingHRSectionData *data;

@property (nonatomic, assign) NSInteger selectIndex;

@end

@implementation LZHrSectionViewController

@dynamic data;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"心率区间";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonClicked:)];
    self.navigationItem.rightBarButtonItem = item;
    [self updateUI];
}

- (void)updateUI {
    LZBaseSetCellModel *model1 = self.modelAry[0];
    model1.subStr = [NSString stringWithFormat:@"%d", self.data.age];
    LZBaseSetCellModel *model2 = self.modelAry[1];
    model2.subStr = [NSString stringWithFormat:@"%@~%@", @(self.data.section1Min), @(self.data.section1Max)];
    LZBaseSetCellModel *model3 = self.modelAry[2];
    model3.subStr = [NSString stringWithFormat:@"%@~%@", @(self.data.section2Min), @(self.data.section2Max)];
    LZBaseSetCellModel *model4 = self.modelAry[3];
    model4.subStr = [NSString stringWithFormat:@"%@~%@", @(self.data.section3Min), @(self.data.section3Max)];
   
    [self.tableView reloadData];
}

- (void)rightBarButtonClicked:(id)sender {
    [self sendData:self.data];
}

- (void)pickerViewControllerDidSelect:(LZSetPickerViewController *)vc {
    switch (self.selectIndex) {
        case 0:
            self.data.age = [vc selectedRowInComponent:0] + 10;
            break;
        case 1:
            self.data.section1Min = [vc selectedRowInComponent:0] + minHr;
            self.data.section1Max = [vc selectedRowInComponent:1] + minHr;
            break;
        case 2:
            self.data.section2Min = [vc selectedRowInComponent:0] + minHr;
            self.data.section2Max = [vc selectedRowInComponent:1] + minHr;
            break;
        case 3:
            self.data.section3Min = [vc selectedRowInComponent:0] + minHr;
            self.data.section3Max = [vc selectedRowInComponent:1] + minHr;
            break;
        default:
            break;
    }
    
    [vc dismissViewControllerAnimated:YES completion:^{
            
    }];
    [self updateUI];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.modelAry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LZBaseSetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LZBaseSetTableViewCell class]) forIndexPath:indexPath];
    [cell updateCellWithModel:self.modelAry[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self handleCellClickWithModel:self.modelAry[indexPath.row]];
}

#pragma mark - Private
- (void)handleCellClickWithModel:(LZBaseSetCellModel *)model {
    self.selectIndex = model.setType;
    if (model.setType == 0) {
        LZSetPickerViewController *vc = [[LZSetPickerViewController alloc] init];
        vc.modalPresentationStyle = UIModalPresentationCustom;
        LZPickerAnimator *pickerAnimotor = [[LZPickerAnimator alloc] initWithPresentedViewController:self presentingViewController:vc];
        vc.transitioningDelegate = pickerAnimotor;
        vc.delegate = self;
        vc.dataSoureAry = @[[self ageValueArray]];
        [self presentViewController:vc animated:YES completion:nil];
    } else {
        
        LZSetPickerViewController *vc = [[LZSetPickerViewController alloc] init];
        vc.modalPresentationStyle = UIModalPresentationCustom;
        LZPickerAnimator *pickerAnimotor = [[LZPickerAnimator alloc] initWithPresentedViewController:self presentingViewController:vc];
        vc.transitioningDelegate = pickerAnimotor;
        vc.delegate = self;
        vc.dataSoureAry = @[self.hearRateValueAry, self.hearRateValueAry];
        [self presentViewController:vc animated:YES completion:nil];
    }
}

- (NSArray<LZBaseSetCellModel *> *)modelAry {
    if (!_modelAry) {
        NSMutableArray *mAry = [[NSMutableArray alloc] init];
        LZBaseSetCellModel *model1 = [[LZBaseSetCellModel alloc] initModelWithSetType:0 cellStyle:DEVICESETCELLSTYLE_RIGHT_SUBTITLE titleStr:@"年龄" subStr:nil];
        [mAry addObject:model1];
        
        LZBaseSetCellModel *model2 = [[LZBaseSetCellModel alloc] initModelWithSetType:1 cellStyle:DEVICESETCELLSTYLE_RIGHT_IMG_SUBTITLE titleStr:@"心率区间1" subStr:@"20~30"];
        LZBaseSetCellModel *model3 = [[LZBaseSetCellModel alloc] initModelWithSetType:2 cellStyle:DEVICESETCELLSTYLE_RIGHT_IMG_SUBTITLE titleStr:@"心率区间2" subStr:@"20~30"];
        LZBaseSetCellModel *model4 = [[LZBaseSetCellModel alloc] initModelWithSetType:3 cellStyle:DEVICESETCELLSTYLE_RIGHT_IMG_SUBTITLE titleStr:@"心率区间3" subStr:@"20~30"];
        
        [mAry addObject:model2];
        [mAry addObject:model3];
        [mAry addObject:model4];
        
        _modelAry = mAry;
    }
    return _modelAry;
}

- (NSArray *)hearRateValueAry {
    if (!_hearRateValueAry) {
        _hearRateValueAry = [[NSArray alloc] init];
        NSMutableArray *mAry = [[NSMutableArray alloc] init];
        for (int i = minHr; i <= maxHr; i++) {
            [mAry addObject:[NSString stringWithFormat:@"%02d", i]];
        }
        _hearRateValueAry = [mAry copy];
    }
    return _hearRateValueAry;
}

- (NSArray *)ageValueArray {
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 10; i < 100; i++) {
        [array addObject:[NSString stringWithFormat:@"%02d", i]];
    }
    return array.copy;
}

@end
