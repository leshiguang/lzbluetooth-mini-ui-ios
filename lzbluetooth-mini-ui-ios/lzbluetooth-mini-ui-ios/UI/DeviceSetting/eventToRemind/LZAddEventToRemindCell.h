//
//  LZAddEventToRemindCell.h
//  LSBluetoothUI_iOS
//
//  Created by wm on 2020/12/9.
//

#import "LZBaseSetTableViewCell.h"
#import "LZAddEventToRemindCellModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol LZAddEventToRemindCellDelegate <NSObject>

- (void)switchOn:(BOOL)isOn cellModle:(LZAddEventToRemindCellModel *)cellModel;

@end

@interface LZAddEventToRemindCell : LZBaseSetTableViewCell

@property (nonatomic, weak) id <LZAddEventToRemindCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
