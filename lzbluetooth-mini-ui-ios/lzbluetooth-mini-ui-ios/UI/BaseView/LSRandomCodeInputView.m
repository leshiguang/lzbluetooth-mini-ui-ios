//
//  LSRandomCodeInputView.m
//  LSWearable
//
//  Created by Wenzheng Zhang on 2017/2/24.
//  Copyright © 2017年 lifesense. All rights reserved.
//

#import "LSRandomCodeInputView.h"
#import <Masonry/Masonry.h>
#import "LSWAppFontConfigrationMacro.h"
#import "LSWAppColorConfigrationMacro.h"


#pragma mark - _LSWRCIVInputOnlyTextField

@interface _LSWRCIVInputOnlyTextField : UITextField

@end

@implementation _LSWRCIVInputOnlyTextField
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    return NO;
}
@end

#pragma mark - _LSInnerShadowLayer
@interface _LSInnerShadowLayer : CAShapeLayer

@end

@implementation _LSInnerShadowLayer

- (instancetype)init {
    self = [super init];
    if (self) {
        
        self.masksToBounds = YES;
        self.needsDisplayOnBoundsChange = YES;
        self.shouldRasterize = NO;
        
        [self setShadowColor:[UIColor.blackColor colorWithAlphaComponent:0.4].CGColor];
        [self setShadowOffset:CGSizeMake(0.0f, 0)];
        [self setShadowOpacity:1.0f];
        [self setShadowRadius:6];
        [self setFillRule:kCAFillRuleEvenOdd];
        [self setFillColor:[UIColor.blackColor colorWithAlphaComponent:0.4].CGColor];
    }
    return self;
}

- (void)layoutSublayers {
    [super layoutSublayers];
    
    CGRect largerRect = CGRectMake(self.bounds.origin.x - 20,
                                   self.bounds.origin.y - 20,
                                   self.bounds.size.width + 40,
                                   self.bounds.size.height + 40);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, largerRect);
    
    CGFloat cornerRadius = self.cornerRadius;
    UIBezierPath *bezier;
    if (cornerRadius) {
        bezier = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:cornerRadius];
    } else {
        bezier = [UIBezierPath bezierPathWithRect:self.bounds];
    }
    CGPathAddPath(path, NULL, bezier.CGPath);
    CGPathCloseSubpath(path);
    
    [self setPath:path];
    
    CGPathRelease(path);
}

@end



#pragma mark - _LSWRCIVInputCell
@interface _LSWRCIVInputCell : UIView

@property (nonatomic, assign) BOOL hasAddedConstraints;
@property (nonatomic, strong) UILabel *digitLabel;
@property (nonatomic, strong) _LSInnerShadowLayer *shadowLayer;

@property (nonatomic, strong) NSString *digitText;
@property (nonatomic, assign) BOOL hightlighted;

@end

@implementation _LSWRCIVInputCell

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

#pragma mark - Life Cycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    [self initializedPrivateViews];
    [self setBackgroundColor:UIColor.whiteColor];
    [self addSubview:_digitLabel];

    _digitText = @"";

    self.layer.cornerRadius = 4;
    [self addShadowToView:self withColor:UIColor.blackColor];
    [self setHightlighted:NO];
    self.userInteractionEnabled = NO;
}



/// 添加四边阴影效果
- (void)addShadowToView:(UIView *)theView withColor:(UIColor *)theColor {
    // 阴影颜色
    theView.layer.shadowColor = theColor.CGColor;
    // 阴影偏移，默认(0, -3)
    theView.layer.shadowOffset = CGSizeMake(0,0);
    // 阴影透明度，默认0
    theView.layer.shadowOpacity = 0.1;
    // 阴影半径，默认3
    theView.layer.shadowRadius = 5;
    
    
    
}

