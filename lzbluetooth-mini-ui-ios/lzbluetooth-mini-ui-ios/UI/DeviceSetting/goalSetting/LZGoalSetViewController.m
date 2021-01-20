//
//  LZGoalSetViewController.m
//  LSBluetoothUI_iOS
//
//  Created by wm on 2020/12/8.
//

#import "LZGoalSetViewController.h"
#import <Masonry/Masonry.h>

#import "LZSetPickerViewController.h"
#import "LZPickerAnimator.h"

typedef enum : NSUInteger {
    LZGOALSETTYPE_GOALSWITCH,   //目标开关
    LZGOALSETTYPE_GOALTYPE,     //目标类型
    LZGOALSETTYPE_GOALTNUM,     //目标值
} LZGOALSETTYPE;

@interface LZGoalSetViewController () <UITableViewDelegate, UITableViewDataSource, LZSetPickerDelegate, LZBaseSetTableViewCellDelegate>
@property (nonatomic, strong) NSArray <LZBaseSetCellModel *> *modelAry;
@property (nonatomic, strong) LZPickerAnimator *pickerAnimotor;

@property (nonatomic, copy) NSArray *goalTypeAry;
@property (nonatomic, copy) NSArray *goalNumAry;

@property (nonatomic, assign,) LZGOALSETTYPE currentPickerType;
@property (nonatomic, strong) LZA5SettingEncourageTargetData *data;

@end

@implementation LZGoalSetViewController
@synthesize data;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"目标设置";
    self.view.backgroundColor = [UIColor whiteColor];

    [self updateUI];
}

- (void)updateUI {
    
    NSMutableArray *mAry = [self.modelAry mutableCopy];
    LZBaseSetCellModel *model1 = mAry[0];
    model1.switchIsOpne = self.data.enable;
    
    LZBaseSetCellModel *model2 = mAry[1];
    NSInteger index = MAX(0, self.data.targetType - 1) ;
    model2.subStr = self.goalTypeAry[index];
    
    LZBaseSetCellModel *model3 = mAry[2];
    model3.subStr = [@(self.data.value) stringValue];
    
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
    LZBaseSetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LZBaseSetTableViewCell class]) forIndexPath:indexPath];
    cell.delegate = self;
    [cell updateCellWithModel:self.modelAry[indexPath.row]];
    return cell;
}

#pragma mark - LZGoalSettingTableViewCellDelegate
- (void)switchOn:(BOOL)isOn cellModle:(LZBaseSetCellModel *)cellModel {
    if (cellModel.setType == LZGOALSETTYPE_GOALSWITCH) {
        self.data.enable = isOn;
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
- (void)pickerViewControllerDidSelect:(LZSetPickerViewController *)vc {
    NSInteger row = [vc selectedRowInComponent:0];
    switch (self.currentPickerType) {
        case LZGOALSETTYPE_GOALTYPE:{
            self.data.targetType = row + 1;
            break;
        }
            
        case LZGOALSETTYPE_GOALTNUM:{
            self.data.value = row + 1;
            break;
        }
            
        default:
            break;
    }
    
    [self updateUI];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Private Methods
- (void)setGoalWihtCfg {
    [self sendData:self.data];
}


#pragma mark - getter

- (NSArray<LZBaseSetCellModel *> *)modelAry {
    if (!_modelAry) {
        NSMutableArray <LZBaseSetCellModel *> *mAry = [[NSMutableArray alloc] init];
        LZBaseSetCellModel *model1 = [[LZBaseSetCellModel alloc] initModelWithSetType:LZGOALSETTYPE_GOALSWITCH cellStyle:DEVICESETCELLSTYLE_RIGHT_SWITCH titleStr:@"目标开关" subStr:nil];
        [mAry addObject:model1];
        
        LZBaseSetCellModel *model2 = [[LZBaseSetCellModel alloc] initModelWithSetType:LZGOALSETTYPE_GOALTYPE cellStyle:DEVICESETCELLSTYLE_RIGHT_IMG_SUBTITLE titleStr:@"目标类型" subStr:@"卡路里"];
        [mAry addObject:model2];
        
        LZBaseSetCellModel *model3 = [[LZBaseSetCellModel alloc] initModelWithSetType:LZGOALSETTYPE_GOALTNUM cellStyle:DEVICESETCELLSTYLE_RIGHT_IMG_SUBTITLE titleStr:@"目标值" subStr:@"31.0"];
        [mAry addObject:model3];
        _modelAry = mAry;
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

@end
