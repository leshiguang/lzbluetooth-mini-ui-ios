//
//  LZScreenContentViewController.m
//  LSBluetoothUI_iOS
//
//  Created by wm on 2020/12/3.
//

#import "LZScreenContentViewController.h"
#import <Masonry/Masonry.h>
#import "LZScreenContentCell.h"
#import "LZScreenContentModel.h"

/// membo hr 2 不支持
/// LZA5UIPageTypeMountainClimbing
/// LZA5UIPageTypeDailyData
/// LZA5UIPageTypeAerobicWorkout
/// LZA5UIPageTypeESport

@interface LZScreenContentViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray <LZScreenContentModel *> *modelAry;

@property (nonatomic, strong) NSMutableArray <NSMutableArray <NSNumber *> *> *screenTypes;

@property (nonatomic, strong) NSArray <NSNumber *> *allScreenTypes;

@property (nonatomic, strong) LZA5SettingCustomScreenData *data;

@end

@implementation LZScreenContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"自定义屏幕";
    self.view.backgroundColor = [UIColor whiteColor];
    [self createUI];
    
    NSSet *set = [NSSet setWithArray:self.allScreenTypes];
    NSLog(@"set count %@", @(set.count));
    
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
    
    NSMutableArray *selected = self.screenTypes[0];
    NSMutableArray *unselected = self.screenTypes[1];
    [selected removeAllObjects];
    [unselected removeAllObjects];
    
    [self.allScreenTypes enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([self.data.listPage containsObject:obj]) {
            [selected addObject:obj];
        } else {
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
    NSMutableArray *selected = self.screenTypes[0];
    [selected exchangeObjectAtIndex:sourceIndexPath.row withObjectAtIndex:destinationIndexPath.row];
    
    [self updateCellSelect];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) return;
    
    NSNumber *screenType = self.screenTypes[indexPath.section][indexPath.row];
    
    NSMutableArray *selected = self.screenTypes[0];
    NSMutableArray *unselected = self.screenTypes[1];
    
    [selected addObject:screenType];
    [unselected removeObjectAtIndex:indexPath.row];
    [tableView beginUpdates];
    NSIndexPath *toIndexPath = [NSIndexPath indexPathForRow:selected.count - 1 inSection:0];
    NSLog(@"select %@ to %@ select %@ unselect %@", indexPath, toIndexPath, @(selected.count), @(unselected.count));
    [tableView moveRowAtIndexPath:indexPath toIndexPath:toIndexPath];
    [tableView endUpdates];
    
    [self updateCellSelect];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) return;
    
    NSNumber *screenType = self.screenTypes[indexPath.section][indexPath.row];
    NSMutableArray *selected = self.screenTypes[0];
    NSMutableArray *unselected = self.screenTypes[1];
    [selected removeObjectAtIndex:indexPath.row];
    [unselected addObject:screenType];
    [unselected sortUsingComparator:^NSComparisonResult(NSNumber *  _Nonnull obj1, NSNumber * _Nonnull obj2) {
        return [obj1 compare:obj2];;
    }];
    
    NSInteger index = [unselected indexOfObject:screenType];
    [tableView beginUpdates];
    NSIndexPath *toIndexPath = [NSIndexPath indexPathForRow:index inSection:1];
    NSLog(@"deselect %@ to %@ select %@ unselect %@", indexPath, toIndexPath, @(selected.count), @(unselected.count));
    [tableView moveRowAtIndexPath:indexPath toIndexPath:toIndexPath];
    [tableView endUpdates];
    
    [self updateCellSelect];
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.screenTypes.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.screenTypes[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LZScreenContentCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LZScreenContentCell class]) forIndexPath:indexPath];
    NSNumber *pageTypeNum = self.screenTypes[indexPath.section][indexPath.row];
    
    cell.textLabel.text = [self nameWithScreenType:pageTypeNum.integerValue];
    return cell;
}

#pragma mark - private Methods
- (void)updateCellSelect {
    NSArray <NSIndexPath *> *indexPaths = self.tableView.indexPathsForSelectedRows;
    
    NSMutableArray *array = [NSMutableArray array];
    for (NSIndexPath *indexPath in indexPaths) {
        NSNumber *screenType = self.screenTypes[indexPath.section][indexPath.row];
        [array addObject:screenType];
    }
    
    self.data.listPage = array;
    [self sendData:self.data];
}

#pragma mark - getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.allowsMultipleSelection = YES;
        _tableView.allowsSelectionDuringEditing=YES;
        _tableView.allowsMultipleSelectionDuringEditing = YES;
        [_tableView setEditing:YES animated:YES];
        [_tableView registerClass:[LZScreenContentCell class] forCellReuseIdentifier:NSStringFromClass([LZScreenContentCell class])];
    }
    return _tableView;
}


- (NSMutableArray<LZScreenContentModel *> *)modelAry {
    if (!_modelAry) {
        _modelAry = [[LZScreenContentModel cellModelList] mutableCopy];
    }
    return _modelAry;
}

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

- (NSMutableArray < NSMutableArray<NSNumber *> *> *)screenTypes {
    if (!_screenTypes) {
        _screenTypes = [NSMutableArray array];
        [_screenTypes addObject:[NSMutableArray array]];
        [_screenTypes addObject:[NSMutableArray array]];
    }
    return _screenTypes;
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
