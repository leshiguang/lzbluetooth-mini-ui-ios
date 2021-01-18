//
//  LSWEnterRandomCodeView.h
//  LSWearable
//
//  Created by Wenzheng Zhang on 2017/2/24.
//  Copyright © 2017年 lifesense. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LSWEnterRandomCodeView;

@protocol LSWEnterRandomCodeViewDelegate <NSObject>
@optional
- (void)enterRandomCodeView:(LSWEnterRandomCodeView *)enterRandomCodeView didEnterCode:(NSString *)code;
@end

@interface LSWEnterRandomCodeView : UIView

- (instancetype)initWithCodeLength:(NSInteger)codeLength frame:(CGRect)frame;

@property (nonatomic, weak) id <LSWEnterRandomCodeViewDelegate> delegate;


- (void)reloadInputViewWithLength:(NSInteger)length;
- (void)setHintContent:(NSString *)hintContent showActivityIndicator:(BOOL)showActivityIndicator;
- (void)showKeyboard;
- (void)hideKeyboard;
- (void)clearAndReset;
@end
