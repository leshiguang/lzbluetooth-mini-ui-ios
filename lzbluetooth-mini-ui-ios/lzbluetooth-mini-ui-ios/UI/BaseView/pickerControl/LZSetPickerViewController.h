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

/// 可以通过
- (void)pickerViewControllerDidSelect:(LZSetPickerViewController *)vc;
- (void)pickerViewControllerCanceld:(LZSetPickerViewController *)vc;

@end

@interface LZSetPickerViewController : UIViewController

@property (nonatomic, copy) NSArray <NSArray *> *dataSoureAry;
@property (nonatomic, weak) id <LZSetPickerDelegate> delegate;

/// 获取当前的选中
/// @param component 列
- (NSInteger)selectedRowInComponent:(NSInteger)component;

- (void)selectRow:(NSInteger)row inComponent:(NSInteger)component animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
