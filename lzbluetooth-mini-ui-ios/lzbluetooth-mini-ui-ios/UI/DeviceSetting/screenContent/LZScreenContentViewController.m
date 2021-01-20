//
//  LZScreenContentViewController.m
//  LSBluetoothUI_iOS
//
//  Created by wm on 2020/12/3.
//

#import "LZScreenContentViewController.h"
#import <Masonry/Masonry.h>

/// membo hr 2 不支持 最多支持 11个显示屏幕
/// LZA5UIPageTypeMountainClimbing
/// LZA5UIPageTypeDailyData
/// LZA5UIPageTypeAerobicWorkout
/// LZA5UIPageTypeESport

@interface LZScreenContentViewController ()

@property (nonatomic, strong) NSArray <NSNumber *> *allScreenTypes;

@property (nonatomic, strong) LZA5SettingCustomScreenData *data;

@end

@implementation LZScreenContentViewController

@dynamic data;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"自定义屏幕";
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.allowsMultipleSelection = YES;
    self.tableView.allowsSelectionDuringEditing = YES;
    self.tableView.allowsMultipleSelectionDuringEditing = YES;
    [self.tableView setEditing:YES animated:YES];
    
    [self.dataSource addObject:[NSMutableArray array]];
    [self.dataSource addObject:[NSMutableArray array]];
    
    [self updateUI];
}

- (void)updateUI {
    NSMutableArray *selected = self.dataSource[0];
    NSMutableArray *unselected = self.dataSource[1];
    [selected removeAllObjects];
    [unselected removeAllObjects];
    
    if (self.data.listPage) {
        [selected addObjectsFromArray:self.data.listPage];
    }
    [self.allScreenTypes enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (![self.data.listPage containsObject:obj]) {
            [unselected addObject:obj];
        }
    }];
    
    [self.tableView reloadData];
    
    [selected enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:idx inSection:0];
        [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }];
}

#pragma mark - UITableViewDelegate
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleNone;
}

- (BOOL)tableView:(UITableView *)tableview shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray<NSIndexPath *> *selectedIndexPaths = [tableView indexPathsForSelectedRows];
    if ([selectedIndexPaths containsObject:indexPath]) return YES;
    else return NO;
}

- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath {
    if (proposedDestinationIndexPath.section == 0 && sourceIndexPath.section == 0) return proposedDestinationIndexPath;
    else return sourceIndexPath;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    NSAssert(sourceIndexPath.section == destinationIndexPath.section && destinationIndexPath.section == 0, @"只有选中的才可以reorder");
    NSMutableArray *selected = self.dataSource[0];
    [selected exchangeObjectAtIndex:sourceIndexPath.row withObjectAtIndex:destinationIndexPath.row];
    
    [self updateCellSelect];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) return;
    
    NSNumber *screenType = self.dataSource[indexPath.section][indexPath.row];
    NSMutableArray *selected = self.dataSource[0];
    NSMutableArray *unselected = self.dataSource[1];
    
    [selected addObject:screenType];
    [unselected removeObjectAtIndex:indexPath.row];
    [tableView beginUpdates];
    NSIndexPath *toIndexPath = [NSIndexPath indexPathForRow:selected.count - 1 inSection:0];
    [tableView moveRowAtIndexPath:indexPath toIndexPath:toIndexPath];
    [tableView endUpdates];
    
    [self updateCellSelect];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) return;
    
    NSNumber *screenType = self.dataSource[indexPath.section][indexPath.row];
    NSMutableArray *selected = self.dataSource[0];
    NSMutableArray *unselected = self.dataSource[1];
    [selected removeObjectAtIndex:indexPath.row];
    [unselected addObject:screenType];
    [unselected sortUsingComparator:^NSComparisonResult(NSNumber *  _Nonnull obj1, NSNumber * _Nonnull obj2) {
        return [obj1 compare:obj2];;
    }];
    
    NSInteger index = [unselected indexOfObject:screenType];
    NSIndexPath *toIndexPath = [NSIndexPath indexPathForRow:index inSection:1];
    [tableView beginUpdates];
    [tableView moveRowAtIndexPath:indexPath toIndexPath:toIndexPath];
    [tableView endUpdates];
    
    [self updateCellSelect];
}


#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LZBaseSetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(LZBaseSetTableViewCell.class) forIndexPath:indexPath];
    NSNumber *pageTypeNum = self.dataSource[indexPath.section][indexPath.row];
    cell.rightSelectImageView.hidden = NO;
    cell.titleLabel.text = [self nameWithScreenType:pageTypeNum.integerValue];
    cell.editingAccessoryView = [UIView new];
    return cell;
}

