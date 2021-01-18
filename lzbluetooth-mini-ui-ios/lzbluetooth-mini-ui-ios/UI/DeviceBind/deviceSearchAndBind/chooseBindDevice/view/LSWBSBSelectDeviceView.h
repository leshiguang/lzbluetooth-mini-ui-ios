//
//  LSWBSBSelectDeviceView.h
//  LSWearable
//
//  Created by Wenzheng Zhang on 2017/3/7.
//  Copyright © 2017年 lifesense. All rights reserved.
//  选择需要绑定的设备页面

#import <UIKit/UIKit.h>


@class LSWBSBSelectDeviceView;
@class LZBaseDevice;

@protocol LSWBSBSelectDeviceViewDelegate <NSObject>
@optional
- (void)selectDeviceView:(LSWBSBSelectDeviceView *)selectDeviceView didSelectDeviceAtIndex:(NSInteger)index;
@end

@interface LSWBSBSelectDeviceView : UIView
@property (nonatomic, weak) id<LSWBSBSelectDeviceViewDelegate> delegate;
@property (nonatomic, strong, readonly) NSArray<LZBaseDevice *> *rawDeviceInfos;

- (void)setUpWithRawDeviceInfos:(NSArray<LZBaseDevice *> *)rawDeviceInfos productInfo:(LZBaseDevice *)productInfo isUseProductInfoName:(BOOL)isUseProductInfoName;
@end
