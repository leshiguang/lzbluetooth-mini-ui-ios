//
//  LZGoalSetViewController.m
//  LSBluetoothUI_iOS
//
//  Created by wm on 2020/12/8.
//

#import "LZGoalSetViewController.h"
#import <Masonry/Masonry.h>
#import "LZGoalSettingTableViewCell.h"
#import "LZGoalSetModel.h"
#import "LZSetPickerViewController.h"
#import "LZPickerAnimator.h"
#import "UIViewController+MBProgressHUD.h"

@interface LZGoalSetViewController () <UITableViewDelegate, UITableViewDataSource, LZSetPickerDelegate, LZGoalSettingTableViewCellDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray <LZGoalSetModel *> *modelAry;
@property (nonatomic, strong) LZPickerAnimator *pickerAnimotor;

@property (nonatomic, copy) NSArray *goalTypeAry;
@property (nonatomic, copy) NSArray *goalNumAry;

@property (nonatomic, assign,) LZGOALSETTYPE currentPickerType;
@property (nonatomic, strong) LZA5SettingEncourageTargetData *targetCfg;

@end

@implementation LZGoalSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"目标设置";
    self.view.backgroundColor = [UIColor whiteColor];
    [self createUI];
    [self initSetData];
    
}

- (void)createUI {
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

- (void)initSetData {
    
    NSMutableArray *mAry = [self.modelAry mutableCopy];
    LZGoalSetModel *model1 = mAry[0];
    model1.switchIsOpne = self.targetCfg.enable;
    
    LZGoalSetModel *model2 = mAry[1];
    model2.subStr = self.goalTypeAry[(int)self.targetCfg.targetType - 1];
    
    LZGoalSetModel *model3 = mAry[2];
    model3.subStr = [@(self.targetCfg.value) stringValue];
    
    self.modelAry = [mAry copy];
    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.modelAry[indexPath.row].setType != LZGOALSETTYPE_GOALSWITCH) {
        [self selectCellWihtModel:self.modelAry[indexPath.row]];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.modelAry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LZGoalSettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LZGoalSettingTableViewCell class]) forIndexPath:indexPath];
    if (!cell) {
        cell = [[LZGoalSettingTableViewCell alloc] init];
    }
    cell.delegate = self;
    [cell updateCellWithModel:self.modelAry[indexPath.row]];
    return cell;
}

#pragma mark - LZGoalSettingTableViewCellDelegate
- (void)switchOn:(BOOL)isOn cellModle:(LZGoalSetModel *)cellModel {
    if (cellModel.setType == LZGOALSETTYPE_GOALSWITCH) {
        self.targetCfg.enable = isOn;
        [self setGoalWihtCfg];
    }
}

#pragma mark - private Methods
- (void)selectCellWihtModel:(LZBaseSetCellModel *)model {
    LZSetPickerViewController *vc = [[LZSetPickerViewController alloc] init];
    vc.modalPresentationStyle = UIModalPresentationCustom;
    self.pickerAnimotor = [[LZPickerAnimator alloc] initWithPresentedViewController:self presentingViewController:vc];
    vc.transitioningDelegate = self.pickerAnimotor;
    vc.delegate = self;
    switch (model.setType) {
        case LZGOALSETTYPE_GOALTYPE: {
            self.currentPickerType = LZGOALSETTYPE_GOALTYPE;
            vc.dataSoureAry = @[self.goalTypeAry];
        }
            break;
        case LZGOALSETTYPE_GOALTNUM: {
            self.currentPickerType = LZGOALSETTYPE_GOALTNUM;
            vc.dataSoureAry = @[self.goalNumAry];
        }
            break;
        default:
            break;
    }
    
    [self presentViewController:vc animated:YES completion:^{
            
    }];
}

#pragma mark - LZSetPickerDelegate
- (void)pickerEnd:(NSArray *)selectAry isSure:(BOOL)isSure {
    [self dismissViewControllerAnimated:YES completion:nil];
    if (!isSure || selectAry.count != 1) {
        return;
    }
    switch (self.currentPickerType) {
        case LZGOALSETTYPE_GOALTYPE:{
            NSInteger index = [self.goalTypeAry indexOfObject:selectAry[0]];
            if (index != NSNotFound) {
                self.targetCfg.targetType = index + 1;
                [self initSetData];
            }
            break;
        }
            
        case LZGOALSETTYPE_GOALTNUM:{
            self.targetCfg.value = [selectAry[0] intValue];
            [self initSetData];
            break;
        }
            
        default:
            break;
    }
    
    
}

#pragma mark - Private Methods
- (void)setGoalWihtCfg {
    [self sendData:self.targetCfg];
}


#pragma mark - getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[LZGoalSettingTableViewCell class] forCellReuseIdentifier:NSStringFromClass([LZGoalSettingTableViewCell class])];
    }
    return _tableView;
}

- (NSArray<LZGoalSetModel *> *)modelAry {
    if (!_modelAry) {
        _modelAry = [[NSArray alloc] init];
        _modelAry = [LZGoalSetModel cellModelList];
    }
    return _modelAry;
}

- (NSArray *)goalTypeAry {
    if (!_goalTypeAry) {
        _goalTypeAry = @[@"步数",@"卡路里",@"距离"];
    }
    return _goalTypeAry;
}

- (NSArray *)goalNumAry {
    if (!_goalNumAry) {
        NSMutableArray *mAry = [[NSMutableArray alloc] init];
        for (int i = 1; i <= 3000; i++) {
            [mAry addObject:[NSString stringWithFormat:@"%@%d",i<10?@"0":@"",i]];
        }
        _goalNumAry = [mAry copy];
    }
    return _goalNumAry;
}

- (LZA5SettingEncourageTargetData *)targetCfg {
    if (!_targetCfg) {
        LZA5SettingEncourageTargetData *cfg = [[LZA5SettingEncourageTargetData alloc] init];
        cfg.targetType = LZA5TargetTypeStep;
        cfg.enable = NO;
        cfg.value = 2000;
        _targetCfg = cfg;
    }
    return _targetCfg;
}

@end
