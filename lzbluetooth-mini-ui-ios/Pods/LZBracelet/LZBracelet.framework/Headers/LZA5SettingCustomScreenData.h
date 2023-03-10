//
//  LZA5SettingCustomScreenData.h
//  LZBluetooth
//
//  Created by tanjian on 2020/10/22.
//  自定义显示页面设置到手环(0x7E)

#import <Foundation/Foundation.h>



#import <LZBracelet/LZA5SettingData.h>


NS_ASSUME_NONNULL_BEGIN

/// 自定义屏幕设置
@interface LZA5SettingCustomScreenData : LZA5SettingData

/// 页面列表 参考 LZA5UIPageType
@property (nonatomic, strong) NSArray <NSNumber *> *listPage;

/// 0表示应用列表  1表示为1级页面
@property (nonatomic, assign) UInt32 type;

@end

NS_ASSUME_NONNULL_END
