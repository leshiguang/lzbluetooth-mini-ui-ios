//
//  LZMessageToRemindViewController.m
//  LSBluetoothUI_iOS
//
//  Created by wm on 2020/12/8.
//

#import "LZMessageToRemindViewController.h"
#import <Masonry/Masonry.h>

@interface LZMessageToRemindViewController () <UITableViewDelegate, UITableViewDataSource, LZBaseSetTableViewCellDelegate>

@property (nonatomic, strong) NSArray <LZA5SettingMessageReminderData *> *data;

@property (nonatomic, strong) NSArray <LZBaseSetCellModel *> *modelAry;

@property (nonatomic, strong) NSDictionary <NSNumber *, LZA5SettingMessageReminderData *> *mapData;

@end

@implementation LZMessageToRemindViewController

@dynamic data;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息提醒";
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [self.data enumerateObjectsUsingBlock:^(LZA5SettingMessageReminderData * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        dic[@(obj.reminderType)] = obj;
    }];
    self.mapData = dic.copy;
    
    [self updateUI];
}

- (void)updateUI {
    
    [self.modelAry enumerateObjectsUsingBlock:^(LZBaseSetCellModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        LZA5SettingMessageReminderData *data = self.mapData[@(obj.setType)];
        obj.switchIsOpne = data.enable;
    }];
    
    [self.tableView reloadData];
}
                  
#pragma mark - LZMessageToRemindCellDelegate
- (void)switchOn:(BOOL)isOn cellModle:(LZBaseSetCellModel *)cellModel {
    
    LZA5SettingMessageReminderData *data = [[LZA5SettingMessageReminderData alloc] init];
    data.reminderType = cellModel.setType;
    data.enable = isOn;

    [self sendData:data];
}

#pragma mark - UITableViewDelegate
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
        for (LZA5MsgReminderType i = LZA5MsgReminderTypeCall; i <= LZA5MsgReminderTypeQQ; i++) {
            LZBaseSetCellModel *model1 = [[LZBaseSetCellModel alloc] initModelWithSetType:i cellStyle:DEVICESETCELLSTYLE_RIGHT_SWITCH titleStr:[self titleWithReminderType:i] subStr:nil];
            [mAry addObject:model1];
        }
         
        _modelAry = mAry.copy;
    }
    return _modelAry;
}

- (NSString *)titleWithReminderType:(LZA5MsgReminderType)reminderType {
    switch (reminderType) {
        case LZA5MsgReminderTypeWX:
            return @"微信";
        case LZA5MsgReminderTypeQQ:
            return @"QQ";
        case LZA5MsgReminderTypeSMS:
            return @"短信提醒";
        case LZA5MsgReminderTypeCall:
            return @"来电提醒";
        case LZA5MsgReminderTypeLost:
            return @"断连提醒";
        case LZA5MsgReminderTypeMsg:
            return @"消息提醒";
        case LZA5MsgReminderTypeCustom:
            return @"自定义";
        default:
            break;
    }
    return @"";
}

- (NSArray *)defaultData {
    NSMutableArray *array = [NSMutableArray array];
    for (LZA5MsgReminderType i = LZA5MsgReminderTypeCall; i < LZA5MsgReminderTypeQQ; i++) {
        LZA5SettingMessageReminderData *data = [[LZA5SettingMessageReminderData alloc] init];
        data.reminderType = i;
        data.enable = NO;
        [array addObject:data];
    }
    return array;
}

@end
