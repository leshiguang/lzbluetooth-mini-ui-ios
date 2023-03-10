//
//  LZA5SettingSportControlData.h
//  LZBluetooth
//
//  Created by tanjian on 2020/10/22.
//  申请发起/结束运动(0xAF)

#import <Foundation/Foundation.h>



#import <LZBracelet/LZA5SettingData.h>

NS_ASSUME_NONNULL_BEGIN

/// 申请发起/结束任务
@interface LZA5SettingSportControlData : LZA5SettingData
/// 参考运动模式 LZA5SportMode
@property (nonatomic, assign) LZA5SportMode sportMode;
/// 开始（true）结束（false）
@property (nonatomic, assign) BOOL start;

@end

NS_ASSUME_NONNULL_END
