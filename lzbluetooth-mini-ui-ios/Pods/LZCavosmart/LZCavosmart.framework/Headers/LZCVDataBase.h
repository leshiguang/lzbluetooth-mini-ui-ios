//
//  LZCVDataBase.h
//  LZCavosmart
//
//  Created by tanjian on 2022/8/17.
//

#import <Foundation/Foundation.h>
#import <LZBluetooth/LZDeviceSettingProtocol.h>
#import <LZBluetooth/LZDataProtocol.h>
#import <LZCavosmart/LZCVCommonDefine.h>
#import <LZBluetooth/LZMeasurementDataProtocol.h>

NS_ASSUME_NONNULL_BEGIN

/// 命令id
typedef NS_ENUM(NSUInteger, LZCVCommandId) {
    LZCVCommandIdSetting    = 0x02,
    LZCVCommandIdBind       = 0x03,
    LZCVCommandIdReminder   = 0x04,
    LZCVCommandIdData       = 0x05,
};

///
typedef NS_ENUM(NSUInteger, LZCVDataKey) {
    LZCVDataKeySyncHistoryData                  = 0x01,
    LZCVDataKeyStepHistory                      = 0x02,
    LZCVDataKeySleep                            = 0x03,
    LZCVDataKeySyncHistoryStart                 = 0x07,
    LZCVDataKeySyncHistoryFinish                = 0x08,
    LZCVDataKeyDailyData                        = 0x0b,
    LZCVDataKeyStep                             = 0x0c,
    LZCVDataKeyTestHRSwitch                     = 0x0d,
    LZCVDataKeySerialHRSwitch                   = 0x0e,
    LZCVDataKeyHR                               = 0x0f,
    LZCVDataKeyCancelHRTest                     = 0x10,
    LZCVDataKeyGetSerialHRSwitch                = 0x11,
    LZCVDataKeySerialHRSwitchConfig             = 0x12,
    LZCVDataKeyBPData                           = 0x13,
    LZCVDataKeyBloodPressureSwitch              = 0x14,
    LZCVDataKeyBPCancel                         = 0x15,
    LZCVDataKeySport                            = 0x16,
    LZCVDataKeyBatchHR                          = 0x1b,
    LZCVDataKeyFinishSyncHistoryData            = 0x1c,
    LZCVDataKeyTemperatureSwitch                = 0x20,
    LZCVDataKeyTemperatureSwitchBack            = 0x21,
    LZCVDataKeyTemperatureDisplaySwitch         = 0x22,
    LZCVDataKeyGetTemperatureDisplaySwitch      = 0x23,
    LZCVDataKeyTemperatureDisplaySwitchConfig   = 0x24,
    LZCVDataKeyBloodPressureDisplaySwitch       = 0x25,
    LZCVDataKeyGetBloodPressureDisplaySwitch    = 0x26,
    LZCVDataKeyBloodPressureDisplaySwitchConfig = 0x27,
    LZCVDataKeyTemperatureHR                    = 0x29,
    
};

typedef NS_ENUM(NSUInteger, LZCVBindKey) {
    LZCVBindKeyBindReq          = 0x01,
    LZCVBindKeyBindResp         = 0x02,
    LZCVBindKeyLoginReq         = 0x03,
    LZCVBindKeyLoginResp        = 0x04,
    LZCVBindKeyCancelBindReq    = 0x05,

};

typedef NS_ENUM(NSUInteger, LZCVSettingKey) {
    LZCVSettingKeyTime              = 0x01,
    LZCVSettingKeyClock             = 0x02,
    LZCVSettingKeyGetClock          = 0x03,
    LZCVSettingKeyClockConfig       = 0x04,
    LZCVSettingKeyStepEncourage     = 0x05,
    LZCVSettingKeyCalorieEncourage  = 0x07,
    LZCVSettingKeyProfile           = 0x10,
    LZCVSettingKeyLongSit           = 0x21,
    LZCVSettingKeyPlatform          = 0x23,
    LZCVSettingKeyMsgReminder       = 0x25,
    LZCVSettingKeyGetLongSit        = 0x26,
    LZCVSettingKeyLongSitConfig     = 0x27,
    LZCVSettingKeyRaise             = 0x2a,
    LZCVSettingKeyGetRaise          = 0x2b,
    LZCVSettingKeyRaiseConfig       = 0x2c,
    LZCVSettingKeyDial              = 0x38,
    LZCVSettingKeyGetDial           = 0x39,
    LZCVSettingKeyDialConfig        = 0x3a,
    LZCVSettingKeyTimeFormat        = 0x41,
    LZCVSettingKeyGetTimeFormat     = 0x42,
    LZCVSettingKeyTimeFormatConfig  = 0x43,
    LZCVSettingKeyLanguag           = 0x4e,
    LZCVSettingKeyGetLanguag        = 0x4f,
    LZCVSettingKeyLanguagConfig     = 0x50,
};

typedef NS_ENUM(NSUInteger, LZCVReminderKey) {
    LZCVReminderKeyCallReminder = 0x01,
    LZCVReminderKeyCallListner  = 0x02,
    LZCVReminderKeyCallRefuse   = 0x03,
    
    LZCVReminderKeyCharging     = 0x06,
//    LZCVReminderKeyPairInfo     = 0x10,
//    LZCVReminderKeyPairState    = 0x11,
//    LZCVReminderKeyANCSCallInfo = 0x12,

};

@interface LZCVDataBase : NSObject <LZEncodeDataProtocol, LZDecodeDataProtocol, LZMeasurementDataProtocol, LZDeviceSettingProtocol>

/// 命令分类
@property (nonatomic, assign) NSUInteger commandId;


/// 作为发送数据时的key
@property (nonatomic, assign) NSUInteger key;


/// 作为接受数据时的key
@property (nonatomic, assign) UInt32 tag;

+ (instancetype)dataWithComandId:(NSUInteger)commandId key:(NSUInteger)key;

@end


NS_ASSUME_NONNULL_END
