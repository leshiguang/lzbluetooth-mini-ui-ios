//
//  LZMcuBoxData.h
//  LZBluetooth
//
//  Created by tanjian on 2021/12/2.
//

#import <Foundation/Foundation.h>



#import <LZBluetooth/LZBaseData.h>

NS_ASSUME_NONNULL_BEGIN

@interface LZMcuCellBoxData : NSObject

@property (nonatomic, assign) UInt32 cellIndex;
@property (nonatomic, assign) UInt32 size;
@property (nonatomic, assign) UInt32 status;
@property (nonatomic, assign) UInt32 utc;

@end

@interface LZMcuBoxData : LZBaseData


@property (nonatomic, strong) NSMutableArray <LZMcuCellBoxData *> *list;
@property (nonatomic, assign) UInt32 size;
@property (nonatomic, assign) BOOL finish;



@end

NS_ASSUME_NONNULL_END
