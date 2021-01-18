//
//  LZWearingHabitsModel.h
//  LSBluetoothUI_iOS
//
//  Created by wm on 2020/12/11.
//

#import "LZBaseSetCellModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, LZWearingHabitsSetType) {
    LZWearingHabitsSetTypeleftHand,
    LZWearingHabitsSetTypeRightHand,
};

@interface LZWearingHabitsModel : LZBaseSetCellModel

@end

NS_ASSUME_NONNULL_END
