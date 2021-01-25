//
//  LZSearchDeviceViewController.m
//  LSBluetoothUI_iOS
//
//  Created by wm on 2020/11/26.
//

#import "LZSearchDeviceViewController.h"
#import "LSWBluetoothSearchingDeviceView.h"
#import <Masonry/Masonry.h>
#import "LZChooseBindDeviceViewController.h"

@interface LZSearchDeviceViewController ()
@property (nonatomic, strong) LSWBluetoothSearchingDeviceView *searchingView;
@property (nonatomic, strong) NSTimer *searchDeviceTimeoutTimer;
@property (nonatomic, strong) NSMutableDictionary<NSString *, LZBaseDevice *> *rawDeviceInfoDict;

@end

@implementation LZSearchDeviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self startSearchingDevice];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.searchingView stopWaveAnimation];
    [self clearGatheredRawDeviceInfo];
    [self stopAllTimer];
}

- (void)dealloc {
    [self.searchingView stopWaveAnimation];
    
    if (_searchDeviceTimeoutTimer != nil) {
        [_searchDeviceTimeoutTimer invalidate];
    }
}

- (void)createUI {
    [self.view addSubview:self.searchingView];
    [self.searchingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.searchingView setNeedsLayout];
    [self.searchingView layoutIfNeeded];
    
}

#pragma mark - search
//开始搜索设备
- (void)startSearchingDevice {
//    if ([self.openBluetoothAlertView isVisible]) {
//        [self.openBluetoothAlertView dismissWithClickedButtonIndex:0 animated:YES];
//    }
    
    __weak typeof(self) weakSelf = self;
    
    if (self.deviceManager.isBluetoothEnabled) {
        [weakSelf startSearchDeviceTimeoutTimer];
        [weakSelf.searchingView startWaveAnimation];
        [self.deviceManager searchDeviceWithDeviceTypes:nil resultHandle:^(__kindof LZBaseDevice * _Nonnull device) {
            [weakSelf gatherSearchedRawDeviceInfo:device];
        }];

    } else {
//        [weakSelf.openBluetoothAlertView show];
    };

}

- (void)searchDeviceTimeoutTimerTimeout:(NSTimer *)timer {
    [self stopSearchingDevice];
    if (self.rawDeviceInfoDict.count > 0) {
        NSArray<LZBaseDevice *> *rawDeviceInfos = [self sortedRawDeviceInfoArrayFromDict:self.rawDeviceInfoDict];

        if (self.delegate && [self.delegate respondsToSelector:@selector(searchDevice:)]) {
            [self.delegate searchDevice:rawDeviceInfos];
        }
    } else {
        //没有搜索到任何设备
        [self clearGatheredRawDeviceInfo];
        
    }
}

- (void)stopSearchingDevice {
    [self.searchingView stopWaveAnimation];
    [self stopSearchDeviceTimeoutTimer];
    [self.deviceManager stopSearch];
}

#pragma mark - 筛选设备
- (void)gatherSearchedRawDeviceInfo:(LZBaseDevice *)rawDeviceInfo {
    self.rawDeviceInfoDict[rawDeviceInfo.mac] = rawDeviceInfo;
}

- (void)clearGatheredRawDeviceInfo {
    self.rawDeviceInfoDict = nil;
}

//根据蓝牙信号进行排序
- (NSArray<LZBaseDevice *> *)sortedRawDeviceInfoArrayFromDict:(NSDictionary<NSString *,LZBaseDevice *> *)rawDeviceInfoDict {

//    NSArray<LZBaseDevice *> *rawDeviceInfos = [[rawDeviceInfoDict allValues] sortedArrayUsingDescriptors:@[[[NSSortDescriptor alloc] initWithKey:@"rssi" ascending:NO]]];
    NSArray<LZBaseDevice *> *rawDeviceInfos = [rawDeviceInfoDict.allValues sortedArrayUsingComparator:^NSComparisonResult(LZBaseDevice *  _Nonnull obj1, LZBaseDevice * _Nonnull obj2) {
        if (obj1.rssi.intValue > obj2.rssi.intValue) {
            return NSOrderedAscending;
        }
        return NSOrderedDescending;
    }];
    
    
    return rawDeviceInfos;
}

#pragma mark - timmer
- (void)stopAllTimer {
    [self stopSearchDeviceTimeoutTimer];
}

- (void)stopSearchDeviceTimeoutTimer {
    if (self.searchDeviceTimeoutTimer != nil) [self.searchDeviceTimeoutTimer invalidate];
    self.searchDeviceTimeoutTimer = nil;
}

- (void)startSearchDeviceTimeoutTimer {
    [self stopSearchDeviceTimeoutTimer];
    self.searchDeviceTimeoutTimer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(searchDeviceTimeoutTimerTimeout:) userInfo:nil repeats:NO];
}

#pragma mark - getter
- (LSWBluetoothSearchingDeviceView *)searchingView {
    if (!_searchingView) {
        _searchingView = [[LSWBluetoothSearchingDeviceView alloc] initWithFrame:self.view.bounds];
    }
    return _searchingView;
}

- (NSMutableDictionary<NSString *,LZBaseDevice *> *)rawDeviceInfoDict {
    if (_rawDeviceInfoDict == nil) {
        _rawDeviceInfoDict = [[NSMutableDictionary alloc] init];
    }
    return _rawDeviceInfoDict;
}



@end
