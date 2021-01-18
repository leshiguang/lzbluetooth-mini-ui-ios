//
//  LZMessageToRemindCell.h
//  LSBluetoothUI_iOS
//
//  Created by wm on 2020/12/10.
//

#import "LZBaseSetTableViewCell.h"
#import "LZMessageToRemindCellModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol LZMessageToRemindCellDelegate <NSObject>

- (void)switchOn:(BOOL)isOn cellModle:(LZMessageToRemindCellModel *)cellModel;

@end

@interface LZMessageToRemindCell : LZBaseSetTableViewCell

@property (nonatomic, weak) id <LZMessageToRemindCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
