//
//  LZSearchDeviceViewController.h
//  LSBluetoothUI_iOS
//
//  Created by wm on 2020/11/26.
//

#import "LZDeviceManagerViewController.h"

NS_ASSUME_NONNULL_BEGIN

@class LZBaseDevice;

@protocol LZSearchDeviceDelegate <NSObject>

- (void)searchDevice:(NSArray <LZBaseDevice *>*)deviceInfos;

@end

@interface LZSearchDeviceViewController : LZDeviceManagerViewController

@property (nonatomic, weak) id <LZSearchDeviceDelegate> delegate;
 
@end

NS_ASSUME_NONNULL_END
