//
//  LZA6UnitSettingData.h
//  LZBluetooth
//
//  Created by tanjian on 2020/10/12.
//

#import <Foundation/Foundation.h>



#import <LZScale/LZA6Data.h>


NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, LZA6Unit) {
    /// 公斤
    LZA6UnitKg = 0,
    /// 磅
    LZA6UnitLb = 1,
    /// 英石
    LZA6UnitSt = 2,
    /// 斤
    LZA6UnitJin = 3,
};

@interface LZA6UnitSettingData : LZA6Data

@property (nonatomic, assign) LZA6Unit unit;

@end

NS_ASSUME_NONNULL_END
