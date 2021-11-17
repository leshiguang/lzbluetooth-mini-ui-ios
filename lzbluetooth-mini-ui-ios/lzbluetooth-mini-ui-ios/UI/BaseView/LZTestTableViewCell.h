//
//  LZTestTableViewCell.h
//  lzbluetooth-mini-ui-ios
//
//  Created by tanjian on 2021/11/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LZTestTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *getButton;
@property (weak, nonatomic) IBOutlet UIButton *setButton;

@end

NS_ASSUME_NONNULL_END
