//
//  LZBluetoothDefine.h
//  LZBluetooth
//
//  Created by tanjian on 2020/9/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 蓝牙状态
typedef NS_ENUM(NSUInteger, LZBluetoothState) {
    LZBluetoothStateUnknown = 0,
    /// 正在重置
    LZBluetoothStateResetting,
    /// 不支持
    LZBluetoothStateUnsupported,
    /// 未授权
    LZBluetoothStateUnauthorized,
    /// 关闭
    LZBluetoothStatePoweredOff,
    /// 打开
    LZBluetoothStatePoweredOn,
};

/// 设置数据类型 2.0.0以上直接使用各个库里面的定义
//typedef NS_ENUM(NSUInteger, LZDeviceSettingType) {
//    /// 未定义 一般情况下外部不能使用未定义的
//    LZDeviceSettingTypeUndefine = 0,
//
//    /// 消息提醒
//    LZDeviceSettingTypeMsgReminder = 0xb6,
//    /// 自动识别
//    LZDeviceSettingTypeAutoRecognitionSport = 0xA2,
//    /// 闹钟
//    LZDeviceSettingTypeAlarmClock = 0x69,
//    /// 表盘
//    LZDeviceSettingTypeDial = 0xa1,
//    /// 佩戴方式
//    LZDeviceSettingTypeScreenDirection = 0x7d,
//    /// 事件提醒（带标签的闹钟提醒）
//    LZDeviceSettingTypeEventReminder = 0xa3,
//    /// 自定义运动心率区间提醒（心率预警）
//    LZDeviceSettingTypeCustomSportHrReminder = 0xa8,
//    /// 心率区间
//    LZDeviceSettingTypeHrSection = 0x74,
//    /// 智能心率检测开关设置
//    LZDeviceSettingTypeSmartHrDetection = 0x76,
//    /// 心率开关
//    LZDeviceSettingTypeHrDetection = 0x6d,
//    /// 语言
//    LZDeviceSettingTypeLanguage = 0xaa,
//    /// 久坐提醒
//    LZDeviceSettingTypeSedentaryRemainder = 0x6e,
//    /// 防丢
//    LZDeviceSettingTypeLost = 0x6f,
//    /// 夜间模式
//    LZDeviceSettingTypeNightMode = 0x77,
//    /// 自定义屏幕
//    LZDeviceSettingTypeCustomScreen = 0x7e,
//    /// 勿扰模式
//    LZDeviceSettingTypeNoDisturb = 0xb3,
//    /// 运动控制
//    LZDeviceSettingTypeSportControl = 0xaf,
//    /// 运动心率区间
//    LZDeviceSettingTypeSportHrSection = 0x71,
//    /// 运动设置（配速与距离设置）
//    LZDeviceSettingTypePaceAndDistance = 0xab,
//    /// 步数目标
//    LZDeviceSettingTypeStepEncourage = 0x70,
//    /// 游泳
//    LZDeviceSettingTypeSwiming = 0xac,
//    /// 目标设置
//    LZDeviceSettingTypeTargetEncourage = 0xa5,
//    /// 时间模式
//    LZDeviceSettingTypeTimeMode = 0x79,
//    /// 佩戴方式
//    LZDeviceSettingTypeWristHabit = 0x7a,
//    /// 天气
//    LZDeviceSettingTypeWeather = 0xa6,
//    /// 单位
//    LZDeviceSettingTypeUnit = 0x78,
//
//    /// 实时心率
//    LZDeviceSettingTypeRealtimeHR = 0xfff9,
//
//    /// 体脂秤心率开关
//    LZDeviceSettingTypeScaleHR = 0x1007,
//    /// 体重单位
//    LZDeviceSettingTypeScaleUnit = 0x1004,
//    /// wifi 配网
//    LZDeviceSettingTypeWifiScan = 0x100000,
//    /// wifi 配置网络
//    LZDeviceSettingTypeWifiConnect = 0x100001,
//    /// wifi 重制
//    LZDeviceSettingTypeWifiReset = 0x100007,
//    /// 获取wifi 状态
//    LZDeviceSettingTypeWifiStatus = 0x100006,
//
//    /// 发送文件
//    LZDeviceSettingTypeSendFile = 0xffff0000,
//
//    /// 药盒相关
//    LZDeviceSettingTypeBoxTiming = 0x07000000,
//    LZDeviceSettingTypeBoxFind = 0x07000001,
//    LZDeviceSettingTypeBoxSyncData = 0x07000002,
//
//    // 跳绳相关
//    LZDeviceSettingTypeJumpBegin = 0x08000000,
//    LZDeviceSettingTypeJumpEnd = 0x08000001,
//    LZDeviceSettingTypeMioSyncTime = 0x08000002,
//
//};

