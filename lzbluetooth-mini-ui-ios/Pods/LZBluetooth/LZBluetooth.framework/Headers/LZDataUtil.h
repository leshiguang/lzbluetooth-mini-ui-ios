//
//  LZDataUtil.h
//  LZBluetooth
//
//  Created by tanjian on 2020/9/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

UInt64 lz_uint64_reverse(UInt64 uint64);
UInt32 lz_uint32_reverse(UInt32 uint32);
UInt16 lz_uint16_reverse(UInt16 uint16);

/// 获取大端值
UInt16 lz_uint16_value(Byte *p);
UInt32 lz_uint32_value(Byte *p);
UInt32 lz_uint24_value(Byte *p);

/// 大端值
/// @param p 指针
/// @param byteSize 字节数 （1 ～ 4）
UInt32 lz_uint_value(Byte *p, UInt8 byteSize);

/// 两个字节 低12个 Bit 是数据，高4 个 Bit 是带符号数的10 的指数 0xA01=2561;0xF=-1;25 61*10^(-1)=256.1
double lz_sfloat_value(Byte *p);
/// 四个字节 //低三个字节是数据，高一个字节 是带符号数的10的指数 0x0013C3=5059;0xFE=-2; 50.59Kg 5059*10^(-2)=50.59Kg
double lz_float_value(Byte *p);

/// 获取小端值
UInt32 lz_uint32_reverseValue(Byte *p);
UInt16 lz_uint16_reverseValue(Byte *p);

/// 计算crc 16
/// @param data 数据
UInt16 lz_crc16_value(NSData *data);
NSData *lz_crc16_value_transform_data(NSData *data);

@interface LZDataUtil : NSObject

/// data转16进制字符串
/// @param data 数据
+ (NSString *)hexStringFromData:(NSData *)data;

/// 短的字符串
/// @param hexString 十六进制字符串
+ (NSString *)stringFromHexString:(NSString *)hexString;

+ (NSString *)binaryNumberStringFromIntegerNumber:(UInt32 )number;

+ (NSString *)hexStringFromNumber:(UInt32)number;

+ (NSData *)convertHexStrToData:(NSString *)str;


+ (NSData *)byteFromFloat:(double)floatValue;

+ (NSString *)snWithDeviceId:(NSString *)deviceId;

+ (NSString *)getDeviceIdWithCode:(NSData *)code macString:(NSString *)macString;

+ (NSInteger)getBatteryPercentageWithVoltage:(double)voltage
                                       model:(NSString *)model
                             softwareVersion:(NSString *)softwareVersion;

+ (UInt8)oldWeatherIconCodeWithNewIconCode:(UInt16)iconCode;


/// 无冒号的变为有冒号的
/// @param mac 无冒号的macString
+ (NSString *)macAddressFromMac:(NSString *)mac;

/// 有冒号的变为无冒好的
/// @param macAddress 有冒号的mac地址
+ (NSString *)macFromMacAddress:(NSString *)macAddress;

/// 求和
+ (uint32_t)sumCodeWithData:(NSData *)data;


@end






NS_ASSUME_NONNULL_END
