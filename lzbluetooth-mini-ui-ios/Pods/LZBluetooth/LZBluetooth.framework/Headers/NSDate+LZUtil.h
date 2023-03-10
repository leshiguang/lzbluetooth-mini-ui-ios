//
//  NSDate+LZUtil.h
//  LZBluetooth
//
//  Created by tanjian on 2020/10/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (LZUtil)

- (UInt32)lz_utc;

- (UInt8)lz_hour;
- (UInt8)lz_minute;

+ (UInt32)lz_timezone;
+ (uint32_t)lz_timezoneWithGTMOffset:(NSInteger)gtmOffset;


/// 北京时间2010年1月1日
+ (NSDate *)lz_dateBy20100101;
/// 2010年1月1日时相对于1970的时间戳
+ (UInt32)lz_utcBy20100101;

+ (NSCalendar *)lz_GregorianCalendar;

@end

NS_ASSUME_NONNULL_END
