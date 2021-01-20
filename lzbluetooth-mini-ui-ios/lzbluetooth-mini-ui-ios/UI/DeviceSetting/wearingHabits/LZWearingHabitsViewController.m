//
//  LZWearingHabitsViewController.m
//  LSBluetoothUI_iOS
//
//  Created by wm on 2020/12/8.
//

#import "LZWearingHabitsViewController.h"
#import <Masonry/Masonry.h>

@interface LZWearingHabitsViewController ()
@property (nonatomic, copy) NSArray <LZBaseSetCellModel *> * modelAry;

@property (nonatomic, strong) LZA5SettingWristHabitData *data;
@end

@implementation LZWearingHabitsViewController

@synthesize data;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"佩戴习惯";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self updateUI];
}

- (void)updateUI {
    NSInteger index = self.data.displayMode == LZA5DisplayModeLeft ? 0 : 1;
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
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

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.data.displayMode = indexPath.row == 0 ? LZA5DisplayModeLeft : LZA5DisplayModeRight;
    
    [self sendData:self.data];
}

#pragma mark - getter
- (NSArray<LZBaseSetCellModel *> *)modelAry {
    if (!_modelAry) {
        NSMutableArray *mAry = [[NSMutableArray alloc] init];
        LZBaseSetCellModel *model1 = [[LZBaseSetCellModel alloc] initModelWithSetType:0 cellStyle:DEVICESETCELLSTYLE_RIGHT_SELECTIMAGE titleStr:@"左手佩戴" subStr:nil];
        [mAry addObject:model1];
        
        LZBaseSetCellModel *model2 = [[LZBaseSetCellModel alloc] initModelWithSetType:1 cellStyle:DEVICESETCELLSTYLE_RIGHT_SELECTIMAGE titleStr:@"右手佩戴" subStr:nil];
        [mAry addObject:model2];
        _modelAry = mAry;
    }
    return _modelAry;
}

@end
