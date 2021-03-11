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

#import "LZInputStringTableViewCell.h"

typedef NS_ENUM(NSUInteger, LZCellType) {
    LZCellTypeNormal,
    LZCellTypeInput,
};

typedef NS_ENUM(NSUInteger, LZCellTag) {
    LZCellTagDeviceList,
    LZCellTagDeviceSearch,
    LZCellTagDeviceMonitor,
    LZCellTagClear,
    LZCellTagDestroy,
};

@interface LZViewController () <LZInputStringTableViewCellDelegate>

@property (nonatomic, strong) NSArray <NSMutableDictionary *> *protocolList;

@end

@implementation LZViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.protocolList = @[
        @{
            @"title": @"设备列表",
            @"cellType": @(LZCellTypeNormal),
            @"cellTag": @(LZCellTagDeviceList),
        }.mutableCopy,
        @{
            @"title": @"搜索绑定",
            @"cellType": @(LZCellTypeNormal),
            @"cellTag": @(LZCellTagDeviceSearch),
        }.mutableCopy,
        @{
            @"title": @"监听某个设备",
            @"cellType": @(LZCellTypeInput),
            @"mac": @"cffbd0cdb33f",
            @"cellTag": @(LZCellTagDeviceMonitor),
        }.mutableCopy,
        @{
            @"title": @"清除所有设备",
            @"cellType": @(LZCellTypeNormal),
            @"cellTag": @(LZCellTagClear),
        }.mutableCopy,
        @{
            @"title": @"销毁设备管理器",
            @"cellType": @(LZCellTypeNormal),
            @"cellTag": @(LZCellTagDestroy),
        }.mutableCopy,
    ];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    [self.tableView registerClass:[LZInputStringTableViewCell class] forCellReuseIdentifier:NSStringFromClass(LZInputStringTableViewCell.class)];
}

#pragma mark - LZInputStringTableViewCellDelegate
- (void)inputTableViewCellDidInputString:(NSString *)string cellModle:(LZBaseSetCellModel *)cellModel {
    NSMutableDictionary *dic = self.protocolList[2];
    dic[@"mac"] = string;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.protocolList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = nil;
    
    NSDictionary *dic = self.protocolList[indexPath.row];
    LZCellType cellType = [dic[@"cellType"] integerValue];
    NSString *title = dic[@"title"];
    
    switch (cellType) {
        case LZCellTypeNormal: {
            cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
            cell.textLabel.text = title;
            break;
        }
        case LZCellTypeInput: {
            LZInputStringTableViewCell *tempCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(LZInputStringTableViewCell.class) forIndexPath:indexPath];
            
            tempCell.textField.placeholder = @"请输入12位的mac地址";
            tempCell.textField.text = dic[@"mac"];
            
            tempCell.delegate = self;
            cell = tempCell;
            
            break;
        }
    }
    
    return cell;
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *vc = nil;
    NSDictionary *dic = self.protocolList[indexPath.row];
    LZCellTag tag = [dic[@"cellTag"] integerValue];
    switch (tag) {
        case LZCellTagDeviceList: {
            vc = [[LSWMyDeviceListViewController alloc] init];
            break;
        }
        case LZCellTagDeviceSearch: {
            vc = [[LZSearchBindContainerViewController alloc] init];
            break;
        }
        case LZCellTagDeviceMonitor: {
            NSString *mac = dic[@"mac"];
            if (mac && mac.length == 12) {
                id<LZDeviceManagerProtocol> deviceManager = [LZBluetooth getDeviceManagerWithDeviceType:LZDeviceTypeBracelet];
                [deviceManager addMonitorDeviceWithMacString:mac.uppercaseString deviceType:LZDeviceTypeBracelet];
            }
            break;
        }
        case LZCellTagClear: {
            id<LZDeviceManagerProtocol> deviceManager = [LZBluetooth getDeviceManagerWithDeviceType:LZDeviceTypeBracelet];
            [deviceManager deleteAll];
            break;
        }
        case LZCellTagDestroy: {
            [LZBluetooth destroy];
            break;
        }
        default:
            break;
    }
    
    
    if (vc) {
        [self.navigationController pushViewController:vc animated:YES];
    }
}


@end
