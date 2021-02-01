//
//  LZWifiSettingViewController.m
//  lzbluetooth-mini-ui-ios
//
//  Created by tanjian on 2021/2/1.
//

#import "LZWifiSettingViewController.h"

@interface LZWifiSettingViewController () <LZDeviceDelegate>

@property (nonatomic, strong) NSMutableDictionary *wifiMap;
@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation LZWifiSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *scanItem = [[UIBarButtonItem alloc] initWithTitle:@"scan" style:UIBarButtonItemStylePlain target:self action:@selector(scanItemClicked:)];
    UIBarButtonItem *stopItem = [[UIBarButtonItem alloc] initWithTitle:@"stop" style:UIBarButtonItemStylePlain target:self action:@selector(stopItemClicked:)];
    UIBarButtonItem *resetItem = [[UIBarButtonItem alloc] initWithTitle:@"reset" style:UIBarButtonItemStylePlain target:self action:@selector(resetItemClicked:)];
    self.navigationItem.rightBarButtonItems = @[scanItem, stopItem, resetItem];
//    self.deviceManager.delegate = self;
}

#pragma mark - Event
- (void)scanItemClicked:(id)sender {
    LZWifiScanData *wifiScanData = [[LZWifiScanData alloc] init];
    wifiScanData.scanType = 1;
    [self.device sendDataModel:wifiScanData completion:^(LZBluetoothErrorCode result) {
            
    }];
}

- (void)stopItemClicked:(id)sender {
    LZWifiScanData *wifiScanData = [[LZWifiScanData alloc] init];
    wifiScanData.scanType = 0;
    [self.device sendDataModel:wifiScanData completion:^(LZBluetoothErrorCode result) {
            
    }];
}

- (void)resetItemClicked:(id)sender {
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//}


@end
