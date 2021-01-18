//
//  LZSettingCellModel.h
//  LSBluetoothUI_iOS
//
//  Created by wm on 2020/12/2.
//

#import <Foundation/Foundation.h>
#import "LZBaseSetCellModel.h"

NS_ASSUME_NONNULL_BEGIN

//设置类型
typedef enum : NSUInteger {
    DEVICESETTYPE_DEVICE_NAME,                          //设备名称
    DEVICESETTYPE_MAC,                                  //MAC地址
    DEVICESETTYPE_PHONE_CALL_REMINDING,                 //来电提醒
    DEVICESETTYPE_DIAL_SET,                             //表盘设置
    DEVICESETTYPE_GOAL_SETTING, //目标设置
    DEVICESETTYPE_EVENT_TO_REMIND, //事件提醒
    DEVICESETTYPE_HEART_RATE_WARNING, //心率预警
    DEVICESETTYPE_HEART_RATE__MONITOR, //心率监测
    DEVICESETTYPE_MESSAGE_TO_REMIND, //消息提醒
    DEVICESETTYPE_NIGHT_MODE, //夜间模式
    DEVICESETTYPE_DND_MODE, //勿扰模式
    DEVICESETTYPE_SCREEN_ORIENTATION, //屏幕方向
    DEVICESETTYPE_SPORT_TYPE, //运动类型
    DEVICESETTYPE_SCREEN_CONTENT, //屏幕内容
    DEVICESETTYPE_TIME_FORMAT, //时间制式
    DEVICESETTYPE_WEARING_HABITS, //佩戴习惯
    DEVICESETTYPE_FOTA, //固件升级
    DEVICESETTYPE_UNBIND, //解除绑定
} DEVICESETTYPE;

@interface LZSettingCellModel : LZBaseSetCellModel

@end


NS_ASSUME_NONNULL_END
