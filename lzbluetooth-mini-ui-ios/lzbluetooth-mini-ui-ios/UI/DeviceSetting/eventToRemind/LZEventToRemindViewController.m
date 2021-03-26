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

@property (nonatomic, strong) NSArray <LZA5SettingEventRemindData *> *data;

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
    [self.data enumerateObjectsUsingBlock:^(LZA5SettingEventRemindData * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
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
    LZA5SettingEventRemindData *contentData = self.data[cellModel.setType];
    contentData.enable = isOn;
    [self sendData:contentData];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self pushToAddEventToRemindWithIndexPath:indexPath];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
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
    if (self.data.count >= 5) {
        [self showHintMessage:@"最多支持5个闹钟" duration:1.5];
        return;
    }
    [self pushToAddEventToRemindWithIndexPath:nil];
}

#pragma mark - Private Methods
- (void)pushToAddEventToRemindWithIndexPath:(nullable NSIndexPath *)indexPath {
    LZAddEventToRemindViewController *vc = [[LZAddEventToRemindViewController alloc] init];
    vc.settingType = vc.settingType;
    vc.device = self.device;
    if (indexPath) {
        vc.editData = self.data[indexPath.row];
    } else {
        int index = [self indexWithData:self.data];
        LZA5SettingEventRemindData *contentData = [[LZA5SettingEventRemindData alloc] init];
        contentData.des = [NSString stringWithFormat:@"闹钟 %d", index];
        contentData.index = index;
        contentData.enable = YES;
        contentData.hour = 8;
        contentData.minute = 0;
        contentData.repeatFlag = LZA5RepeatTimeFlagAll;
        contentData.vibrationType = LZA5VibrationTypeAlways;
        contentData.vibrationTime = 30;
        contentData.vibrationLevel1 = 9;
        contentData.vibrationLevel2 = 9;
        vc.editData = contentData;
    }
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)deleteWithIndexPath:(NSIndexPath *)indexPath {
    /// 删除闹钟，实际上是关闭相对应的闹钟，不过在存储的时候可以删除缓存
    LZA5SettingEventRemindData *contentData = self.data[indexPath.row];
    contentData.enable = NO;
    
    [self showActivityIndicatorHUDWithMessage:nil];
    __weak typeof(self) weakSelf = self;
    
    [self.deviceManager sendDataModel:contentData macString:self.device.macAddress completion:^(LZBluetoothErrorCode result, id  _Nullable response) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf hideActivityIndicatorHUD];
            
            if (result == LZBluetoothErrorCodeSuccess) {
                [weakSelf showHintMessage:@"设置成功" duration:1.5];
                [LZDeviceSettingDBUtil removeEventReminder:contentData macString:weakSelf.device.macAddress];
            } else {
                [weakSelf showHintMessage:@"设置失败" duration:1.5];
            }
            weakSelf.data = [weakSelf settingData];
            [weakSelf updateUI];
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

- (BOOL)checkIfClockClosedWithContentData:(LZA5SettingEventRemindData *)contentData {
    if (contentData.enable && contentData.repeatFlag == LZA5RepeatTimeFlagNon) {
        
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:contentData.ringTime / 1000];
        
        if ([date compare:[NSDate date]] == NSOrderedDescending) {
            return YES;
        } else {
            return NO;
        }
    }
    return contentData.enable;
}

- (int)indexWithData:(NSArray < LZA5SettingEventRemindData *> *)data {
    NSMutableSet *set = [[NSMutableSet alloc] initWithCapacity:self.limit];
    
    [data enumerateObjectsUsingBlock:^(LZA5SettingEventRemindData * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [set addObject:@(obj.index)];
    }];
    
    int index = 0;
    for (int i = 1; i <= self.limit; i++) {
        if (![set containsObject:@(i)]) {
            index = i;
            break;
        }
    }
    return index;
}

- (id)defaultData {
    return @[];
}

@end
