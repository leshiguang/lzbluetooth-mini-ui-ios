//
//  LZSwimingViewController.m
//  lzbluetooth-mini-ui-ios
//
//  Created by tanjian on 2021/1/19.
//

#import "LZSwimingViewController.h"
#import "LZSetPickerViewController.h"
#import "LZPickerAnimator.h"

@interface LZSwimingViewController () <LZSetPickerDelegate>

@property (nonatomic, strong) LZA5SettingSwimParamsData *data;

@property (nonatomic, strong) LZPickerAnimator *pickerAnimotor;

@property (nonatomic, strong) LZBaseSetCellModel *model;

@end

@implementation LZSwimingViewController

@dynamic data;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"泳池长度";
    
    self.model = [[LZBaseSetCellModel alloc] initModelWithSetType:0 cellStyle:DEVICESETCELLSTYLE_RIGHT_SUBTITLE titleStr:@"泳池长度" subStr:@""];
 
    [self updateUI];
}

- (void)updateUI {
    self.model.subStr = [NSString stringWithFormat:@"%@", @(self.data.length)];
    
    [self.tableView reloadData];
}

#pragma mark - LZSetPickerDelegate
- (void)pickerViewControllerDidSelect:(LZSetPickerViewController *)vc {
    NSInteger row = [vc selectedRowInComponent:0];
    [vc dismissViewControllerAnimated:YES completion:nil];
    
    self.data.length = (row + 1) * 2;
    [self updateUI];
    
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
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    LZSetPickerViewController *vc = [[LZSetPickerViewController alloc] init];
    vc.modalPresentationStyle = UIModalPresentationCustom;
    self.pickerAnimotor = [[LZPickerAnimator alloc] initWithPresentedViewController:self presentingViewController:vc];
    vc.transitioningDelegate = self.pickerAnimotor;
    vc.delegate = self;
    vc.dataSoureAry = @[[self dataArray]];
    
    [self presentViewController:vc animated:YES completion:^{
            
    }];
}

- (NSArray *)dataArray {
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 2; i <= 200; i += 2) {
        [array addObject:[NSString stringWithFormat:@"%d", i]];
    }
    return array;
}

@end
