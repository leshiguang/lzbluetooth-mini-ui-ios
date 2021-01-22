//
//  LZInputStringTableViewCell.h
//  lzbluetooth-mini-ui-ios
//
//  Created by tanjian on 2021/1/22.
//

#import "LZBaseSetTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@protocol LZInputStringTableViewCellDelegate <LZBaseSetTableViewCellDelegate>

- (void)inputTableViewCellDidInputString:(NSString *)string cellModle:(LZBaseSetCellModel *)cellModel;

@end

@interface LZInputStringTableViewCell : LZBaseSetTableViewCell

@property (nonatomic, weak, nullable) id<LZInputStringTableViewCellDelegate> delegate;

@property (nonatomic, strong) UITextField *textField;

@end

NS_ASSUME_NONNULL_END
