//
//  LZSettingTableViewCell.h
//  LSBluetoothUI_iOS
//
//  Created by wm on 2020/12/2.
//

#import <UIKit/UIKit.h>
#import "LZBaseSetTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@protocol LZSettingTableViewCellDelegate <LZBaseSetTableViewCellDelegate>

- (void)unbindClick:(LZBaseSetCellModel *)cellModel;

@end

@interface LZSettingTableViewCell : LZBaseSetTableViewCell

@property (nonatomic, weak) id<LZSettingTableViewCellDelegate> delegate;


@end

NS_ASSUME_NONNULL_END
