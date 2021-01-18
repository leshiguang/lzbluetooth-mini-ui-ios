//
//  LZSetPickerViewController.h
//  Pods
//
//  Created by wm on 2020/12/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol LZSetPickerDelegate <NSObject>

@required
- (void)pickerEnd:(NSArray * _Nullable)selectAry isSure:(BOOL)isSure;

@end

@interface LZSetPickerViewController : UIViewController

@property (nonatomic, copy) NSArray <NSArray *> *dataSoureAry;
@property (nonatomic, weak) id <LZSetPickerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
