//
//  LZGoalSettingTableViewCell.h
//  LSBluetoothUI_iOS
//
//  Created by wm on 2020/12/9.
//

#import "LZBaseSetTableViewCell.h"
#import "LZGoalSetModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol LZGoalSettingTableViewCellDelegate <NSObject>

- (void)switchOn:(BOOL)isOn cellModle:(LZGoalSetModel *)cellModel;

@end

@interface LZGoalSettingTableViewCell : LZBaseSetTableViewCell
@property (nonatomic, weak) id <LZGoalSettingTableViewCellDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
