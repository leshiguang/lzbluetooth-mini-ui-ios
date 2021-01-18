//
//  LZDeviceSettingEditTableViewCell.h
//  LSBluetoothUI_iOS
//
//  Created by wm on 2020/12/3.
//

#import <UIKit/UIKit.h>
#import "LZScreenContentModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LZScreenContentCell : UITableViewCell

- (void)updateCellWithModel:(LZScreenContentModel *)model;

@end

NS_ASSUME_NONNULL_END
