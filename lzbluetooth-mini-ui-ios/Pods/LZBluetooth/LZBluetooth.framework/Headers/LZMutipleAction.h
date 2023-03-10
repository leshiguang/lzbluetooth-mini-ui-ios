//
//  LZMutipleAction.h
//  LZBluetooth
//
//  Created by tanjian on 2021/11/2.
//

#import <Foundation/Foundation.h>
#import <LZBluetooth/LZBluetoothDefine.h>
#import <LZBluetooth/LZResponse.h>


NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, LZActionType) {
    /// 不做任何动作，一般会直接等待await
    LZActionTypeNone,
    /// 发送数据
    LZActionTypePushData,
//    /// 使能
//    LZActionTypeEnable,
//    /// 使不能
//    LZActionTypeDisable,
//    /// 读设备信息
//    LZActionTypeRead,
};

typedef id _Nullable (^LZPushDataBlock)(id context);
typedef BOOL(^LZIgnoreErrorBlock)(id context);
typedef BOOL(^LZWhenBlock)(id data);
typedef BOOL(^LZAwaitOntimeoutBlock)(id context);
typedef id _Nullable(^LZAwaitDidReceiveDataBlock)(id data, id context);

extern NSInteger LZPrioritySystem;
extern NSInteger LZPriorityGetPush;
extern NSInteger LZPriorityPush;
extern NSInteger LZPrioritySyncData;
extern NSInteger LZPriorityOta;

@interface LZAction : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) LZActionType actionType;
@property (nonatomic, strong, nullable) NSString *serviceId;
@property (nonatomic, strong, nullable) NSString *characteristicId;
@property (nonatomic, strong, nullable) LZPushDataBlock pushDataBlock;
@property (nonatomic, strong, nullable) LZIgnoreErrorBlock ignoreErrorBlock;

/// 条件
@property (nonatomic, strong, nullable) LZWhenBlock whenBlock;

/// await
@property (nonatomic, assign) NSTimeInterval timeout;
@property (nonatomic, strong, nullable) LZAwaitOntimeoutBlock awaitOntimeoutBlock;
@property (nonatomic, strong, nullable) LZAwaitDidReceiveDataBlock awaitDidReceiveDataBlock;

+ (instancetype)actionWithName:(NSString *)name pushDataBlock:(LZPushDataBlock)pushDataBlock;
+ (instancetype)actionWithName:(NSString *)name timeout:(NSTimeInterval)timeout awaitReceiveDataBlock:(LZAwaitDidReceiveDataBlock)awaitReceiveDataBlock;
+ (instancetype)actionWithName:(NSString *)name pushDataBlock:(LZPushDataBlock)pushDataBlock awaitReceiveDataBlock:(LZAwaitDidReceiveDataBlock)awaitReceiveDataBlock;
+ (instancetype)actionWithName:(NSString *)name pushDataBlock:(LZPushDataBlock)pushDataBlock timeout:(NSTimeInterval)timeout awaitReceiveDataBlock:(LZAwaitDidReceiveDataBlock)awaitReceiveDataBlock;

+ (instancetype)actionWithName:(NSString *)name pushDataBlock:(LZPushDataBlock)pushDataBlock whenBlock:(LZWhenBlock)whenBlock;
+ (instancetype)actionWithDic:(NSDictionary *)dic;

@end


@protocol LZMutipleAction <NSObject>
/// 操作集合
@property (nonatomic, readonly) NSArray <LZAction *> *actions;
/// 优先级
@property (nonatomic, readonly) NSInteger priority;
/// 组合操作的唯一id
@property (nonatomic, readonly) UInt32 id;
/// 服务id

@optional
@property (nonatomic, readonly, nullable) NSString *serviceId;
@property (nonatomic, readonly, nullable) LZResponse *responseData;


@end

NS_ASSUME_NONNULL_END
