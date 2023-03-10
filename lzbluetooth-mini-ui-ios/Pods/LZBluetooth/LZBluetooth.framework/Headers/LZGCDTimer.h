//
//  LZGCDTimer.h
//  LZBluetooth
//
//  Created by tanjian on 2020/9/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LZGCDTimer : NSObject

+ (instancetype)sharedInstance;

- (void)scheduledDispatchTimerWithName:(NSString *)timerName
                          timeInterval:(double)interval
                                 queue:(nullable dispatch_queue_t)queue
                               repeats:(BOOL)repeats
                         fireInstantly:(BOOL)fireInstantly
                                action:(dispatch_block_t)dispatchBlock;

- (void)cancelTimerWithName:(NSString *)timerName;


@end

NS_ASSUME_NONNULL_END
