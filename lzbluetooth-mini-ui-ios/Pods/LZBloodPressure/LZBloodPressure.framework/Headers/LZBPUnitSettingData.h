//
//  LZBPUnitSettingData.h
//  LZBluetooth
//
//  Created by tanjian on 2020/10/12.
//

#import <Foundation/Foundation.h>



#import <LZBloodPressure/LZBPData.h>


NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, LZBPUnit) {
    ///
    LZBPUnitmmHg = 0,
    ///
    LZBPUnitKpa = 1,
   
};

@interface LZBPUnitSettingData : LZBPData

@property (nonatomic, assign) LZBPUnit unit;

@end

NS_ASSUME_NONNULL_END
