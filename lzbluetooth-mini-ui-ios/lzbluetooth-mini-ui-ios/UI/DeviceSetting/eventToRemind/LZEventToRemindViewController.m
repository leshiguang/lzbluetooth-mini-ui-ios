//
//  LZEventToRemindViewController.m
//  LSBluetoothUI_iOS
//
//  Created by wm on 2020/12/8.
//

#import "LZEventToRemindViewController.h"
#import <Masonry/Masonry.h>
#import "LZEventToRemindTableViewCell.h"
#import "LZAddEventToRemindViewController.h"
#import "LSWAppFontConfigrationMacro.h"
#import "LSWAppColorConfigrationMacro.h"
#import "LZDeviceSettingDBUtil.h"
#import "UIViewController+MBProgressHUD.h"

@interface LZEventToRemindViewController () <LZBaseSetTableViewCellDelegate>

@property (nonatomic, strong) UIButton *addEventToRemindBtn;

@property (nonatomic, strong) LZA5SettingEventRemindData *data;

@property (nonatomic, strong) NSArray <LZBaseSetCellModel *> *dataSource;

@property (nonatomic, assign) NSInteger limit;

@end

@implementation LZEventToRemindViewController

@dynamic data;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.limit = 5;
    
    self.title = @"事件提醒";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.tableView registerClass:[LZEventToRemindTableViewCell class] forCellReuseIdentifier:NSStringFromClass(LZEventToRemindTableViewCell.class)];
    [self createUI];
    [self updateUI];
    
}

- (void)updateUIWithResult:(LZBluetoothErrorCode)result {
    if (result == LZBluetoothErrorCodeSuccess) {
        self.data = [self settingData];
    }
}

- (void)updateUI {
    NSMutableArray *array = [NSMutableArray array];
    [self.data.contentDatas enumerateObjectsUsingBlock:^(LZA5SettingEventRemindContentData * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *title = [NSString stringWithFormat:@"%02d:%02d", obj.hour, obj.minute];
        LZBaseSetCellModel *model = [[LZBaseSetCellModel alloc] initModelWithSetType:idx cellStyle:DEVICESETCELLSTYLE_RIGHT_SWITCH titleStr:title subStr:obj.des];
        model.switchIsOpne = [self checkIfClockClosedWithContentData:obj];
        [array addObject:model];
    }];
    self.dataSource = array;
    [self.tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.data = [self settingData];
    [self updateUI];
}

- (void)createUI {
    
    [self.view addSubview:self.addEventToRemindBtn];
    
    [self.addEventToRemindBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-24);
        make.left.equalTo(self.view).offset(70);
        make.right.equalTo(self.view).offset(-70);
        make.height.equalTo(@50);
    }];
}

#pragma mark - LZBaseSetTableViewCellDelegate
- (void)switchOn:(BOOL)isOn cellModle:(LZBaseSetCellModel *)cellModel {
    LZA5SettingEventRemindContentData *contentData = self.data.contentDatas[cellModel.setType];
    contentData.enable = isOn;
    LZA5SettingEventRemindData *data = [[LZA5SettingEventRemindData alloc] init];
    data.contentDatas = @[contentData];
    [self sendData:data];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.data.contentDatas.count >= self.limit) {
        [self showHintMessage:[NSString stringWithFormat:@"%@", @(self.limit)] duration:1.5];
        return;
    }
    [self pushToAddEventToRemindWithIndexPath:indexPath];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.contentDatas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LZEventToRemindTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LZEventToRemindTableViewCell class]) forIndexPath:indexPath];
    cell.delegate = self;
    [cell updateCellWithModel:self.dataSource[indexPath.row]];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    __weak typeof(self) weakSelf = self;
    UITableViewRowAction *action = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        [weakSelf deleteWithIndexPath:indexPath];
    }];
    return @[action];
}

#pragma mark - event
- (void)clickAddEventToRemindBtn {
    [self pushToAddEventToRemindWithIndexPath:nil];
}