typedef NSUInteger LZDeviceSettingType;
extern LZDeviceSettingType LZDeviceSettingTypeUndefine;
extern LZDeviceSettingType LZDeviceSettingTypeSendFile;

typedef NSUInteger LZMeasurementDataType;
extern LZMeasurementDataType LZMeasurementDataTypeUndefine;

///// 测量数据类型  2.0.0以上直接使用各个库里面的定义
//typedef NS_ENUM(NSUInteger, LZMeasurementDataType) {
//    /// 未定义 一般情况下外部不能使用未定义的
//    LZMeasurementDataTypeUndefine = 0,
//
//    /// 每天测量数据 参考 LZA5DayData
//    LZBraceletMeasurementDataTypeDay = 0x51,
//    /// 睡眠压缩数据 参考 LZA5SleepData
//    LZBraceletMeasurementDataTypeSleep = 0x52,
//    /// 心率数据 参考 LZA5HeartRateData
//    LZBraceletMeasurementDataTypeHeartRate = 0x53,
//    /// 每小时数据 参考 LZA5DayData
//    LZBraceletMeasurementDataTypeHour = 0x57,
//    /// 跑步状态数据 参考 LZA5RunStateData
//    LZBraceletMeasurementDataTypeRunState = 0x72,
//    /// 跑步心率数据 参考 LZA5HeartRateData
//    /// 跑步心率
////    LZBraceletMeasurementDataTypeRunHeartRate = 0x73,
//    /// 心率统计 参考 LZA5HeatrateSectionData
//    LZBraceletMeasurementDataTypeHrSection = 0x75,
//    /// 跑步卡路里数据 参考 LZA5SportCaloriesData
//    LZBraceletMeasurementDataTypeRunCalories = 0x7f,
//    /// 运动模式状态 参考 LZA5SportStatusData
//    LZBraceletMeasurementDataTypeSportStatus = 0xe1,
//    /// 运动报告 参考 LZA5SportReportData
//    LZBraceletMeasurementDataTypeSportReport = 0xe2,
//    /// 运动配速 参考 LZA5SportPaceData
//    LZBraceletMeasurementDataTypeSportPace = 0xe4,
//    /// 运动心率 参考 LZA5HeartRateData
//    LZBraceletMeasurementDataTypeSportHeartRate = 0xe5,
//    /// 运动卡路里 参考 LZA5SportCaloriesData
//    LZBraceletMeasurementDataTypeSportCalories = 0xe6,
//    /// 实时心率 参考 LZA5HeartRateData
//    LZBraceletMeasurementDataTypeRealTimeHR = 0xfff9,
//
//    /// 456 add
//    /// 闹钟开关数据
//    LZBraceletMeasurementDataTypeClockSwitch = 0xff01,
//    /// 闹钟提醒
//    LZBraceletMeasurementDataTypeEventReminder = 0xff02,
//    /// 睡眠报告
//    LZBraceletMeasurementDataTypeEventSleepreport = 0xff82,
//    /// 血氧数据
//    LZBraceletMeasurementDataTypeBloodOxygen = 0xff03,
//    /// 结束符
//    LZBraceletMeasurementDataTypeFinish = 0xff04,
//    /// 设置数据
//    LZBraceletMeasurementDataTypeMutipleSetting = 0xff05,
//    /// 静息心率 LZA5RestingHeartRateData
//    LZBraceletMeasurementDataTypeRestingHeartRateData = 0xff06,
//
//
//    /// 体重数据 对应 LZA6MeasurementData
//    LZScaleMeasurementTypeWeight = 0x4802,
//    /// 体重单位 对应 LZA6UnitSettingData
//    LZScaleMeasurementTypeUnit = 0x1004,
//    /// wifi 数据 对应 LZWifiData
//    LZDeviceMeasurementTypeWifi = 0x101000,
//
//
//    /// 血压数据 对应 LZA6BpMeasurementData
//    LZBPMeasurementTypeBp = 0x4902,
//
//    /// 跳绳实时数据
//    LZMioMeasurementTypeRealtimeData = 0x07000000,
//    /// 结果数据
//    LZMioMeasurementTypeResultData = 0x07000001,
//
//    /// 药盒数据
//    LZMcuMeasurementTypeBoxData = 0x08000000,
//    /// 设备信息
//    LZMcuMeasurementTypeDeviceInfo = 0x08000001,
//};

