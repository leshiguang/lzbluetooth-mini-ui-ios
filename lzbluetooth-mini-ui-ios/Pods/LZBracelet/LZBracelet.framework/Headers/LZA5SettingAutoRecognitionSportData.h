//
//  LZA5SettingAutoRecognitionSportData.h
//  LZBluetooth
//
//  Created by tanjian on 2020/10/22.
//  自动识别多运动开关到手环(0xA2)

#import <Foundation/Foundation.h>



#import <LZBracelet/LZA5SettingData.h>
#import <LZBracelet/LZA5CommonDefine.h>

NS_ASSUME_NONNULL_BEGIN

@interface LZA5SettingAutoRecognitionSportContentData : NSObject
/// 运动模式
@property (nonatomic, assign) LZA5SportMode sportMode;
/// 是否开启
@property (nonatomic, assign) BOOL enable;

@end

/// 自动识别多运动开关
@interface LZA5SettingAutoRecognitionSportData : LZA5SettingData

/// 自动识别开关列表
@property (nonatomic, strong) NSArray <LZA5SettingAutoRecognitionSportContentData *> *contentDatas;

@end

NS_ASSUME_NONNULL_END
