//
//  LZA5SettingWeatherData.h
//  LZBluetooth
//
//  Created by tanjian on 2020/10/22.
//  天气信息到手环(0xA6)

#import <Foundation/Foundation.h>
#import <LZBluetooth/LZBluetoothDefine.h>
#import <LZBluetooth/LZDeviceSettingProtocol.h>



NS_ASSUME_NONNULL_BEGIN

/// weatherState
//0x00 晴(白天);
//0x01 晴(夜晚);
//0x02 多云;
//0x03 晴间多云(白天);
//0x04 晴间多云(夜晚);
//0x05 大部多云(白天);
//0x06 大部多云(夜晚);
//0x07 阴;
//0x08 阵雨;
//0x09 雷阵雨;
//0x0A 冰雹或雷阵雨伴有冰雹;
//0x0B 小雨;
//0x0C 中雨;
//0x0D 大雨;
//0x0E 暴雨;
//0x0F 大暴雨;
//0x10 特大暴雨;
//0x11 冻雨;
//0x12 雨夹雪;
//0x13 阵雪;
//0x14 小雪;
//0x15 中雪;
//0x16 大雪;
//0x17 暴雪;
//0x18 浮尘;
//0x19 扬沙;
//0x1A 沙尘暴;
//0x1B 强沙尘暴;
//0x1C 雾;
//0x1D 霾;
//0x1E 风;
//0x1F 大风;
//0x20 飓风;
//0x21 热带风暴;
//0x22 龙卷风;

/// 天气详情
@interface LZWeatherDayData : NSObject
/// 空气质量指数
@property (nonatomic, assign) UInt16 aqi;
/// 天气状况的代码 参考上面
@property (nonatomic, assign) NSInteger weatherState;
/// 最低温度
@property (nonatomic, assign) NSInteger temperature1;
/// 最高温度
@property (nonatomic, assign) NSInteger temperature2;

@end

/// 天气信息
@interface LZWeatherData : NSObject <LZDeviceSettingProtocol>
/// 天气更新时间
@property (nonatomic, assign) UInt32 updateTime;
/// 今天、明天、后天的天气信息
@property (nonatomic, strong) NSArray <LZWeatherDayData *> *weatherFutures;

@end



NS_ASSUME_NONNULL_END
