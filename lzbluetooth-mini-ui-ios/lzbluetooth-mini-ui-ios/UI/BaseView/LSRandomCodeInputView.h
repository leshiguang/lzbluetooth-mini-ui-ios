//
//  LSRandomCodeInputView.h
//  LSWearable
//
//  Created by Wenzheng Zhang on 2017/2/24.
//  Copyright © 2017年 lifesense. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LSRandomCodeInputView;

@protocol LSRandomCodeInputViewDelegate <NSObject>
@optional

- (void)randomCodeInoputViewWillBeginEditing:(LSRandomCodeInputView *)randomCodeInputView;
- (void)randomCodeInoputView:(LSRandomCodeInputView *)randomCodeInputView didInputCode:(NSString *)code;
@end

@interface LSRandomCodeInputView : UIView


/**
 初始化LSRandomCodeInputView实例，此方法为唯一初始化方法，其他方法均无效

 @param codeLength 随机码长度
 @param cellSize 单元格size
 @param interItemSpace 每个单元格横向间距
 @return LSRandomCodeInputView实例
 */
- (instancetype)initWithCodeLength:(NSInteger)codeLength cellSize:(CGSize)cellSize interItemSpace:(CGFloat)interItemSpace;

- (void)showKeyboard;
- (void)hideKeyboard;
- (void)clearAndReset;

@property (nonatomic, weak) id <LSRandomCodeInputViewDelegate> delegate;


/**
 可接受的随机码范围，默认为0～9
 */
@property (nonatomic, copy) NSSet<NSString *> *acceptableCode;


/**
 默认为35，系统字体
 */
@property (nonatomic, strong) UIFont *font;


/**
 默认为0x414141
 */
@property (nonatomic, strong) UIColor *textColor;
@end
