//
//  LSWBSBSelectDeviceView.m
//  LSWearable
//
//  Created by Wenzheng Zhang on 2017/3/7.
//  Copyright © 2017年 lifesense. All rights reserved.
//  绑定设备列表页面 （如果蓝牙搜索到多台可用于连接的设别会显示这个页面）

#import "LSWBSBSelectDeviceView.h"
#import <Masonry/Masonry.h>
#import "LSWButton.h"
#import "LSWAppFontConfigrationMacro.h"
#import "LSWAppColorConfigrationMacro.h"

@import LZBluetooth;

#pragma mark - _LSWBSBSDVDeviceCell
@interface _LSWBSBSDVDeviceCell : UITableViewCell

@property (nonatomic, assign) BOOL hasAddedConstraints;
@property (nonatomic, strong) UILabel *titleLabel;    //设备名称
@property (nonatomic, strong) UILabel *detailLabel;   //离你最近
@property (nonatomic, strong) UIImageView *selectionIndicator;

@property (nonatomic, strong) UIView *bottomLineView;

@end

@implementation _LSWBSBSDVDeviceCell

#pragma mark - Life Cycle

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    [self initializedPrivateViews];
    
    [self.contentView addSubview:_titleLabel];
    [self.contentView addSubview:_detailLabel];
    [self.contentView addSubview:_selectionIndicator];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.bottom.equalTo(self.contentView).with.insets(UIEdgeInsetsMake(0, 20, 0, 0));
    }];
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.leading.equalTo(self.titleLabel.mas_trailing);
    }];
    
    [self.selectionIndicator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(self.selectionIndicator.image.size);
        make.trailing.equalTo(self.contentView.mas_trailing).with.offset(-20);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    
    [self.titleLabel setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    [self.titleLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    
    [self.selectionIndicator setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    [self.selectionIndicator setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.selectionIndicator.image = [UIImage imageNamed:(selected ? @"icn_choiced" : @"icn_unchoiced")];
}

#pragma mark - Public APIs

- (void)setUpWithRawDeviceInfo:(LZBaseDevice *)rawDeviceInfo productInfo:(LZBaseDevice *)productInfo isUseProductInfoName:(BOOL)isUseProductInfoName showTagView:(BOOL)showTagView {
#if DEBUG
    self.titleLabel.text = [NSString stringWithFormat:@"%@ %@", rawDeviceInfo.name, rawDeviceInfo.macAddress];
#else
    self.titleLabel.text = rawDeviceInfo.name;
#endif
    
    self.detailLabel.hidden = !showTagView;
}

#pragma mark - Private Method
- (void)initializedPrivateViews {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = LSWDefaultMediumFontWithSize(18);
        _titleLabel.textColor = LSWImportantContentFontColor;
    }
    
    if (_detailLabel == nil) {
        _detailLabel = [[UILabel alloc] init];
        _detailLabel.font = [UIFont systemFontOfSize:14];
        _detailLabel.textColor = UIColorFromHex(0x9F9F9F);
        _detailLabel.text = @"(离你最近)";
    }
    
    if (_selectionIndicator == nil) {
        _selectionIndicator = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icn_choiced"]];
    }
}

@end


#pragma mark - LSWBSBSelectDeviceView
@interface LSWBSBSelectDeviceView () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) LSWButton *button;
@property (nonatomic, strong) UILabel *hintLabel;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong, readwrite) NSArray<LZBaseDevice *> *rawDeviceInfos;
@property (nonatomic, strong) LZBaseDevice *productInfo;
@property (nonatomic, assign) BOOL isUseProductInfoName;

@end

@implementation LSWBSBSelectDeviceView
#pragma mark - Life Cycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
        [self.tableView reloadData];
    }
    return self;
}

- (void)commonInit {
    self.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:self.hintLabel];
    [self addSubview:self.tableView];
    [self addSubview:self.button];
    [self addSubview:self.lineView];
    
    [self.hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self);
        make.top.equalTo(self.mas_top).with.offset(28);
    }];
    
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(-70);
        make.left.equalTo(self.mas_left).offset(70);
        make.right.equalTo(self.mas_right).offset(-70);
        make.height.equalTo(@50);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self).offset(0);
        make.trailing.equalTo(self).offset(0);
        make.top.equalTo(self.hintLabel.mas_bottom).with.offset(20);
        make.bottom.equalTo(self.button.mas_top).with.offset(-81);
    }];
}

#pragma mark - TableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.rawDeviceInfos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    _LSWBSBSDVDeviceCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([_LSWBSBSDVDeviceCell class])];
    BOOL isUseName = NO;
    [cell setUpWithRawDeviceInfo:self.rawDeviceInfos[indexPath.row] productInfo:self.productInfo isUseProductInfoName:isUseName showTagView:indexPath.row == 0];
    cell.bottomLineView.hidden = indexPath.row == self.rawDeviceInfos.count - 1 ? YES : NO;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

#pragma mark - Public APIs
- (void)setUpWithRawDeviceInfos:(NSArray<LZBaseDevice *> *)rawDeviceInfos productInfo:(LZBaseDevice *)productInfo isUseProductInfoName:(BOOL)isUseProductInfoName {
    self.rawDeviceInfos = [rawDeviceInfos copy];
    self.productInfo = productInfo;
    self.isUseProductInfoName = isUseProductInfoName;
    [self.tableView reloadData];
    if (rawDeviceInfos.count > 0) {
        [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
                                     animated:NO
                               scrollPosition:UITableViewScrollPositionNone];
    }
}

#pragma mark - Call Delegate
- (void)confirmBindDevice:(id)sender {
    if ([self.delegate respondsToSelector:@selector(selectDeviceView:didSelectDeviceAtIndex:)] && [self.tableView indexPathForSelectedRow]) {
        [self.delegate selectDeviceView:self didSelectDeviceAtIndex:[self.tableView indexPathForSelectedRow].row];
    }
}

#pragma mark - Private Method

#pragma mark - getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[_LSWBSBSDVDeviceCell class] forCellReuseIdentifier:NSStringFromClass([_LSWBSBSDVDeviceCell class])];
    }
    return _tableView;
}

- (LSWButton *)button {
    if (!_button) {
        _button = [[LSWButton alloc] initWithButtonStyle:LSWButtonStyleNewPrimaryButtonWithDeepBlueColor];
        _button.layer.cornerRadius = 25.0;
        [_button setTitle:@"立即绑定" forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(confirmBindDevice:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

- (UILabel *)hintLabel {
    if (!_hintLabel) {
        _hintLabel = [[UILabel alloc] init];
        _hintLabel.font = [UIFont boldSystemFontOfSize:16];
        _hintLabel.textColor = LSWImportantContentFontColor;
        _hintLabel.textAlignment = NSTextAlignmentCenter;
        _hintLabel.text = @"选择需要绑定的设备";
    }
    return _hintLabel;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = UIColorFromHex(0xE9E9E9);
    }
    return _lineView;
}

@end
