//
//  LSWMyDeviceListViewController.m
//  LSWearable
//
//  Created by ShunQing Cao on 2019/9/20.
//  Copyright © 2019 lifesense. All rights reserved.
//

#import "LSWMyDeviceListViewController.h"
#import "LSWMineBraceletTableViewCell.h"
#import <Masonry/Masonry.h>
#import "LZSearchBindContainerViewController.h"
#import "LZBraceletInfoViewController.h"
#import "LSWAppFontConfigrationMacro.h"
#import "LSWAppColorConfigrationMacro.h"

#import <LZBluetooth/LZBluetooth.h>

typedef NS_ENUM(NSUInteger, LSDeviceListSection) {
    LSDeviceListSectionBand = 0,
    LSDeviceListSectionScale,
    LSDeviceListSectionBp,
    LSDeviceListSectionOther,
};

@interface LSWMyDeviceListViewController () <UITableViewDelegate, UITableViewDataSource, LZDeviceDelegate>
@property (nonatomic) NSMutableArray <NSArray <LZBaseDevice *> *>*devices;
@property (nonatomic) UITableView *tableView;
@property (nonatomic) UIButton *addNewDeviceButton;
@property (nonatomic) UILabel *noDataLabel;
@property (nonatomic) UIImageView *noDataImageView;

@property (nonatomic, assign) BOOL currentIsCharging;
@property (nonatomic, assign) BOOL bluetoothEnabled;
@property (nonatomic) UIAlertController *blePowerDownAlertView;

@property (nonatomic, assign) BOOL connected;

@end

@implementation LSWMyDeviceListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createUI];
    self.bluetoothEnabled = self.deviceManager.isBluetoothEnabled;
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    self.title = @"我的设备";
    [self loadBoundDevices];
    
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

- (void)createUI {
    [self.view addSubview:self.noDataImageView];
    [self.view addSubview:self.noDataLabel];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.addNewDeviceButton];
    
    [self.addNewDeviceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-24);
        make.left.equalTo(self.view).offset(70);
        make.right.equalTo(self.view).offset(-70);
        make.height.equalTo(@50);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(0);
        make.left.and.right.equalTo(self.view);
        make.bottom.equalTo(self.addNewDeviceButton.mas_top).offset(-10);
    }];
    
    [self.noDataImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(@(self.view.frame.size.height/3));
        make.height.and.width.mas_equalTo(@(self.view.frame.size.width/3));
        make.centerX.equalTo(self.view);
    }];
    
    [self.noDataLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.noDataImageView.mas_bottom).offset(20);
        make.centerX.equalTo(self.view);
    }];
}

#pragma mark - TableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.devices.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.devices[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LSWMineBraceletTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LSWMineBraceletTableViewCell"];
    [cell updateUIWithDevice:self.devices[indexPath.section][indexPath.row] isOnlyOne:!(self.devices[LSDeviceListSectionBand].count > 1) bluetoothEnabled:self.bluetoothEnabled];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 92;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    LZBaseDevice *device = self.devices[indexPath.section][indexPath.row];
    LZBraceletInfoViewController *vc = [[LZBraceletInfoViewController alloc] init];
    vc.device = device;
    [self.navigationController pushViewController:vc animated:YES];

}

#pragma mark - LSDeviceManagerDelegate
/// 连接状态发生改变
/// @param device 设备
- (void)deviceDidUpdateBatteryStatus:(id<LZDeviceProtocol>)device {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

- (void)deviceDidUpdateConnectStatus:(id<LZDeviceProtocol>)device {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

#pragma mark - Private Methods
- (void)loadBoundDevices {
    [self.devices removeAllObjects];
    [self handleWithBoundDevices:[self.deviceManager bindedDevices]];
    [self.tableView reloadData];
}

- (void)handleWithBoundDevices:(NSArray <LZBaseDevice *> *)devices {
    [self.devices addObject:devices];
    BOOL isOneOrNon = self.devices.count <= 1;
  
    self.tableView.hidden = !isOneOrNon;
    self.noDataLabel.hidden = isOneOrNon;
    self.noDataImageView.hidden = isOneOrNon;
}

- (void)updateCellConnectStatusWithIndexPath:(NSIndexPath *)indexPath{
    LSWMineBraceletTableViewCell *reconnectCell = [self.tableView cellForRowAtIndexPath:indexPath];
    if (indexPath.section >= self.devices.count) {
        return;
    }
    if (indexPath.row >= self.devices[indexPath.section].count) {
        return;
    }
    if (![self.devices[indexPath.section][indexPath.row] isKindOfClass:[LZBaseDevice class]]) {
        return;
    }
    LZBaseDevice *model = self.devices[indexPath.section][indexPath.row];
    [reconnectCell updateUIWithDevice:model isOnlyOne:!(self.devices[LSDeviceListSectionBand].count > 1) bluetoothEnabled:self.bluetoothEnabled];
}

#pragma mark - Events
- (void)addNewDeviceClickEvent{
    LZSearchBindContainerViewController *vc = [[LZSearchBindContainerViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
//    LSWBluetoothSearchBindingViewController *searchBindVC = [[LSWBluetoothSearchBindingViewController alloc] init];
//    searchBindVC.userId = [LSBluetoothUIConfig defaultConfig].accountInfo.userId;
//    [self.navigationController pushViewController:searchBindVC animated:YES];
}

#pragma mark - Getter
- (NSMutableArray *)devices{
    if (!_devices) {
        _devices = [NSMutableArray array];
    }
    return _devices;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[LSWMineBraceletTableViewCell class] forCellReuseIdentifier:@"LSWMineBraceletTableViewCell"];
    }
    return _tableView;
}

- (UIButton *)addNewDeviceButton{
    if (!_addNewDeviceButton) {
        _addNewDeviceButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addNewDeviceButton setTitle:@"添加新设备" forState:UIControlStateNormal];
        [_addNewDeviceButton.titleLabel setFont:LSWDefaultFontWithSize(16)];
        [_addNewDeviceButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_addNewDeviceButton.layer setCornerRadius:25];
        [_addNewDeviceButton setBackgroundColor:UIColorFromHex(0x5D8DE4)];
        [_addNewDeviceButton addTarget:self action:@selector(addNewDeviceClickEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addNewDeviceButton;
}

- (UIAlertController *)blePowerDownAlertView
{
    if (_blePowerDownAlertView == nil) {
        
        UIAlertController *vc = [UIAlertController alertControllerWithTitle:nil message:@"手机未打开蓝牙，请先打开手机蓝牙" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [vc addAction:cancel];
        [vc addAction:ok];
        
        _blePowerDownAlertView = vc;
    }
    return _blePowerDownAlertView;
}

- (UILabel *)noDataLabel{
    if (!_noDataLabel) {
        _noDataLabel = [UILabel new];
        [_noDataLabel setText:@"暂无绑定设备"];
        [_noDataLabel setTextColor:UIColorFromHex(0xb6b6b6)];
        [_noDataLabel setFont:LSWDefaultMediumFontWithSize(16)];
        [_noDataLabel setHidden:YES];
    }
    return _noDataLabel;
}

- (UIImageView *)noDataImageView{
    if (!_noDataImageView) {
        _noDataImageView = [UIImageView new];
        _noDataImageView.contentMode = UIViewContentModeScaleAspectFit;
        [_noDataImageView setImage:[UIImage imageNamed:@"devicelist_empty"]];
        [_noDataImageView setHidden:YES];
    }
    return _noDataImageView;
}
@end
