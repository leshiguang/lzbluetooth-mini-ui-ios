//
//  LZHeartRateCell.h
//  LSBluetoothUI_iOS
//
//  Created by wm on 2020/12/9.
//

#import "LZBaseSetTableViewCell.h"
#import "LZHearRateWarningCellModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol LZHeartRateWarningCellDelegate <NSObject>

- (void)switchOn:(BOOL)isOn cellModle:(LZHearRateWarningCellModel *)cellModel;

@end

@interface LZHeartRateWarningCell : LZBaseSetTableViewCell

@property (nonatomic, weak) id <LZHeartRateWarningCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
