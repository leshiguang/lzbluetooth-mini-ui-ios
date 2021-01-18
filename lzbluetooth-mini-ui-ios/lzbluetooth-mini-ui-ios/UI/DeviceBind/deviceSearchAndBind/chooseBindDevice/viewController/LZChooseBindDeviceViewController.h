//
//  LZChooseBindDeviceViewController.h
//  LSBluetoothUI_iOS
//
//  Created by wm on 2020/11/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class LZBaseDevice;

@protocol LZChooseBindDeviceDelegate <NSObject>

- (void)chooseDevice:(LZBaseDevice *)deviceInfo;

@end

@interface LZChooseBindDeviceViewController : UIViewController

@property (nonatomic, strong) NSArray<LZBaseDevice *> *rawDeviceInfos;

@property (nonatomic, weak) id <LZChooseBindDeviceDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
