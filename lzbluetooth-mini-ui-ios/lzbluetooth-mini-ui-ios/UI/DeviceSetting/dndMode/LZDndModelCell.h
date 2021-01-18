//
//  LZDndModelCell.h
//  LSBluetoothUI_iOS
//
//  Created by wm on 2020/12/10.
//

#import "LZBaseSetTableViewCell.h"
#import "LZDndModelCellModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol LZDndModelCellModelDelegate <NSObject>

- (void)switchOn:(BOOL)isOn cellModel:(LZDndModelCellModel *)cellModel;

@end


@interface LZDndModelCell : LZBaseSetTableViewCell

@property (nonatomic, weak) id <LZDndModelCellModelDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