#pragma mark - Private Methods
- (void)pushToAddEventToRemindWithIndexPath:(nullable NSIndexPath *)indexPath {
    LZAddEventToRemindViewController *vc = [[LZAddEventToRemindViewController alloc] init];
    vc.settingType = vc.settingType;
    vc.device = self.device;
    vc.data = self.data;
    if (indexPath) {
        vc.contentData = self.data.contentDatas[indexPath.row];
    } else {
        LZA5SettingEventRemindContentData *contentData = [[LZA5SettingEventRemindContentData alloc] init];
        contentData.des = @"闹钟1";
        contentData.index = [self indexWithData:self.data];
        contentData.enable = YES;
        contentData.hour = 8;
        contentData.minute = 0;
        contentData.repeatFlag = LZA5RepeatTimeFlagAll;
        contentData.vibrationType = LZA5VibrationTypeAlways;
        contentData.vibrationTime = 60;
        contentData.vibrationLevel1 = 9;
        contentData.vibrationLevel2 = 9;
        vc.contentData = contentData;
    }
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)deleteWithIndexPath:(NSIndexPath *)indexPath {
    /// 删除闹钟，实际上是关闭相对应的闹钟，不过在存储的时候可以删除缓存
    LZA5SettingEventRemindContentData *contentData = self.data.contentDatas[indexPath.row];
    contentData.enable = NO;
    
    LZA5SettingEventRemindData *data = [[LZA5SettingEventRemindData alloc] init];
    data.contentDatas = @[contentData];
    NSString *macString = self.device.mac;
    [self showActivityIndicatorHUDWithMessage:nil];
    __weak typeof(self) weakSelf = self;
    [self.deviceManager sendDataModel:data macString:macString completion:^(LZBluetoothErrorCode result, id resp) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf hideActivityIndicatorHUD];
            if (result == LZBluetoothErrorCodeSuccess) {
                [weakSelf showHintMessage:@"设置成功" duration:1];
                [LZDeviceSettingDBUtil removeEventReminder:contentData macString:macString];
                weakSelf.data = [weakSelf settingData];
                [weakSelf updateUI];
            } else {
                [weakSelf showHintMessage:@"设置失败" duration:1];
            }
        });
    }];
}


#pragma mark - getter
- (UIButton *)addEventToRemindBtn {
    if (!_addEventToRemindBtn) {
        _addEventToRemindBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addEventToRemindBtn setTitle:@"增加事件提醒" forState:UIControlStateNormal];
        [_addEventToRemindBtn.titleLabel setFont:LSWDefaultFontWithSize(16)];
        [_addEventToRemindBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_addEventToRemindBtn.layer setCornerRadius:25];
        [_addEventToRemindBtn setBackgroundColor:UIColorFromHex(0x5D8DE4)];
        [_addEventToRemindBtn addTarget:self action:@selector(clickAddEventToRemindBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addEventToRemindBtn;
}

- (BOOL)checkIfClockClosedWithContentData:(LZA5SettingEventRemindContentData *)contentData {
    if (contentData.enable && contentData.repeatFlag == LZA5RepeatTimeFlagNon) {
        NSDateComponents *components = [[NSDateComponents alloc] init];
        components.year = contentData.year;
        components.month = contentData.month;
        components.day = contentData.day;
        components.hour = contentData.hour;
        components.minute = contentData.minute;
        NSDate *date = [[NSCalendar currentCalendar] dateFromComponents:components];
        if ([date compare:[NSDate date]] == NSOrderedDescending) {
            return YES;
        } else {
            return NO;
        }
    }
    return contentData.enable;
}

- (NSInteger)indexWithData:(LZA5SettingEventRemindData *)data {
    NSMutableSet *set = [[NSMutableSet alloc] initWithCapacity:self.limit];
    
    [data.contentDatas enumerateObjectsUsingBlock:^(LZA5SettingEventRemindContentData * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [set addObject:@(obj.index)];
    }];
    
    NSInteger index = 0;
    for (int i = 1; i <= self.limit; i++) {
        if (![set containsObject:@(i)]) {
            index = i;
        }
    }
    return index;
}

@end
