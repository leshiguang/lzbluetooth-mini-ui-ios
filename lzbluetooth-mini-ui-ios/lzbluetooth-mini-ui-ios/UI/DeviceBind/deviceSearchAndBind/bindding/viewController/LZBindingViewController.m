//
//  LZBindingViewController.m
//  LSBluetoothUI_iOS
//
//  Created by wm on 2020/12/1.
//

#import "LZBindingViewController.h"
#import "LSWBindingDeviceView.h"
#import <Masonry/Masonry.h>
#import "LZBaseDeviceInfoViewController.h"
#import "UIViewController+MBProgressHUD.h"
#import <LZBluetooth/LZBluetooth.h>

@interface LZBindingViewController () <LSWBindingDeviceViewDelegate, LSWEnterRandomCodeViewDelegate, LZDeviceBindDelegate>
@property (nonatomic, strong) LSWBindingDeviceView *bindingDeviceView;

@property (nonatomic, assign) BOOL isInputCodeError;
@property (nonatomic, assign) NSInteger codeLength;
@property (nonatomic, strong) NSTimer *randomCodeTimer;

@property (nonatomic, strong) LZBaseDevice *bindedDevice;

@end

@implementation LZBindingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setUpBindingDeviceView];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self canclePairingRawDeviceInfo:self.device];
}

