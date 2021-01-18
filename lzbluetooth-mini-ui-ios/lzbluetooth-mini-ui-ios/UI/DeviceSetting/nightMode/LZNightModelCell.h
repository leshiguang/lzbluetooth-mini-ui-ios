//
//  LZNightModelCell.h
//  LSBluetoothUI_iOS
//
//  Created by wm on 2020/12/10.
//

#import "LZBaseSetTableViewCell.h"
#import "LZNightModelCellModel.h"

@protocol LZNightModelCellModelDelegate <NSObject>

- (void)switchOn:(BOOL)isOn cellModle:(LZNightModelCellModel *_Nonnull)cellModel;

@end

NS_ASSUME_NONNULL_BEGIN

@interface LZNightModelCell : LZBaseSetTableViewCell

@property (nonatomic, weak) id <LZNightModelCellModelDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
