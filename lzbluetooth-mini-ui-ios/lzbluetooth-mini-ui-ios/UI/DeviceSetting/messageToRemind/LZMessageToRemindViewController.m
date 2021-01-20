//
//  LZMessageToRemindViewController.m
//  LSBluetoothUI_iOS
//
//  Created by wm on 2020/12/8.
//

#import "LZMessageToRemindViewController.h"
#import <Masonry/Masonry.h>

@interface LZMessageToRemindViewController () <UITableViewDelegate, UITableViewDataSource, LZBaseSetTableViewCellDelegate>

@property (nonatomic,strong) NSArray <LZBaseSetCellModel *> *modelAry;

@end

@implementation LZMessageToRemindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息提醒";
    
    [self updateUI];
}

- (void)updateUI {
    
    [self.modelAry enumerateObjectsUsingBlock:^(LZBaseSetCellModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        LZA5SettingCallReminderData *data = [self settingDataWithSubType:obj.setType];
        obj.switchIsOpne = data.enable;
    }];
    
    [self.tableView reloadData];
}
                  
#pragma mark - LZMessageToRemindCellDelegate
- (void)switchOn:(BOOL)isOn cellModle:(LZBaseSetCellModel *)cellModel {
    
    LZA5SettingCallReminderData *data = [[LZA5SettingCallReminderData alloc] init];
    data.reminderType = cellModel.setType;
    data.enable = isOn;
    data.delay = 3;
    data.vibrationType = LZA5VibrationTypeAlways;
    data.vibrationTime = 60;
    data.vibrationLevel1 = 9;
    data.vibrationLevel2 = 9;

    [self sendData:data];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.modelAry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LZBaseSetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LZBaseSetTableViewCell class]) forIndexPath:indexPath];
    [cell updateCellWithModel:self.modelAry[indexPath.row]];
    cell.delegate = self;
    return cell;
}

#pragma mark - getter
- (NSArray<LZBaseSetCellModel *> *)modelAry {
    if (!_modelAry) {
         
        NSMutableArray *mAry = [[NSMutableArray alloc] init];
        LZBaseSetCellModel *model1 = [[LZBaseSetCellModel alloc] initModelWithSetType:LZA5CallReminderTypeWX cellStyle:DEVICESETCELLSTYLE_RIGHT_SWITCH titleStr:@"微信" subStr:nil];
        [mAry addObject:model1];
        
        LZBaseSetCellModel *model2 = [[LZBaseSetCellModel alloc] initModelWithSetType:LZA5CallReminderTypeQQ cellStyle:DEVICESETCELLSTYLE_RIGHT_SWITCH titleStr:@"QQ" subStr:nil];
        [mAry addObject:model2];
        
        LZBaseSetCellModel *model3 = [[LZBaseSetCellModel alloc] initModelWithSetType:LZA5CallReminderTypeSMS cellStyle:DEVICESETCELLSTYLE_RIGHT_SWITCH titleStr:@"短信" subStr:nil];
        [mAry addObject:model3];
        
        LZBaseSetCellModel *model4 = [[LZBaseSetCellModel alloc] initModelWithSetType:LZA5CallReminderTypeDefault cellStyle:DEVICESETCELLSTYLE_RIGHT_SWITCH titleStr:@"来电提醒" subStr:nil];
        [mAry addObject:model4];
        
        LZBaseSetCellModel *model5 = [[LZBaseSetCellModel alloc] initModelWithSetType:LZA5CallReminderTypeLost cellStyle:DEVICESETCELLSTYLE_RIGHT_SWITCH titleStr:@"断连提醒" subStr:nil];
        [mAry addObject:model5];
        
        LZBaseSetCellModel *model6 = [[LZBaseSetCellModel alloc] initModelWithSetType:LZA5CallReminderTypeMsg cellStyle:DEVICESETCELLSTYLE_RIGHT_SWITCH titleStr:@"消息提醒" subStr:nil];
        [mAry addObject:model6];
        
        _modelAry = mAry.copy;
    }
    return _modelAry;
}

@end
