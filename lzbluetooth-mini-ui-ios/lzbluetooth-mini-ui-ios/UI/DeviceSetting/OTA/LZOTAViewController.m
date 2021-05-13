//
//  LZOTAViewController.m
//  lzbluetooth-mini-ui-ios
//
//  Created by tanjian on 2021/3/30.
//

#import "LZOTAViewController.h"

@interface LZOTAViewController ()
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (nonatomic, strong) NSString *path;

@end

@implementation LZOTAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"ota升级";
    self.path = [[NSBundle mainBundle] pathForResource:@"439B0H1003_1003T010_010A0.0.0_3.4.51D232_232_9F3CB799.lzo" ofType:@"lsf"];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [self.deviceManager cancelOtaWithMacString:self.device.mac];
}

- (IBAction)selectFileClicked:(id)sender {
    UIDocumentPickerViewController *pickViewController = [[UIDocumentPickerViewController alloc] initWithURL:[NSBundle mainBundle].bundleURL inMode:UIDocumentPickerModeExportToService];
    [self presentViewController:pickViewController animated:YES completion:^{
            
    }];
}

- (IBAction)startClicked:(id)sender {
    
    NSURL *url = [NSURL fileURLWithPath:self.path];
    __weak typeof(self) weakSelf = self;
    [self.deviceManager otaWithMacString:@"D8D3557DDC00" deviceType:LZDeviceTypeAlice path:url progress:^(double progress) {
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.progressView.progress = progress;
        });
        } resultHandler:^(LZBluetoothErrorCode result, id  _Nullable response) {
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.textView.text = [NSString stringWithFormat:@"%@", @(result)];
            });
        }];
}

- (IBAction)stopClicked:(id)sender {
    [self.deviceManager cancelOtaWithMacString:self.device.mac];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