#pragma mark - private Methods
- (void)updateCellSelect {
    NSMutableArray *array = self.dataSource[0];
    self.data.listPage = array.copy;
    [self sendData:self.data];
}

#pragma mark - getter
- (NSArray<NSNumber *> *)allScreenTypes {
    if (!_allScreenTypes) {
        _allScreenTypes = @[
            @(LZA5UIPageTypeTime),
            @(LZA5UIPageTypeCalorise),
            @(LZA5UIPageTypeStep),
            @(LZA5UIPageTypeDistance),
            @(LZA5UIPageTypeHr),
            @(LZA5UIPageTypeRun),
            @(LZA5UIPageTypeWalk),
            @(LZA5UIPageTypeCycling),
            @(LZA5UIPageTypeSwimming),
            @(LZA5UIPageTypeKeepfit),
            @(LZA5UIPageTypeMountainClimbing),
            @(LZA5UIPageTypeDailyData),
            @(LZA5UIPageTypeStopwatch),
            @(LZA5UIPageTypeWeather),
            @(LZA5UIPageTypeBattery),
            @(LZA5UIPageTypeIndoorRun),
            @(LZA5UIPageTypeElliptical),
            @(LZA5UIPageTypeAerobicWorkout),
            @(LZA5UIPageTypeBasketball),
            @(LZA5UIPageTypeFootball),
            @(LZA5UIPageTypeBadminton),
            @(LZA5UIPageTypeVolleyball),
            @(LZA5UIPageTypeTableTennis),
            @(LZA5UIPageTypeYoga),
            @(LZA5UIPageTypeESport),
            @(LZA5UIPageType12MinutesRunMode),
            @(LZA5UIPageType6MinutesRunMode),
            @(LZA5UIPageTypeAliPayMode),
            @(LZA5UIPageTypeGymDance),
            @(LZA5UIPageTypeTaiji)
        ];
    }
    return _allScreenTypes;
}

- (NSString *)nameWithScreenType:(LZA5UIPageType)screenType {
    switch (screenType) {
        case LZA5UIPageTypeTime:
            return @"时间";
        case LZA5UIPageTypeCalorise:
            return @"卡路里";
        case LZA5UIPageTypeStep:
            return @"步数";
        case LZA5UIPageTypeDistance:
            return @"路程";
        case LZA5UIPageTypeHr:
            return @"心率";
        case LZA5UIPageTypeRun:
            return @"跑步";
            
        case LZA5UIPageTypeWalk:
            return @"行走";
        case LZA5UIPageTypeCycling:
            return @"骑行";
        case LZA5UIPageTypeSwimming:
            return @"游泳";
        case LZA5UIPageTypeKeepfit:
            return @"力量训练/健身";
        case LZA5UIPageTypeMountainClimbing:
            return @"登山";
        case LZA5UIPageTypeDailyData:
            return @"日常数据";
        case LZA5UIPageTypeStopwatch:
            return @"秒表";
        case LZA5UIPageTypeWeather:
            return @"天气";
        case LZA5UIPageTypeBattery:
            return @"电量";
        case LZA5UIPageTypeIndoorRun:
            return @"跑步机/室内跑";
        case LZA5UIPageTypeElliptical:
            return @"椭圆机";
            
        case LZA5UIPageTypeAerobicWorkout:
            return @"有氧运动";
        case LZA5UIPageTypeBasketball:
            return @"篮球";
        case LZA5UIPageTypeFootball:
            return @"足球";
        case LZA5UIPageTypeBadminton:
            return @"羽毛球";
            
        case LZA5UIPageTypeVolleyball:
            return @"排球";
        case LZA5UIPageTypeTableTennis:
            return @"乒乓球";
        case LZA5UIPageTypeYoga:
            return @"瑜伽";
        case LZA5UIPageTypeESport:
            return @"电竞";
        
        case LZA5UIPageType12MinutesRunMode:
            return @"12分钟跑";
        case LZA5UIPageType6MinutesRunMode:
            return @"6分钟跑";
        case LZA5UIPageTypeAliPayMode:
            return @"支付宝";
        case LZA5UIPageTypeGymDance:
            return @"健身舞";
        case LZA5UIPageTypeTaiji:
            return @"太极";
        
        default:
            break;
    }
}

@end
