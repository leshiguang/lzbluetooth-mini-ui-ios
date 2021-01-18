//
//  LZDndModelCellModel.h
//  LSBluetoothUI_iOS
//
//  Created by wm on 2020/12/10.
//

#import "LZBaseSetCellModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, LZDndModelSetType) {
    LZDndModelSetTypeDndSwitch,
    LZDndModelSetTypeRaisedhandAgainstTheLight,
    LZDndModelSetTypeStartTime,
    LZDndModelSetTypeEndTime
};

@interface LZDndModelCellModel : LZBaseSetCellModel

@end

NS_ASSUME_NONNULL_END
