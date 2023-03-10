//
//  LZDialUtil.h
//  LZBluetooth
//
//  Created by tanjian on 2021/12/29.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class UIImage;

/// 表盘工具集
@interface LZDialUtil : NSObject


/// 生成相册表盘文件 456及437系列相册表盘
/// @param image 图片
/// @param size 图片大小    456图片固定为120, 240
/// @param previewSize 预览图大小   456图片固定为90, 180
/// @param model 型号     例：456B1
+ (NSData *)packingWatchFaceFileWithImage:(UIImage *)image
                                     size:(CGSize)size
                              previewSize:(CGSize)previewSize
                                    model:(NSString *)model;

/// 打包生成相册表盘文件 460系列相册表盘
/// @param templateData 相册表盘原文件 https://cn-pics.leshiguang.com/表盘文件/2021/12/28/4bf894fe4b204a57ab43c813280fa049.bin
/// @param image 图片
/// @param size 图片大小    460图片固定为320, 385
/// @param previewSize 预览图大小   460图片固定为265
/// @param model 型号     例：456B1
+ (NSData *)packingWatchFaceFileWithTemplateData:(NSData *)templateData
                                           image:(UIImage *)image
                                            size:(CGSize)size
                                     previewSize:(CGSize)previewSize
                                           model:(NSString *)model;


/// 压缩表盘文件 测试使用外部只需要packingWatchFaceFileWithImage
/// @param data 图片的大图原始数据 与 预览图的原始数据
/// @param fileName 文件名称
/// @param model 型号
+ (NSData *)compressWithData:(NSData *)data fileName:(NSString *)fileName model:(NSString *)model;

@end

NS_ASSUME_NONNULL_END
