//
//  LZScaleUnitViewController.m
//  lzbluetooth-mini-ui-ios
//
//  Created by tanjian on 2021/2/1.
//

#import "LZScaleUnitViewController.h"

@interface LZScaleUnitViewController ()

@property (nonatomic, strong) LZA6UnitSettingData *data;

@end

@implementation LZScaleUnitViewController
@dynamic data;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"体重单位设置";
    
    [self updateUI];
}

- (void)updateUI {
    
    [self.tableView reloadData];
    if (self.data.unit < 4) {
        [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:self.data.unit inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
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

- (NSString *)titleWithUnit:(LZA6Unit)unit {
    switch (unit) {
        case LZA6UnitKg:
            return @"公制";
        case LZA6UnitLb:
            return @"Lb";
        case LZA6UnitSt:
            return @"St";
        case LZA6UnitJin:
            return @"斤";
        default:
            NSAssert(NO, @"不支持的code");
            break;
    }
    return @"";
}


@end
