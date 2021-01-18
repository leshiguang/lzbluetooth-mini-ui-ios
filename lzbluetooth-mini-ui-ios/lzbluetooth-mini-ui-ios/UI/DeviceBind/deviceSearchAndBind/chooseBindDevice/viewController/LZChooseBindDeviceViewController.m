//
//  LZChooseBindDeviceViewController.m
//  LSBluetoothUI_iOS
//
//  Created by wm on 2020/11/27.
//

#import "LZChooseBindDeviceViewController.h"
#import <Masonry/Masonry.h>
#import "LSWBSBSelectDeviceView.h"

@interface LZChooseBindDeviceViewController () <LSWBSBSelectDeviceViewDelegate>
@property (nonatomic, strong) LSWBSBSelectDeviceView *selectDeviceView;
@end

@implementation LZChooseBindDeviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.selectDeviceView setUpWithRawDeviceInfos:self.rawDeviceInfos productInfo:nil isUseProductInfoName:NO];
}

- (void)createUI {
    [self.view addSubview:self.selectDeviceView];
    
    [self.selectDeviceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - LSWBSBSelectDeviceViewDelegate
- (void)selectDeviceView:(LSWBSBSelectDeviceView *)selectDeviceView didSelectDeviceAtIndex:(NSInteger)index {
    LZBaseDevice *rawDeviceInfo = selectDeviceView.rawDeviceInfos[index];
    if (self.delegate && [self.delegate respondsToSelector:@selector(chooseDevice:)]) {
        [self.delegate chooseDevice:rawDeviceInfo];
    }
}

#pragma mark - getter

- (LSWBSBSelectDeviceView *)selectDeviceView {
    if (!_selectDeviceView) {
        _selectDeviceView = [[LSWBSBSelectDeviceView alloc] initWithFrame:self.view.bounds];
        _selectDeviceView.delegate = self;
    }
    return _selectDeviceView;
}

@end
