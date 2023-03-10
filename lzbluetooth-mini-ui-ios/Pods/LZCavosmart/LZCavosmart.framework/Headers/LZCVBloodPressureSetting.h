//
//  LZCVBloodPressureSetting.h
//  LZCavosmart
//
//  Created by tanjian on 2022/8/16.
//

#import <Foundation/Foundation.h>
#import <LZCavosmart/LZCVDataBase.h>

NS_ASSUME_NONNULL_BEGIN


/// 实时血压开关
@interface LZCVBloodPressureSetting : LZCVDataBase

@property (nonatomic, assign) BOOL enable;

@end


/// 血压显示开关
@interface LZCVBloodPressureDisplaySwitchSetting : LZCVDataBase <LZDecodeDataProtocol>

@property (nonatomic, assign) BOOL enable;

@end

NS_ASSUME_NONNULL_END
