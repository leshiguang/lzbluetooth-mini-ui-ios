//
//  LSWBindingDeviceView.h
//  LSWearable
//
//  Created by symons on 2019/10/29.
//  Copyright © 2019 lifesense. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LSWEnterRandomCodeView.h"


typedef NS_ENUM(NSUInteger, LSWDeviceBindingState) {
    LSWDeviceBindingStateNone = 0,
    LSWDeviceBindingStateWaitingBind,        //等待绑定
    LSWDeviceBindingStateBinding,            //正在绑定中
    LSWDeviceBindingStateWaitingInput,       //等待输入
    LSWDeviceBindingStateBindFailed,         //绑定失败
    LSWDeviceBindingStateBindSucceed,        //绑定成功
    LSWDeviceBindingStateSwitchActiveDevice, //切换活跃设备
};

typedef NS_ENUM(NSUInteger, LSWBindingViewDeviceTapActionType){
    LSWBindingViewDeviceTapActionTypeBindNone,
    LSWBindingViewDeviceTapActionTypeBindNow,
    LSWBindingViewDeviceTapActionTypeBindDone,
    LSWBindingViewDeviceTapActionTypeBindReBind,
    LSWBindingViewDeviceTapActionTypeBindSetActiveDeviceYes,
    LSWBindingViewDeviceTapActionTypeBindSetActiveDeviceNo,
    LSWBindingViewDeviceTapActionTypeBindGuideAction,
};


@protocol LSWBindingDeviceViewDelegate <NSObject>

- (void)lswBindingDeviceViewDidTapAtionType:(LSWBindingViewDeviceTapActionType)actionType;

@end


@interface LSWBindingDeviceView : UIView

@property (nonatomic, strong) LSWEnterRandomCodeView *enterRandomCodeView;

@property (nonatomic, assign) LSWDeviceBindingState currentState;

@property (nonatomic, weak) id <LSWBindingDeviceViewDelegate>delegate;

@property (nonatomic, assign) NSInteger inputCodeLength;

- (void)changeBindingStateTo:(LSWDeviceBindingState)state;

- (void)setDeviceName:(NSString *)deviceName imageUrl:(NSString *)imageUrl placeHolderImage:(UIImage *)placeHolderImage;

@end