/// 蓝牙协议
typedef NS_OPTIONS(NSUInteger, LZProtocolType) {
    /// 未知
    LZProtocolTypeUnknow = 0,
    /// a5协议
    LZProtocolTypeA5 = 1 << 1,
    /// a6协议
    LZProtocolTypeA6 = 1 << 2,
    /// oas协议
    LZProtocolTypeOAS API_DEPRECATED_WITH_REPLACEMENT("废弃", ios(2.0, 7.0)) = 1 << 3,
    /// 药盒协议
    LZProtocolTypeMcu = 1 << 4,
    /// 跳绳协议
    LZProtocolTypeMio = 1 << 5,
    /// 
    /// 所有的协议
    LZProtocolTypeAll API_DEPRECATED_WITH_REPLACEMENT("废弃", ios(2.0, 7.0)) = LZProtocolTypeA5 | LZProtocolTypeA6 | LZProtocolTypeMcu | LZProtocolTypeMio,
};

/// 设备类型
typedef NS_ENUM(NSUInteger, LZDeviceType) {
    /// 未知
    LZDeviceUnknow,
    /// 手环
    LZDeviceTypeBracelet = 1,
    /// 体脂秤
    LZDeviceTypeScale = 2,
    /// 血压计
    LZDeviceTypeBloodPressure = 3,
    /// 手表
    LZDeviceTypeWatch = 4,
    /// alice 手环
    LZDeviceTypeAlice API_DEPRECATED_WITH_REPLACEMENT("废弃", ios(2.0, 7.0)) = 5,
    /// 血糖设备
    LZDeviceTypeGlu API_DEPRECATED_WITH_REPLACEMENT("废弃", ios(2.0, 7.0)) = 6,
    /// 跳绳
    LZDeviceTypeMio = 7,
    /// 药盒
    LZDeviceTypeMcu = 8,
    
    /// 迦沃
    LZDeviceTypeCavo = 9,
    
    /// 血糖仪
    LZDeviceTypeG3 = 10,
};

/// 连接状态
typedef NS_ENUM(NSUInteger, LZDeviceConnectStatus) {
    /// 未连接
    LZDeviceConnectStatusDisconnected,
    /// 正在连接中
    LZDeviceConnectStatusConnecting,
    /// 已连接
    LZDeviceConnectStatusConnected,
    /// 正在断开连接中
    LZDeviceConnectStatusDisconnecting,
};

/// 扫描时的工作状态
typedef NS_ENUM(NSUInteger, LZBluetoothScanWorkMode) {
    /// 计时器触发的自动扫描
    LZBluetoothScanWorkModeAuto,
    /// 手动调用扫描的时候
    LZBluetoothScanWorkModeManual,
};

typedef NS_ENUM(NSUInteger, LZBindState) {
    /// 输入随机数 (返回此状态,用户需要调用inputRandomCode:macString:的用户绑定手环校验随机码接口)
    LZBindStateInputRandomNumber,
    /// 未注册通知  体重的乐心互联才有 (这里 在1.6.4之后由sdk内部去申请，所以不会再有这个回调了)
    LZBindStateUnregister API_DEPRECATED_WITH_REPLACEMENT("1.6.4之后由sdk内部去申请，外边不需要监听该状态", ios(2.0, 7.0)),
    /// 请输入用户编号和绑定结果 /A6
    LZBindStateInputUserNumberAndBindResult API_DEPRECATED_WITH_REPLACEMENT("2.0.0版本的时候我们在sdk内部处理", ios(2.0, 7.0)),
    /// 绑定成功
    LZBindStateSuccessful = 4,
    /// 绑定失败
    LZBindStateFailure = 5,
    /// 鉴权失败
    LZBindStateAuthorizeFailure = 6,
    /// 输入随机码错误 (报这个错误是可以继续输入正确的随机码)
    LZBindStateInputRandomNumberError = 7,
    /// 获取ctei错误
    LZBindStateGetCTEIError = 8,
    /// 用户取消
    LZBindStateUserCanceled = 9,
    /// 需要提示用户去点击手环上出现的按钮
    LZBindStateAwaitUserConfirm = 10,

};

/// 工作模式
typedef NS_ENUM(NSUInteger, LZWorkMode) {
    /// 需要断开链接
    LZWorkModeNormal = 0,
    /// 已绑定的流程
    LZWorkModeBinded = 1,
    /// 进入绑定中
    LZWorkModeBinding,
    /// ota模式
    LZWorkModeOta,
};

