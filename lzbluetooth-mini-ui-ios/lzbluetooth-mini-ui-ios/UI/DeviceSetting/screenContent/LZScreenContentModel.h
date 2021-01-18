//
//  LZScreenContentModel.h
//  LSBluetoothUI_iOS
//
//  Created by wm on 2020/12/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, LZScreenContentSetType) {
    LZScreenContentSetTypeTime,
    LZScreenContentSetTypeCalories,
    LZScreenContentSetTypeStep,
    LZScreenContentSetTypeDistance,
    LZScreenContentSetTypeHeartRate,
    LZScreenContentSetTypeDailyData,
    LZScreenContentSetTypeStopwatch,
    LZScreenContentSetTypeWeather,
    LZScreenContentSetTypeBattery,
    LZScreenContentSetType12MinutesRun,
    LZScreenContentSetType6MinutesWalk,
    LZScreenContentSetTypeAlipay,
};

@interface LZScreenContentModel : NSObject
@property (nonatomic, copy) NSString *titleStr;
@property (nonatomic, assign) BOOL isSelect;
@property (nonatomic, assign) LZScreenContentSetType setType;

+ (NSArray <LZScreenContentModel *> *)cellModelList;
@end

NS_ASSUME_NONNULL_END
