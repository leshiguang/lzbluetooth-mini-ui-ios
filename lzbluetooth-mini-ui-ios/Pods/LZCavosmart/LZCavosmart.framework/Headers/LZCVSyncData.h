//
//  LZCVSyncData.h
//  LZCavosmart
//
//  Created by tanjian on 2022/8/16.
//

#import <Foundation/Foundation.h>
#import <LZCavosmart/LZCVDataBase.h>

NS_ASSUME_NONNULL_BEGIN


/// 开始同步数据
@interface LZCVSyncData : LZCVDataBase

@end

/// 结束同步数据 （内部调用）
@interface LZCVFinishSyncData : LZCVDataBase

@end


NS_ASSUME_NONNULL_END
