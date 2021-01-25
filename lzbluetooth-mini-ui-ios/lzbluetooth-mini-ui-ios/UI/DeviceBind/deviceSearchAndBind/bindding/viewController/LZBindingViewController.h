//
//  LZBindingViewController.h
//  LSBluetoothUI_iOS
//
//  Created by wm on 2020/12/1.
//

#import "LZDeviceManagerViewController.h"

NS_ASSUME_NONNULL_BEGIN

@protocol LZBindingDelegate <NSObject>

- (void)restBind;

@end

@interface LZBindingViewController : LZDeviceManagerViewController

@property (nonatomic, assign) BOOL needToStarting;
@property (nonatomic, weak) id <LZBindingDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
