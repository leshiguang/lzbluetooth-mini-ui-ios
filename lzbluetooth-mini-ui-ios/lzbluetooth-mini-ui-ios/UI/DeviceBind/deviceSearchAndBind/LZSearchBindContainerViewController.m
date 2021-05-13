//
//  LZSearchBindContainerViewController.m
//  LSBluetoothUI_iOS
//
//  Created by wm on 2020/11/30.
//

#import "LZSearchBindContainerViewController.h"
#import "LZChooseBindDeviceViewController.h"
#import "LZSearchDeviceViewController.h"
#import "LZBindingViewController.h"
#import "LSWAppAppearanceConfigrationMacro.h"

@interface LZSearchBindContainerViewController () <LZSearchDeviceDelegate, LZChooseBindDeviceDelegate, LZBindingDelegate>
@property (nonatomic, strong) LZSearchDeviceViewController *searchVC;
@property (nonatomic, strong) LZChooseBindDeviceViewController *chooseBindVC;
@property (nonatomic, strong) LZBindingViewController *bindingVC;
@property (nonatomic, strong) UIViewController *currentVC;

@end

@implementation LZSearchBindContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self defaultUI];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [self.deviceManager stopSearch];
}

- (void)defaultUI {
    self.searchVC = [[LZSearchDeviceViewController alloc] init];
    self.searchVC.delegate = self;
    [self addChildViewController:self.searchVC];
    
    self.chooseBindVC = [[LZChooseBindDeviceViewController alloc] init];
    self.chooseBindVC.delegate = self;
    [self.chooseBindVC.view setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-LSW_NavigationBarHeight)];
    
    self.bindingVC = [[LZBindingViewController alloc] init];
    self.bindingVC.delegate = self;
    [self.bindingVC.view setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-LSW_NavigationBarHeight)];
    
    [self.view addSubview:self.searchVC.view];
    self.currentVC = self.searchVC;
}

#pragma mark - LZSearchDeviceDelegate
- (void)searchDevice:(NSArray<LZBaseDevice *> *)deviceInfos {
    if (deviceInfos.count > 1) {
        self.chooseBindVC.rawDeviceInfos = deviceInfos;
        [self replaceController:self.currentVC newController:self.chooseBindVC];
    } else {
        self.bindingVC.device = deviceInfos.firstObject;
        self.bindingVC.needToStarting = NO;
        [self replaceController:self.currentVC newController:self.bindingVC];
    }
}

#pragma mark - LZChooseBindDeviceDelegate
- (void)chooseDevice:(LZBaseDevice *)deviceInfo {
    self.bindingVC.device = deviceInfo;
    self.bindingVC.needToStarting = YES;
    [self replaceController:self.currentVC newController:self.bindingVC];
}

#pragma mark - LZBindingDelegate
- (void)restBind {
    [self.currentVC willMoveToParentViewController:nil];
    [self.currentVC removeFromParentViewController];
    [self addChildViewController:self.searchVC];
    [self.view addSubview:self.searchVC.view];
    self.currentVC = self.searchVC;
    
}


#pragma mark - private Methods
- (void)replaceController:(UIViewController *)oldController newController:(UIViewController *)newController
{
    [self addChildViewController:newController];
    
    [self transitionFromViewController:oldController toViewController:newController duration:0.0 options:UIViewAnimationOptionTransitionNone animations:nil completion:^(BOOL finished) {
        if (finished) {
            [newController didMoveToParentViewController:self];
            [oldController willMoveToParentViewController:nil];
            [oldController removeFromParentViewController];
            self.currentVC = newController;
        }else{
                      
            self.currentVC = oldController;
                  
        }
    }];
}

@end
