//
//  LZGoalSetModel.h
//  LSBluetoothUI_iOS
//
//  Created by wm on 2020/12/9.
//

#import "LZBaseSetCellModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    LZGOALSETTYPE_GOALSWITCH,   //目标开关
    LZGOALSETTYPE_GOALTYPE,     //目标类型
    LZGOALSETTYPE_GOALTNUM,     //目标值
} LZGOALSETTYPE;

@interface LZGoalSetModel : LZBaseSetCellModel

@end

NS_ASSUME_NONNULL_END
