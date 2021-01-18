//
//  LZAddEventToRemindContentTableViewCell.h
//  LSBluetoothUI_iOS
//
//  Created by wm on 2020/12/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^LZEditHandler)(NSString *text);

@interface LZAddEventToRemindContentTableViewCell : UITableViewCell
@property (nonatomic, strong) UITextField *textView;
@property (nonatomic, copy) LZEditHandler textViewDidChangeBlock;
@end

NS_ASSUME_NONNULL_END
