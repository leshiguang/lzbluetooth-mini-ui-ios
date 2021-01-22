//
//  LZBaseSetTableViewCell.h
//  LSBluetoothUI_iOS
//
//  Created by wm on 2020/12/8.
//

#import <UIKit/UIKit.h>
#import "LZBaseSetCellModel.h"
NS_ASSUME_NONNULL_BEGIN

@class LZBaseSetCellModel;

@protocol LZBaseSetTableViewCellDelegate <NSObject>

- (void)switchOn:(BOOL)isOn cellModle:(LZBaseSetCellModel *)cellModel;

@end

@interface LZBaseSetTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subContentLabel;
@property (nonatomic, strong) UIImageView *rightImage;
@property (nonatomic, strong) UISwitch *switchControl;
@property (nonatomic, strong) UIButton *unbindButton;
@property (nonatomic, strong) UIImageView *rightSelectImageView;

@property (nonatomic, strong) LZBaseSetCellModel *cellModel;


@property (nonatomic, weak, nullable) id <LZBaseSetTableViewCellDelegate> delegate;

- (void)createUI;
- (void)updateCellWithModel:(__kindof LZBaseSetCellModel *)cellModle;

@end

NS_ASSUME_NONNULL_END
