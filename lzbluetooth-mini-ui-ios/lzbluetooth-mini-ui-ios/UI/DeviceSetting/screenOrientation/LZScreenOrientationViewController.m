//
//  LZScreenOrientationViewController.m
//  LSBluetoothUI_iOS
//
//  Created by wm on 2020/12/8.
//

#import "LZScreenOrientationViewController.h"
#import <Masonry/Masonry.h>

@interface LZScreenOrientationViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray <LZBaseSetCellModel *> *modelAry;
@property (nonatomic, strong) LZA5SettingScreenDirectionData *data;

@end

@implementation LZScreenOrientationViewController

@dynamic data;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"屏幕方向";
    self.view.backgroundColor = [UIColor whiteColor];
    [self updateUI];
}

- (void)updateUI {
    [self.tableView reloadData];
    NSInteger index = self.data.screenDirection == LZA5ScreenDirectionH ? 0 : 1;
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.data.screenDirection = indexPath.row == 0 ? LZA5ScreenDirectionH : LZA5ScreenDirectionV;
    
    [self sendData:self.data];
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

#pragma mark - getter
- (NSArray<LZBaseSetCellModel *> *)modelAry {
    if (!_modelAry) {
        NSMutableArray *mAry = [[NSMutableArray alloc] init];
        LZBaseSetCellModel *model1 = [[LZBaseSetCellModel alloc] initModelWithSetType:0 cellStyle:DEVICESETCELLSTYLE_RIGHT_SELECTIMAGE titleStr:@"水平" subStr:nil];
        [mAry addObject:model1];
        
        LZBaseSetCellModel *model2 = [[LZBaseSetCellModel alloc] initModelWithSetType:1 cellStyle:DEVICESETCELLSTYLE_RIGHT_SELECTIMAGE titleStr:@"垂直" subStr:nil];
        [mAry addObject:model2];
        _modelAry = mAry;
    }
    return _modelAry;
}
@end
