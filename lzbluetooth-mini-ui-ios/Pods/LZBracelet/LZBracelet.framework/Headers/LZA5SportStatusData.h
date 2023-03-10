//
//  LZA5SportStatusData.h
//  LZBluetooth
//
//  Created by tanjian on 2020/10/22.
//  手环发送运动模式状态到 APP(0xE1) 需要回复

#import <Foundation/Foundation.h>



#import <LZBracelet/LZBraceletMeasurementData.h>
#import <LZBracelet/LZA5CommonDefine.h>



NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, LZA5SportFunction) {
    /// 表示检测gps （用于手环发起运动）
    LZA5SportFunctionGPSCheck = 1,
    /// 运动状态 （用于手环端结束手机 App 运动）
    LZA5SportFunctionSportState = 2,
};

/// 运动状态
@interface LZA5SportStatusData : LZBraceletMeasurementData 
/// 功能项 01 表示 检测。 02 运动状态
@property (nonatomic, assign) LZA5SportFunction function;
/// 0x00:开始 （该指令被用于手环端发起运动）  0x01：结束（该指令用于手环端结束手机端运动）
@property (nonatomic, assign) UInt8 sportStatus;
/// 运动模式
@property (nonatomic, assign) LZA5SportMode sportMode;

@end

NS_ASSUME_NONNULL_END
