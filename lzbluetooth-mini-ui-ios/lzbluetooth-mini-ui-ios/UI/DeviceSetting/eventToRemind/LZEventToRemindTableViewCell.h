//
//  LZEventToRemindTableViewCell.h
//  LSBluetoothUI_iOS
//
//  Created by wm on 2020/12/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LZEventToRemindTableViewCell : UITableViewCell
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UILabel *eventLabel;
@property (nonatomic,strong) UIImageView *delectImageView;

@end

NS_ASSUME_NONNULL_END
