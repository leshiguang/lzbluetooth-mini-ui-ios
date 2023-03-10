//
//  LZBPInitializeRequestData.h
//  LZBluetooth
//
//  Created by tanjian on 2020/10/10.
//

#import <Foundation/Foundation.h>



#import <LZBloodPressure/LZBPData.h>


NS_ASSUME_NONNULL_BEGIN

typedef NS_OPTIONS(UInt32, LZBPInitializeRequestFlag) {

    /// 需要协商MTU
    LZBPInitializeRequestFlagMTU                  = 1 << 0,
    /// 需要协商Slave Latency
    LZBPInitializeRequestFlagSlaveLatency         = 1 << 1,
    /// 需要协商Supervisory Time out
    LZBPInitializeRequestFlagSupervisoryTimeout   = 1 << 2,
    /// 请求UTC
    LZBPInitializeRequestFlagUTC                  = 1 << 3,
    /// 请求Time Zone
    LZBPInitializeRequestFlagTimeZone             = 1 << 4,
    /// 请求Time Stamp
    LZBPInitializeRequestFlagTimeStamp            = 1 << 5
};

@interface LZBPInitializeRequestData : LZBPData


@property (nonatomic, assign) LZBPInitializeRequestFlag flag;

/// 当Flags中Bit0=0时，MTU不存在，后面数据移到此位置；Bit0=1时，此位置是MTU
@property (nonatomic, assign) UInt8 mtu;

/// 当Flags中Bit1=1时，Slave latency不存在，后面数据移到此位置；Bit1=1时，此位置是Slave latency
@property (nonatomic, assign) UInt8 slaveLatency;

/// 当Flags中Bit2=0时，Supervisory Time out不存在；Bit2=1时，此位置是Supervisory Time out
@property (nonatomic, assign) UInt8 supervisonyTimeout;

@property (nonatomic, assign) UInt32 utc;

@property (nonatomic, assign) UInt8 timeZone;


/// 这里没有看懂，因为有了utc 这个又有什么意思
@property (nonatomic, strong) NSData *timeStamp;

@end

NS_ASSUME_NONNULL_END
