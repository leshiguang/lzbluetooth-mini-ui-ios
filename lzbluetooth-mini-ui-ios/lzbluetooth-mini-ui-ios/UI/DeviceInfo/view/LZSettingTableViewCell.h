//
//  LZSettingTableViewCell.h
//  LSBluetoothUI_iOS
//
//  Created by wm on 2020/12/2.
//

#import <UIKit/UIKit.h>
#import "LZSettingCellModel.h"
#import "LZBaseSetTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@protocol LZSettingTableViewCellDelegate <NSObject>

- (void)switchOn:(BOOL)isOn cellModle:(LZSettingCellModel *)cellModel;

- (void)unbindClick:(LZSettingCellModel *)cellModel;

@end

@interface LZSettingTableViewCell : LZBaseSetTableViewCell

@property (nonatomic, weak) id <LZSettingTableViewCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
