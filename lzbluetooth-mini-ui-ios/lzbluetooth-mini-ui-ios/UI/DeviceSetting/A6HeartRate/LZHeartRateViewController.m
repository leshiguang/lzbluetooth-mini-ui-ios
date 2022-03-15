//
//  LZHeartRateViewController.m
//  lzbluetooth-mini-ui-ios
//
//  Created by tanjian on 2021/2/1.
//

#import "LZHeartRateViewController.h"

@import LZScale;

@interface LZHeartRateViewController ()

@property (nonatomic, strong) LZA6HearRateSwitchSettingData *data;

@end

@implementation LZHeartRateViewController
@dynamic data;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"心率开关设置";
    
    [self updateUI];
}

- (void)updateUI {
    
    [self.tableView reloadData];
    
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:self.data.hrSwitch ? 0 : 1 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LZBaseSetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(LZBaseSetTableViewCell.class) forIndexPath:indexPath];
    cell.titleLabel.text = [self titleWithUHRSwitch:indexPath.row == 0 ? LZA6HearRateSwitchOn : LZA6HearRateSwitchOff];
    cell.rightSelectImageView.hidden = NO;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.data.hrSwitch = indexPath.row == 0 ? LZA6HearRateSwitchOn : LZA6HearRateSwitchOff;
    [self sendData:self.data];
}

- (NSString *)titleWithUHRSwitch:(LZA6HearRateSwitch)unit {
    switch (unit) {
        case LZA6HearRateSwitchOn:
            return @"开";
        case LZA6HearRateSwitchOff:
            return @"关";
        default:
            NSAssert(NO, @"不支持的code");
            break;
    }
    return @"";
}


@end
