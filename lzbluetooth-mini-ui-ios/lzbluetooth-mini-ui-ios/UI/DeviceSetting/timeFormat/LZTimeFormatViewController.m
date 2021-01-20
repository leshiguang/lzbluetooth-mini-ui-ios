//
//  LZTimeFormatViewController.m
//  LSBluetoothUI_iOS
//
//  Created by wm on 2020/12/8.
//

#import "LZTimeFormatViewController.h"
#import <Masonry/Masonry.h>

@interface LZTimeFormatViewController ()
@property (nonatomic, copy) NSArray <LZBaseSetCellModel *> *modelAry;

@property (nonatomic, strong) LZA5SettingTimeModeData *data;
@end

@implementation LZTimeFormatViewController

@dynamic data;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"时间制式";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self updateUI];
}

- (void)updateUI {
    [self.tableView reloadData];
    NSInteger index = self.data.timeMode == LZA5TimeMode24 ? 0 : 1;
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.data.timeMode = indexPath.row == 0 ? LZA5TimeMode24 : LZA5TimeMode12;
    [self sendData:self.data];
}

#pragma mark - getter
- (NSArray<LZBaseSetCellModel *> *)modelAry {
    if (!_modelAry) {
        
        NSMutableArray *mAry = [[NSMutableArray alloc] init];
        
        LZBaseSetCellModel *model1 = [[LZBaseSetCellModel alloc] initModelWithSetType:0 cellStyle:DEVICESETCELLSTYLE_RIGHT_SELECTIMAGE titleStr:@"24小时制" subStr:nil];
        [mAry addObject:model1];
        
        LZBaseSetCellModel *model2 = [[LZBaseSetCellModel alloc] initModelWithSetType:1 cellStyle:DEVICESETCELLSTYLE_RIGHT_SELECTIMAGE titleStr:@"12小时制" subStr:nil];
        [mAry addObject:model2];
        
        _modelAry = mAry;
    }
    return _modelAry;
}
@end
