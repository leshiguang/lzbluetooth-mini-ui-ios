//
//  LZReadRealTimeHRViewController.m
//  lzbluetooth-mini-ui-ios
//
//  Created by tanjian on 2021/3/18.
//

#import "LZReadRealTimeHRViewController.h"

@interface LZReadRealTimeHRViewController () <LZBaseSetTableViewCellDelegate>


@property (nonatomic, strong) LZBaseSetCellModel *model;
@property (nonatomic, strong) LZA5SettingRealTimeHeartRateSwitchData *data;

@end

@implementation LZReadRealTimeHRViewController
@synthesize data;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"实时心率";

    self.data = [[LZA5SettingRealTimeHeartRateSwitchData alloc] init];
    self.model = [[LZBaseSetCellModel alloc] initModelWithSetType:0 cellStyle:DEVICESETCELLSTYLE_RIGHT_SWITCH titleStr:@"实时心率" subStr:nil];
    
    [self updateUI];

}


- (void)updateUI {
    
    self.model.switchIsOpne = self.data.enable;
    [self.tableView reloadData];
}

#pragma mark -
- (void)switchOn:(BOOL)isOn cellModle:(LZBaseSetCellModel *_Nonnull)cellModel {
    
    self.data.enable = isOn;
    [self sendData:self.data];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LZBaseSetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(LZBaseSetTableViewCell.class) forIndexPath:indexPath];
    [cell updateCellWithModel:self.model];
    cell.delegate = self;

    return cell;
}

@end
