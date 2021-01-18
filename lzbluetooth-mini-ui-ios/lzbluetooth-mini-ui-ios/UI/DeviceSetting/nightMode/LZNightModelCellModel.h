//
//  LZNightModelCellModel.h
//  LSBluetoothUI_iOS
//
//  Created by wm on 2020/12/10.
//

#import "LZBaseSetCellModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, LZNightModelSetType) {
    LZNightModelSetTypeSwitch,
    LZNightModelSetTypeStartTime,
    LZNightModelSetTypeEndTime,
};

@interface LZNightModelCellModel : LZBaseSetCellModel

@end

NS_ASSUME_NONNULL_END