typedef NS_ENUM(NSUInteger, LZBluetoothErrorCode) {
    /// 没有错误
    LZBluetoothErrorCodeSuccess = 0,
    /// 未连接
    LZBluetoothErrorCodeDisconnect = 1,
    /// 没有服务特征
    LZBluetoothErrorCodeNoCharacteristic = 2,
    /// 设备回ack报错
    LZBluetoothErrorCodeTimeout = 3,
    /// 丢弃或者取消
    LZBluetoothErrorCodeDiscarded = 4,
    /// 协议ack报错
    LZBluetoothErrorCodeACKError = 5,
    /// 蓝牙库报的错误
    LZBluetoothErrorCodeBluetoothError = 6,
    /// 工作繁忙，比如ota升级
    LZBluetoothErrorCodeWorkingBusy = 7,
    /// ota文件不支持
    LZBluetoothErrorCodeFileUnsupported = 8,
    /// 低电量
    LZBluetoothErrorCodeLowBattery = 9,
    /// 不支持类型
    LZBluetoothErrorCodeUnsupported = 10,
    /// 鉴权失败
    LZBluetoothErrorCodeAuthorizeFailure = 11,
    /// 未找到设备
    LZBluetoothErrorCodeNotFind = 12,
    /// 用户取消了绑定
    LZBluetoothErrorCodeCancelBind = 13,
    /// 参数错误
    LZBluetoothErrorCodeAlreadyBinded = 14,
    /// 参数错误
    LZBluetoothErrorCodeParamsError = 15,
    /// 没有内存
    LZBluetoothErrorCodeNoMember = 16,
    /// 文件太大
    LZBluetoothErrorCodeTooBig = 17,
    /// 未初始化
    LZBluetoothErrorCodeNotInit = 18,

    /// 未知错误
    LZBluetoothErrorCodeUnknow = 9999,
};

/// 获取setting类名
extern NSString *lz_deviceSettingClass(LZDeviceSettingType settingType) API_DEPRECATED_WITH_REPLACEMENT("2.0.0之后不再维护此版本", ios(2.0, 7.0));


@class LZBaseDevice;

/// 发送数据回调
typedef void(^LZSendDataCompletion)(LZBluetoothErrorCode result, id _Nullable response);
typedef void(^LZDeviceHandlerCompletion)(LZBluetoothErrorCode errorCode);
typedef void(^LZReadMacCompletion)(NSString *_Nullable mac, LZBluetoothErrorCode errorCode);
typedef void(^LZDeviceReadCharValueCompletion)(NSData * _Nullable data, LZBluetoothErrorCode errorCode);
typedef void(^LZOtaProgress)(double progress);

typedef void(^LZFindDeviceCompletion)(__kindof LZBaseDevice *_Nullable device, LZBluetoothErrorCode errorCode);
typedef void(^LZSearchResultBlock)(__kindof LZBaseDevice *device);
typedef void(^LZBindDeviceBlock)(LZBaseDevice * _Nullable device, LZBindState bindState);

@class LZResponse;
typedef void(^LZCompletion)(LZResponse *response);

/// 蓝牙错误Domain
extern NSErrorDomain const LZBluetoothErrorDomain;
extern NSString *lz_errString(LZBluetoothErrorCode errorCode);

/// 设备信息所使用的key
typedef NSString *kLZBluetoothDeviceInfoKey;

/// 设备id
extern kLZBluetoothDeviceInfoKey const kLZBluetoothDeviceInfoKeySystemID;
/// 实际产品型号
extern kLZBluetoothDeviceInfoKey const kLZBluetoothDeviceInfoKeyModelName;
/// MAC 地址
extern kLZBluetoothDeviceInfoKey const kLZBluetoothDeviceInfoKeyMacAddress;
///固件版本“*XXX” 其中第一个“*”代表下面其中的之一 “S”表示正式版， “T”表示测试版， “X”表示内测版， “XXX”是数字，表示版本号
extern kLZBluetoothDeviceInfoKey const kLZBluetoothDeviceInfoKeyFirmwareVersion;
/// 硬件版本
extern kLZBluetoothDeviceInfoKey const kLZBluetoothDeviceInfoKeyHardwareVersion;
/// 固件版本
extern kLZBluetoothDeviceInfoKey const kLZBluetoothDeviceInfoKeySoftwareVersion;
/// 制造商
extern kLZBluetoothDeviceInfoKey const kLZBluetoothDeviceInfoKeyManufacturerName;
/// 厂商id 只有a6设备 才有
extern kLZBluetoothDeviceInfoKey const kLZBluetoothDeviceInfoKeyManufactureId;
/// 算法版本
extern kLZBluetoothDeviceInfoKey const kLZBluetoothDeviceInfoKeyAlgorithmVersion;
/// 设备信息服务id
extern NSString * const LZDeviceInfoServiceUuid;


NS_ASSUME_NONNULL_END
