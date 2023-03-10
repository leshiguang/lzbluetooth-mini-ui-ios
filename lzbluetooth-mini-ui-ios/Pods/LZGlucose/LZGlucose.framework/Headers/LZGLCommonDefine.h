//
//  LZGLCommonDefine.h
//  LZGlucose
//
//  Created by tanjian on 2023/2/8.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSUInteger, LZGLMeasurementType) {
    LZGLMeasurementTypeRecord = 0x12, // 仪器状态和测量结果
    LZGLMeasurementTypeFinish = 0xd1, // 历史记录结束
    LZGLMeasurementTypeCloseBle = 0xd2, // 关闭蓝牙
    LZGLMeasurementTypeTime = 0x44, // 时间设置和读取
    LZGLMeasurementTypeSoftwareVersion = 0x66, // 软件版本读取
    LZGLMeasurementTypeSn = 0x77, // sn号读写
    LZGLMeasurementTypeHistory = 0xdd, // 客户端读取历史
    LZGLMeasurementTypeUnit = 0xaa, // 浓度单位读取
};

