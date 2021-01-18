//
//  LZSettingCellModel.h
//  LSBluetoothUI_iOS
//
//  Created by wm on 2020/12/2.
//

#import <Foundation/Foundation.h>
#import "LZBaseSetCellModel.h"
#import <LZBluetooth/LZBluetooth.h>

NS_ASSUME_NONNULL_BEGIN

//设置类型
typedef enum : NSUInteger {
    DEVICESETTYPE_DEVICE_NAME,                          //设备名称
    DEVICESETTYPE_MAC,                                  //MAC地址
    DEVICESETTYPE_FOTA, //固件升级
    DEVICESETTYPE_UNBIND, //解除绑定
} DEVICESETTYPE;

@interface LZSettingCellModel : LZBaseSetCellModel

@end


NS_ASSUME_NONNULL_END
