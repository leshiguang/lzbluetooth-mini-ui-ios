//
//  LZA5SettingNewWeatherData.h
//  LZBluetooth
//
//  Created by tanjian on 2021/11/12.
//




#import <LZBracelet/LZA5SettingData.h>

NS_ASSUME_NONNULL_BEGIN


@interface LZNewWeatherInfo : NSObject

/** 天气气象代码 */
@property (nonatomic, assign) UInt32 weatherCode;
    /** 最低气温 */
@property (nonatomic, assign) UInt32 minTemperature;
    /** 最高气温 */
@property (nonatomic, assign) UInt32 maxTemperature;
    /** 当前温度 */
@property (nonatomic, assign) UInt32 currentTemperature;
    /** 风速 */
@property (nonatomic, assign) UInt32 windSpeed;
    /** 相对湿度 */
@property (nonatomic, assign) UInt32 humidity;
    /** uv指数 */
@property (nonatomic, assign) UInt32 uvIndex;
    /** 空气质量 */
@property (nonatomic, assign) UInt32 aqi;

    /** 日出时间 */
@property (nonatomic, assign) UInt32 sunriseHour;
@property (nonatomic, assign) UInt32 sunriseMinute;

    /** 日落时间 */
@property (nonatomic, assign) UInt32 sunsetHour;
@property (nonatomic, assign) UInt32 sunsetMinute;

@end

@interface LZA5SettingNewWeatherData : LZA5SettingData

/// 天气
@property (nonatomic, strong) NSArray <LZNewWeatherInfo *> *list;

/// 更新时间
@property (nonatomic, assign) UInt32 utc;

/// 城市名称
@property (nonatomic, strong) NSString *cityName;

@end

NS_ASSUME_NONNULL_END
