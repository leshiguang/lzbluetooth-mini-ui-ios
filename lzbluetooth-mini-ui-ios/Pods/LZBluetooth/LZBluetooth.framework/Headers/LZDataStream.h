//
//  LZDataStream.h
//  LZBluetooth
//
//  Created by tanjian on 2021/2/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LZDataStream : NSObject



/// 
@property (nonatomic, assign) BOOL little;

+ (instancetype)streamWithData:(NSData *)data;
+ (instancetype)streamWithData:(NSData *)data offset:(UInt32)offset;
+ (instancetype)streamWithCapacity:(NSUInteger)length;

- (UInt8)readByte;
- (UInt16)readShort;
- (UInt32)readInt;
- (UInt32)readUInt24;
- (double)readSfloat;
- (double)readFloat;

/// string的长度最多32位
- (NSString *)readString;
- (NSData *)readDataWithLength:(uint)length;

- (BOOL)writeByte:(UInt8)byte;
- (BOOL)writeShort:(UInt16)shortValue;
- (BOOL)writeInt:(UInt32)intValue;
- (BOOL)writeString:(NSString *)string;
- (int)write:(const char*)buffer len:(uint)len;
- (BOOL)writeData:(NSData *)data;
- (BOOL)writeUInt24:(UInt32)uint24Value;

- (BOOL)write0WithLength:(uint)len;

- (BOOL)writeString:(NSString *)string limit:(UInt32)limit;
- (BOOL)writeData:(NSData *)data limit:(UInt32)limit;

- (NSData *)data;

- (NSData *)originData;

- (NSUInteger)index;

/// 相对当前偏移多少
- (void)offset:(int)offset;

@end

NS_ASSUME_NONNULL_END
