//
//  LZDialSetCollectionViewCell.h
//  LSBluetoothUI_iOS
//
//  Created by wm on 2020/12/8.
//

#import <UIKit/UIKit.h>
#import "LZDialSetModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LZDialSetCollectionViewCell : UICollectionViewCell

- (void)updateCellWithLZDiaSetModel:(LZDialSetModel *)model;

@end

NS_ASSUME_NONNULL_END