- (void)updateConstraints {
    
    if (!self.hasAddedConstraints) {
        
        [self.digitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
    }
    self.hasAddedConstraints = YES;
    
    [super updateConstraints];
}

//- (void)layoutSubviews {
//    [super layoutSubviews];
//    self.shadowLayer.frame = self.bounds;
//}

#pragma mark - Public APIs
- (void)setDigitText:(NSString *)digitText {
    self.digitLabel.text = digitText;
    _digitText = digitText;
}

- (void)setHightlighted:(BOOL)hightlighted {
    _hightlighted = hightlighted;
    //4.0ui不需要高光
//    self.layer.borderColor = hightlighted ? LSWKeyColor.CGColor : UIColorFromHex(0xD3D3D3).CGColor;
//    self.shadowLayer.opacity = hightlighted ? 1 : 0;
//    self.layer.borderColor = UIColorFromHex(0xD3D3D3).CGColor;
}

#pragma mark - Private Method
- (void)initializedPrivateViews {
    if (_digitLabel == nil) {
        _digitLabel = [[UILabel alloc] init];
        _digitLabel.font = LSWDefaultMediumFontWithSize(30);
        _digitLabel.textColor = LSWImportantContentFontColor;
        _digitLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    if (_shadowLayer == nil) {
        _shadowLayer = [_LSInnerShadowLayer layer];
    }
}

@end


#pragma mark - LSRandomCodeInputView
@interface LSRandomCodeInputView () <UITextFieldDelegate>


@property (nonatomic, strong) UITextField *eventCaptureTextView;
@property (nonatomic, strong) UIView *coverView;

@property (nonatomic, strong) NSArray<_LSWRCIVInputCell *> *inputCells;

@property (nonatomic, assign) NSInteger codeLenth;
@property (nonatomic, assign) CGSize cellSize;
@property (nonatomic, assign) NSInteger interItemSpace;

@property (nonatomic, strong) _LSWRCIVInputCell *currentInputCell;
@end

@implementation LSRandomCodeInputView

- (instancetype)initWithCodeLength:(NSInteger)codeLength cellSize:(CGSize)cellSize interItemSpace:(CGFloat)interItemSpace {
    CGRect frame = [self frameForCodeLength:codeLength
                                   cellSize:cellSize
                             interItemSpace:interItemSpace];
    self = [super initWithFrame:frame];
    if (self) {
        _codeLenth = codeLength;
        _cellSize  = cellSize;
        _interItemSpace = interItemSpace;
        _font = [UIFont systemFontOfSize:35];
        _textColor = LSWImportantContentFontColor;
        _eventCaptureTextView = [[_LSWRCIVInputOnlyTextField alloc] init];
        _eventCaptureTextView.textColor = [UIColor clearColor];
        _eventCaptureTextView.tintColor = [UIColor clearColor];
        _eventCaptureTextView.backgroundColor = [UIColor clearColor];
        _eventCaptureTextView.keyboardType = UIKeyboardTypeNumberPad;
        _eventCaptureTextView.delegate = self;
        _coverView = [[UIView alloc] init];
        _coverView.backgroundColor = [UIColor clearColor];
        _coverView.userInteractionEnabled = NO;
        [self addSubview:_eventCaptureTextView];
        [self addSubview:_coverView];
        _acceptableCode = [[NSSet alloc] initWithObjects:@"0",
                           @"1",
                           @"2",
                           @"3",
                           @"4",
                           @"5",
                           @"6",
                           @"7",
                           @"8",
                           @"9",
                           nil];
        [self setUpInputCellsWithCodeLength:codeLength cellSize:cellSize interItemSpace:interItemSpace];
        
    }
    return self;
}

- (void)setUpInputCellsWithCodeLength:(NSInteger)codeLength cellSize:(CGSize)cellSize interItemSpace:(CGFloat)interItemSpace {
    NSMutableArray<_LSWRCIVInputCell *> *inputCells = [[NSMutableArray alloc] init];
    CGFloat x = 0;
    for (NSInteger i = 0; i < codeLength; i++) {
        CGRect frame = CGRectMake(x, 0, cellSize.width, cellSize.height);
        _LSWRCIVInputCell *inputCell = [self generateInputCellWithFrame:frame];
        x += interItemSpace + cellSize.width;
        [inputCells addObject:inputCell];
        [self addSubview:inputCell];
    }
    _inputCells = [inputCells copy];
    _currentInputCell = [_inputCells firstObject];
}

- (_LSWRCIVInputCell *)generateInputCellWithFrame:(CGRect)frame {
    
    _LSWRCIVInputCell *cell = [[_LSWRCIVInputCell alloc] initWithFrame:frame];
    return cell;
}

- (CGSize)sizeThatFits:(CGSize)size {
    return [self frameForCodeLength:self.codeLenth cellSize:self.cellSize interItemSpace:self.interItemSpace].size;
}

- (CGSize)intrinsicContentSize {
    return [self sizeThatFits:CGSizeZero];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.eventCaptureTextView.frame = self.bounds;
    self.coverView.frame = self.bounds;
}

#pragma mark - Public Interface
- (void)showKeyboard {
    
    if (![self.eventCaptureTextView isFirstResponder]) {
        [self.eventCaptureTextView becomeFirstResponder];
        self.currentInputCell.hightlighted = YES;
    }
}

- (void)hideKeyboard {
    if ([self.eventCaptureTextView canResignFirstResponder]) {
        [self.eventCaptureTextView resignFirstResponder];
    }
}

- (void)clearAndReset {
    for (_LSWRCIVInputCell *inputCell in self.inputCells) {
        inputCell.digitText = @"";
        inputCell.hightlighted = NO;
    }
    self.currentInputCell = [self.inputCells firstObject];
    [self showKeyboard];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
//    NSAssert(string.length <= 1, @"只可能单个字符输入");
    
    if ([string isEqualToString:@""]) {
        _LSWRCIVInputCell *preInputCell = [self previousInputCellWithCurrentInputCell:self.currentInputCell];
        
        if (![self.currentInputCell.digitText isEqualToString:@""]) {
            self.currentInputCell.digitText = @"";
            self.currentInputCell.hightlighted = YES;
        } else if(preInputCell != nil) {
            preInputCell.hightlighted = YES;
            preInputCell.digitText = @"";
            self.currentInputCell.hightlighted = NO;
            self.currentInputCell = preInputCell;

        }
        //[self reportResult];
    
    } else {
        self.currentInputCell.digitText = string;
        self.currentInputCell.hightlighted = NO;
        _LSWRCIVInputCell *nextInputCell = [self nextInputCellWithCurrentInputCell:self.currentInputCell];
        if (nextInputCell == nil) {
            [self reportResult];
        } else {
            nextInputCell.hightlighted = YES;
            self.currentInputCell = nextInputCell;
        }
    }
    
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {

    if ( [self.delegate respondsToSelector:@selector(randomCodeInoputViewWillBeginEditing:)]) {
        [self.delegate randomCodeInoputViewWillBeginEditing:self];
    }
    self.currentInputCell.hightlighted = YES;
    return YES;
}


#pragma mark - Current Input Cell Management
- (_LSWRCIVInputCell *)nextInputCellWithCurrentInputCell:(_LSWRCIVInputCell *)inputCell {
    _LSWRCIVInputCell *nextInputCell = nil;
    NSInteger index = [self.inputCells indexOfObject:inputCell];
    if (index == self.inputCells.count - 1) {
    } else {
        nextInputCell = [self.inputCells objectAtIndex:index + 1];
    }
    return nextInputCell;
}

- (_LSWRCIVInputCell *)previousInputCellWithCurrentInputCell:(_LSWRCIVInputCell *)inputCell {
    _LSWRCIVInputCell *preInputCell = nil;
    NSInteger index = [self.inputCells indexOfObject:inputCell];
    if (index > 0) {
        preInputCell = [self.inputCells objectAtIndex:index - 1];
    }
    return preInputCell;
}

- (void)reportResult {
    if ([self.delegate respondsToSelector:@selector(randomCodeInoputView:didInputCode:)]) {
        NSMutableString *code = [[NSMutableString alloc] init];
        for (_LSWRCIVInputCell *inputCell in self.inputCells) {
            if (inputCell.digitText.length > 0) {
                [code appendString:inputCell.digitText];
            }
        }
        [self.delegate randomCodeInoputView:self didInputCode:code];
    }
}

#pragma mark - Private Methods
- (CGRect)frameForCodeLength:(NSInteger)codeLength cellSize:(CGSize)cellSize interItemSpace:(CGFloat)interItemSpace {
    CGFloat width  = cellSize.width * codeLength + (codeLength - 1) * interItemSpace;
    CGFloat height = cellSize.height;
    return CGRectMake(0, 0, width, height);
}

#pragma mark - Getter And Setter
- (void)setFont:(UIFont *)font {
    _font = font;
    for (_LSWRCIVInputCell *inputCell in self.inputCells) {
        inputCell.digitLabel.font = font;
    }
}

- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    for (_LSWRCIVInputCell *inputCell in self.inputCells) {
        inputCell.digitLabel.textColor = textColor;
    }
}
@end