- (void)createUI {
    [self.view addSubview:self.bindingDeviceView];
    [self.bindingDeviceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)setUpBindingDeviceView{
    /// 有且需要去绑定
    if (self.device) {
        if (self.needToStarting) {
            [self.bindingDeviceView changeBindingStateTo:LSWDeviceBindingStateBinding];
            [self startPairDeviceInfo:self.device];
        } else {
            [self.bindingDeviceView changeBindingStateTo:LSWDeviceBindingStateWaitingBind];
        }
        
        [self.bindingDeviceView setDeviceName:self.device.name imageUrl:nil placeHolderImage:nil];
    } else {
        [self.bindingDeviceView changeBindingStateTo:LSWDeviceBindingStateBindFailed];
    }
}


#pragma mark - 配对设备
- (void)startPairDeviceInfo:(LZBaseDevice *)rawDeviceInfo {
    [self.deviceManager bindWithDevice:rawDeviceInfo bindDelegate:self];
}

- (void)canclePairingRawDeviceInfo:(LZBaseDevice *)rawDeviceInfo {
    [self.deviceManager cancelBindWithMacString:rawDeviceInfo.macAddress];
}

#pragma mark - LSDeviceManagerDelegate
- (void)device:(id<LZDeviceProtocol>)device bindStateChanged:(LZBindState)bindState {
    dispatch_async(dispatch_get_main_queue(), ^{
        switch (bindState) {
            case LZBindStateInputRandomNumber:
                /// 需要你输入随机码
                [self _handleBindStatusInputRandomCodeWihtLength:6];
                break;
                
            case LZBindStateInputUserNumberAndBindResult:
                /// 这个是体脂秤需要使用的，手环不会回调这个状态
                [self.deviceManager inputUserNumber:1 bindResult:1 macString:device.macAddress deviceType:device.deviceType];
                break;
//            case LZBindStateUnregister: {
//                /// 这个是体脂秤需要使用的，手环不会回调这个状态
//                
//                [self.deviceManager registWithDeviceId:device.macAddress macString:device.macAddress deviceType:device.deviceType];
//                break;
//            }
                
            case LZBindStateSuccessful:
                self.bindedDevice = device;
                [self _handleBindStatusSuccess];
                break;
            case LZBindStateFailure:
            case LZBindStateAuthorizeFailure: {
                [self _handleBindStatusFailedWithNetCode:bindState];
                break;
            }
            case LZBindStateInputRandomNumberError: {
                [self _handleBindStatusInputRndomCodeError];
                break;
            }
            case LZBindStateAwaitUserConfirm: {
                // 提示用户需要去点击手环上的按钮
                break;
            }
            case LZBindStateUserCanceled: {
                [self _handleBindStatusFailedWithNetCode:bindState];
                break;
            }
            default:
                [self _handleBindStatusFailedWithNetCode:bindState];
                break;
        }
    });
}

#pragma mark - LSWBindingDeviceViewDelegate
- (void)lswBindingDeviceViewDidTapAtionType:(LSWBindingViewDeviceTapActionType)actionType {
    switch (actionType) {
        case LSWBindingViewDeviceTapActionTypeBindNow:{
            if (self.device) {
                [self.bindingDeviceView changeBindingStateTo:LSWDeviceBindingStateBinding];
                [self startPairDeviceInfo:self.device];
            }
        }
            break;
        case LSWBindingViewDeviceTapActionTypeBindDone:{
            [self showCurrentBindedDevice];
        }
            break;
        case LSWBindingViewDeviceTapActionTypeBindReBind:{
            //重新绑定
            if (self.delegate && [self.delegate respondsToSelector:@selector(restBind)]) {
                [self.delegate restBind];
            }
        }
            break;
        case LSWBindingViewDeviceTapActionTypeBindSetActiveDeviceYes:{
        }
            break;
        case LSWBindingViewDeviceTapActionTypeBindSetActiveDeviceNo:{
        }
            break;
        case LSWBindingViewDeviceTapActionTypeBindGuideAction:{
        }
            break;
        default:
            
            break;
    }
}

#pragma mark - LSWEnterRandomCodeViewDelegate
- (void)enterRandomCodeView:(LSWEnterRandomCodeView *)enterRandomCodeView didEnterCode:(NSString *)code {
    [self.bindingDeviceView.enterRandomCodeView hideKeyboard];
    [self.deviceManager inputRandomCode:code macString:self.device.macAddress deviceType:self.device.deviceType];
}

#pragma mark - 绑定回调处理
- (void)_handleBindStatusInputRandomCodeWihtLength:(int)length{
    if (length != self.codeLength) {
        self.codeLength = length;
    }
    
    if (!self.isInputCodeError) {
        [self bindingInputCodeUI];
        [self startRandomCodeTimer];
        //打个标记，如果下一次进入，则认为验证码错误
        self.isInputCodeError = YES;
    } else {
        [self showHintMessage:@"随机码错误" duration:2];
        [self.bindingDeviceView.enterRandomCodeView clearAndReset];
    }
}

- (void)_handleBindStatusInputRndomCodeError {
    self.isInputCodeError = NO;
    [self showHintMessage:@"随机码错误" duration:2];
    [self.bindingDeviceView.enterRandomCodeView clearAndReset];
}

- (void)_handleBindStatusSuccess{
    [self stopRandomCodeTimer];
    self.isInputCodeError = NO;
    [self.bindingDeviceView changeBindingStateTo:LSWDeviceBindingStateBindSucceed];
//    LZWifiScanData *scanData = [[LZWifiScanData alloc] init];
//    scanData.scanType = 1;
//    scanData.showHidden = NO;
//    __weak typeof(self) weakSelf  = self;
//    [self.deviceManager sendDataModel:scanData macString:self.bindedDevice.mac completion:^(LZBluetoothErrorCode result, id  _Nullable response) {
//        NSLog(@"result %@ %@", @(result), response);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [weakSelf showHintMessage:[NSString stringWithFormat:@"%@ %@", @(result), response] duration:2];
//        });
//        
//    }];
}

- (void)_handleBindStatusFailedWithNetCode:(NSInteger)netCode{
    [self stopRandomCodeTimer];
    self.isInputCodeError = NO;
    [self canclePairingRawDeviceInfo:self.device];
    [self.bindingDeviceView.enterRandomCodeView hideKeyboard];
    [self.bindingDeviceView changeBindingStateTo:LSWDeviceBindingStateBindFailed];
}


- (void)bindingInputCodeUI{
    self.bindingDeviceView.inputCodeLength = self.codeLength;
    [self.bindingDeviceView changeBindingStateTo:LSWDeviceBindingStateWaitingInput];
    self.bindingDeviceView.enterRandomCodeView.delegate = self;
    [self.bindingDeviceView.enterRandomCodeView clearAndReset];
    [self.bindingDeviceView.enterRandomCodeView setHintContent:@"请输入随机码" showActivityIndicator:YES];
}

#pragma mark - timmer
- (void)randomCodeTimeTimeout:(NSTimer *)timer {
    //输入随机码超时
    //手动触发绑定失败
    [self device:self.device bindStateChanged:LZBindStateFailure];
}

- (void)startRandomCodeTimer {
    [self stopRandomCodeTimer];
    self.randomCodeTimer = [NSTimer scheduledTimerWithTimeInterval:55 target:self selector:@selector(randomCodeTimeTimeout:) userInfo:nil repeats:NO];
}

- (void)stopRandomCodeTimer {
    if (self.randomCodeTimer != nil) [self.randomCodeTimer invalidate];
    self.randomCodeTimer = nil;
}

#pragma mark -
- (void)showCurrentBindedDevice {
    if (self.bindedDevice) {
        LZBaseDeviceInfoViewController *vc = [[LZBaseDeviceInfoViewController alloc] init];
        vc.device = self.bindedDevice;
        [self.navigationController pushViewController:vc animated:YES];
        NSMutableArray *mAryVC = [[NSMutableArray alloc] initWithArray:self.navigationController.viewControllers];
        [mAryVC removeObjectAtIndex:mAryVC.count - 2];
        self.navigationController.viewControllers = mAryVC;
    }
}

#pragma mark - getter

- (LSWBindingDeviceView *)bindingDeviceView{
    if (_bindingDeviceView == nil ){
        _bindingDeviceView = [[LSWBindingDeviceView alloc] init];
        _bindingDeviceView.enterRandomCodeView.delegate = self;
        _bindingDeviceView.delegate = self;
    }
    return _bindingDeviceView;
}


@end
