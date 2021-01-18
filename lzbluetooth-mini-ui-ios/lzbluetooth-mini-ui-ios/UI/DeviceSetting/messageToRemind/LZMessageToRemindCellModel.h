//
//  LZMessageToRemindCellModel.h
//  LSBluetoothUI_iOS
//
//  Created by wm on 2020/12/10.
//

#import "LZBaseSetCellModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, LZMessageToRemindCellSetTpye) {
    LZMessageToRemindCellSetTpyeWechat,
    LZMessageToRemindCellSetTpyeQQ,
    LZMessageToRemindCellSetTpyeMessage,
};

@interface LZMessageToRemindCellModel : LZBaseSetCellModel

@end

NS_ASSUME_NONNULL_END
