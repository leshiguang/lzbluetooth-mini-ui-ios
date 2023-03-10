//
//  LZA5DialTypeDatas.h
//  LZBluetooth
//
//  Created by tanjian on 2021/11/12.
//




#import <LZBracelet/LZA5SettingData.h>


NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, LZPushDialStatus) {
    /**
    * 资源已发送    app->dev
    */
    LZPushDialStatusDidSend = 1,

    /**
     * 资源校验成功    dev -> app
    */
    LZPushDialStatusChecked = 2,

    /**
     * 资源检验失败  dev -> app
    */
    LZPushDialStatusCheckFailed = 3,

    /**
     * 开始安装表盘  dev -> app
    */
    LZPushDialStatusStartInstall = 4,
    /**
     * 安装成功
    */
    LZPushDialStatusInstallSuccess = 5,
    /**
     * 安装失败
    */
    LZPushDialStatusInstallFailed = 6,
    /**
     * 取消安装
    */
    LZPushDialStatusCancelPush = 7,
    /**
     * 确定取消安装
    */
    LZPushDialStatusConfirmCancelPush = 8,
};

@interface LZA5SettingDialEnableData : LZA5SettingData

@property (nonatomic, strong) NSArray <NSNumber *> *list;
@property (nonatomic, assign) UInt32 dialIndex;

@end

@interface LZA5SettingGetDialSettingData : LZA5SettingData

@property (nonatomic, assign) UInt32 dialIndex;

@end

@interface LZA5SettingPushDialData : LZA5SettingData


/// 0x01～0x07，当前只支持0x07。表示推动表盘的位置，如果该位置非空，则表示替换，否则表示新增。
@property (nonatomic, assign) UInt32 dialIndex;

/// 表盘唯一id 用ASCII表示 最大32字节
@property (nonatomic, strong) NSString *id;

/// * 0: 在线表盘
/// * 1: 相册表盘
/// * 2: 本地表盘
@property (nonatomic, assign) UInt32 dialType;

/// 文件名 所占用的byte数最大32字节
@property (nonatomic, strong, nullable) NSString *fileName;

/// 背景图名称长度 最大32字节
@property (nonatomic, strong) NSString *backgroundImageName;

/// 文件数据
@property (nonatomic, strong) NSData *fileBuf;

/// 发送进度
@property (nonatomic, strong) LZOtaProgress progress;

/// 样式id 0～7，用来描述表盘元素的显示内容和显示方式目前 相册表盘 有7个固定样式 460相册表盘有效
@property (nonatomic, assign) UInt32 styleId;

/// 暂时无用，不用设置
@property (nonatomic, assign) UInt32 colorId;

@end

@interface LZA5SettingSyncDialPushStatusData : LZA5SettingData

@property (nonatomic, assign) LZPushDialStatus status;

@end





NS_ASSUME_NONNULL_END
