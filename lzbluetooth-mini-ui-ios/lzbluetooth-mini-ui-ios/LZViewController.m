//
//  LZViewController.m
//  LZBluetooth
//
//  Created by tanjian on 09/27/2020.
//  Copyright (c) 2020 tanjian. All rights reserved.
//

#import "LZViewController.h"
#import <LZBluetooth/LZBluetooth.h>
#import "LSWMyDeviceListViewController.h"
#import "LZSearchBindContainerViewController.h"

@interface LZViewController ()

@property (nonatomic, strong) NSArray <NSString *> *protocolList;

@end

@implementation LZViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.protocolList = @[
        @"设备列表",
        @"搜索绑定",
    ];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.protocolList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSString *string = self.protocolList[indexPath.row];
    
    cell.textLabel.text = string;
    
    return cell;
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *vc = nil;
    switch (indexPath.row) {
        case 0: {
            vc = [[LSWMyDeviceListViewController alloc] init];
            break;
        }
        case 1: {
            vc = [[LZSearchBindContainerViewController alloc] init];
        }
        default:
            break;
    }
    
    
    if (vc) {
        [self.navigationController pushViewController:vc animated:YES];
    }
}


@end
