//
//  LZSetPopUpViewController.h
//  LSBluetoothUI_iOS
//
//  Created by wm on 2020/12/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^WEEKBLOCK)(NSArray <NSIndexPath *> *ary);

@interface LZSetPopUpViewController : UIViewController

@property (nonatomic,copy) NSArray <NSString *> *dataSoureAry;

@property (nonatomic, copy) WEEKBLOCK sureBlock;

@end

NS_ASSUME_NONNULL_END
