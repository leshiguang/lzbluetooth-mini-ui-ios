//
//  LZBaseSetTableViewCell.h
//  LSBluetoothUI_iOS
//
//  Created by wm on 2020/12/8.
//

#import <UIKit/UIKit.h>
#import "LZBaseSetCellModel.h"
NS_ASSUME_NONNULL_BEGIN


@interface LZBaseSetTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subContentLabel;
@property (nonatomic, strong) UIImageView *rightImage;
@property (nonatomic, strong) UISwitch *switchControl;
@property (nonatomic, strong) UIButton *unbindButton;
@property (nonatomic, strong) UIImageView *rightSelectImageView;

- (void)createUI;
- (void)updateCellWithModel:(__kindof LZBaseSetCellModel *)cellModle;

@end

NS_ASSUME_NONNULL_END
