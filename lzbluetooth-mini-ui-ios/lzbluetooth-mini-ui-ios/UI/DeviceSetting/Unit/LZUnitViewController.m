//
//  LZUnitViewController.m
//  lzbluetooth-mini-ui-ios
//
//  Created by tanjian on 2021/1/19.
//

#import "LZUnitViewController.h"

@interface LZUnitViewController ()

@property (nonatomic, strong) LZA5SettingUnitData *data;

@end

@implementation LZUnitViewController

@dynamic data;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"单位设置";
    
    [self updateUI];
}

- (void)updateUI {
    
    [self.tableView reloadData];
    
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:self.data.unit inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.settingType == LZDeviceSettingTypeScaleUnit) {
        return 5;
    }
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LZBaseSetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(LZBaseSetTableViewCell.class) forIndexPath:indexPath];
    if (self.settingType == LZDeviceSettingTypeScaleUnit) {
        cell.titleLabel.text = [self titleWithScaleUnit:indexPath.row];
    } else {
        cell.titleLabel.text = [self titleWithUnit:indexPath.row];
    }
    
    cell.rightSelectImageView.hidden = NO;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (self.settingType == LZDeviceSettingTypeScaleUnit) {
        LZA6UnitSettingData *data = [[LZA6UnitSettingData alloc] init];
        data.unit = indexPath.row;
        [self sendData:data];
    } else {
        LZA5SettingUnitData *data = [[LZA5SettingUnitData alloc] init];
        data.unit = indexPath.row;
        [self sendData:data];
    }
}

- (NSString *)titleWithUnit:(UInt8)unit {
    switch (unit) {
        case 0:
            return @"公制";
        case 1:
            return @"英制";
        default:
            NSAssert(NO, @"不支持的code");
            break;
    }
    return @"";
}

- (NSString *)titleWithScaleUnit:(LZA6Unit)unit {
    switch (unit) {
        case LZA6UnitKg:
            return @"kg";
        case LZA6UnitLb:
            return @"lb";
        case LZA6UnitSt:
            return @"st";
        case LZA6UnitJin:
            return @"斤";
        case LZA6UnitGongjin:
            return @"公斤";
    }
    return @"";
}

@end
