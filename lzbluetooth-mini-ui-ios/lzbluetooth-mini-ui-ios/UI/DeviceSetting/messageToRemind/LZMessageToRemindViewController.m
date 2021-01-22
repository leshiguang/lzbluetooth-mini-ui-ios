//
//  LZMessageToRemindViewController.m
//  LSBluetoothUI_iOS
//
//  Created by wm on 2020/12/8.
//

#import "LZMessageToRemindViewController.h"
#import "LZInputStringTableViewCell.h"
#import <Masonry/Masonry.h>

@interface LZMessageToRemindViewController () <UITableViewDelegate, UITableViewDataSource, LZInputStringTableViewCellDelegate>

@property (nonatomic, strong) NSArray <LZA5SettingMessageReminderData *> *data;

@property (nonatomic, strong) NSArray <LZBaseSetCellModel *> *modelAry;

@property (nonatomic, strong) NSDictionary <NSNumber *, LZA5SettingMessageReminderData *> *mapData;



@end

@implementation LZMessageToRemindViewController

@dynamic data;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息提醒";
    
    
    [self.tableView registerClass:[LZInputStringTableViewCell class] forCellReuseIdentifier:NSStringFromClass(LZInputStringTableViewCell.class)];
    
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
        if (data) {
            obj.switchIsOpne = data.enable;
        }
    }];
    
    [self.tableView reloadData];
}
                 
#pragma mark - LZMessageToRemindCellDelegate
- (void)switchOn:(BOOL)isOn cellModle:(LZBaseSetCellModel *)cellModel {
    
    LZA5SettingMessageReminderData *data = [[LZA5SettingMessageReminderData alloc] init];
    data.reminderType = cellModel.setType;
    data.enable = isOn;
    
    if (cellModel.setType == LZA5MsgReminderTypeCustom) {
        data.appId = cellModel.subStr;
    }
    [self sendData:data];
}

- (void)inputTableViewCellDidInputString:(NSString *)string cellModle:(nonnull LZBaseSetCellModel *)cellModel {
    LZA5SettingMessageReminderData *data = self.mapData[@(cellModel.setType)];
    data.appId = string;
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.modelAry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LZBaseSetCellModel *model = self.modelAry[indexPath.row];
    LZBaseSetTableViewCell *cell = nil;
    if (model.setType == LZA5MsgReminderTypeCustom) {
        cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(LZInputStringTableViewCell.class) forIndexPath:indexPath];
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LZBaseSetTableViewCell class]) forIndexPath:indexPath];
    }
    
    [cell updateCellWithModel:self.modelAry[indexPath.row]];
    cell.delegate = self;
    return cell;
}

#pragma mark - getter
- (NSArray<LZBaseSetCellModel *> *)modelAry {
    if (!_modelAry) {
        NSMutableArray *mAry = [[NSMutableArray alloc] init];
        [[self currentSettingTypes] enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            LZBaseSetCellModel *model1 = [[LZBaseSetCellModel alloc] initModelWithSetType:obj.integerValue cellStyle:DEVICESETCELLSTYLE_RIGHT_SWITCH titleStr:[self titleWithReminderType:obj.integerValue] subStr:@""];
            if (obj.integerValue == LZA5MsgReminderTypeCustom) {
                model1.subStr = @"com.laiwang.DingTalk";
            }
            
            [mAry addObject:model1];
        }];
         
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
        case LZA5MsgReminderTypeLine:
            return @"line";
        case LZA5MsgReminderTypeGmail:
            return @"gmail";
        case LZA5MsgReminderTypeFacebook:
            return @"facebook";
        case LZA5MsgReminderTypeKakaoTalk:
            return @"KakaoTalk";
        case LZA5MsgReminderTypeWhatsApp:
            return @"whatsapp";
        case LZA5MsgReminderTypeSEWellness:
            return @"se wellness";
        case LZA5MsgReminderTypeCustom:
            return @"自定义";
            
        default:
            break;
    }
    return @"";
}

- (NSArray <NSNumber *> *)currentSettingTypes {
    return @[
        @(LZA5MsgReminderTypeWX),
        @(LZA5MsgReminderTypeQQ),
        @(LZA5MsgReminderTypeSMS),
        @(LZA5MsgReminderTypeCall),
        @(LZA5MsgReminderTypeLost),
        @(LZA5MsgReminderTypeMsg),
        @(LZA5MsgReminderTypeLine),
        @(LZA5MsgReminderTypeGmail),
        @(LZA5MsgReminderTypeFacebook),
        @(LZA5MsgReminderTypeKakaoTalk),
        @(LZA5MsgReminderTypeWhatsApp),
        @(LZA5MsgReminderTypeSEWellness),
        @(LZA5MsgReminderTypeCustom),
    ];
}

- (id)defaultData {
    return nil;
}

@end
