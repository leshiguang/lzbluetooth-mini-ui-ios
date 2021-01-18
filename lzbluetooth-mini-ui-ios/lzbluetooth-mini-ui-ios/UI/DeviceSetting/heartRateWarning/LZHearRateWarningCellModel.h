//
//  LZHearRateCellModel.h
//  LSBluetoothUI_iOS
//
//  Created by wm on 2020/12/9.
//

#import "LZBaseSetCellModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, LZHearRateWarningStyle) {
    LZHearRateWarningStyleSwitch,
    LZHearRateWarningStyleZone,
};


@interface LZHearRateWarningCellModel : LZBaseSetCellModel

@end

NS_ASSUME_NONNULL_END
