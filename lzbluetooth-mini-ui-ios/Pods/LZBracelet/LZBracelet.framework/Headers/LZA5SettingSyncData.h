//
//  LZA5SettingSyncData.h
//  LZBluetooth
//
//  Created by tanjian on 2021/11/12.
//




#import <LZBracelet/LZA5SettingData.h>


NS_ASSUME_NONNULL_BEGIN




@interface LZA5SettingSyncData : LZA5SettingData

@property (nonatomic, assign) LZA5SyncDataType syncDataType;

+ (instancetype)syncDataWithType:(LZA5SyncDataType)syncDataType;

@end

NS_ASSUME_NONNULL_END
