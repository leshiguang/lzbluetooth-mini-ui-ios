//
//  LZSetPickerViewController.h
//  Pods
//
//  Created by wm on 2020/12/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class LZSetPickerViewController;

@protocol LZSetPickerDelegate <NSObject>

@optional

- (void)pickerViewController:(LZSetPickerViewController *)vc didPickComponent:(NSUInteger)component row:(NSUInteger)row;
- (void)pickerViewControllerCanceld:(LZSetPickerViewController *)vc;

@end

@interface LZSetPickerViewController : UIViewController

@property (nonatomic, copy) NSArray <NSArray *> *dataSoureAry;
@property (nonatomic, weak) id <LZSetPickerDelegate> delegate;

@property (nonatomic, assign) NSUInteger selectComponent;
@property (nonatomic, assign) NSUInteger selectRow;

@end

NS_ASSUME_NONNULL_END
