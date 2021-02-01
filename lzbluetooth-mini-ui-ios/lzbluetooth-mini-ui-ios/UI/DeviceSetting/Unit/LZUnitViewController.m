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
    if (self.data.unit < 2) {
        [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:self.data.unit inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LZBaseSetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(LZBaseSetTableViewCell.class) forIndexPath:indexPath];
    cell.titleLabel.text = [self titleWithUnit:indexPath.row];
    cell.rightSelectImageView.hidden = NO;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.data.unit = indexPath.row;
    [self sendData:self.data];
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

@end
