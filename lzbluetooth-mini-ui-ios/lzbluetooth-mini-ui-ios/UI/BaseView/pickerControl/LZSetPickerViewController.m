//
//  LZSetPickerViewController.m
//  Pods
//
//  Created by wm on 2020/12/14.
//

#import "LZSetPickerViewController.h"
#import <Masonry/Masonry.h>
#import "LSWAppColorConfigrationMacro.h"

@interface LZSetPickerViewController () <UIPickerViewDataSource, UIPickerViewDelegate>
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) UIView *btnBackView;
@property (nonatomic, strong) UIButton *cancleBtn;
@property (nonatomic, strong) UIButton *sureBtn;

@property (nonatomic, copy) NSMutableArray *selectAry;

@property (nonatomic, assign) NSUInteger selectComponent;
@property (nonatomic, assign) NSUInteger selectRow;

@end

@implementation LZSetPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.preferredContentSize = CGSizeMake(UIScreen.mainScreen.bounds.size.width, 300);    
    [self commonInit];
    for (int i = 0; i < self.dataSoureAry.count; i++) {
        self.selectAry[i] = self.dataSoureAry[i][0];
    }
    [self.pickerView reloadAllComponents];

}

- (void)commonInit {
    [self.view addSubview:self.btnBackView];
    [self.btnBackView addSubview:self.sureBtn];
    [self.btnBackView addSubview:self.cancleBtn];
    [self.view addSubview:self.pickerView];
    
    [self.btnBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.view);
        make.height.offset(43);
    }];
    
    [self.cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.btnBackView.mas_left).with.offset(10);
        make.centerY.mas_equalTo(self.btnBackView.mas_centerY).with.offset(0);
        make.top.bottom.mas_equalTo(self.btnBackView);
    }];
    
    [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.btnBackView.mas_right).with.offset(-10);
        make.centerY.mas_equalTo(self.btnBackView.mas_centerY).with.offset(0);
        make.top.bottom.mas_equalTo(self.btnBackView);
    }];
    
    [self.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.btnBackView.mas_bottom).with.offset(0);
    }];
}

#pragma mark - UIPickerViewDelegate
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 26;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.dataSoureAry[component][row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.selectComponent = component;
    self.selectRow = row;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        [pickerLabel setTextColor:[UIColor blackColor]];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont systemFontOfSize:18.0f]];
        pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    }
    return pickerLabel;
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return self.dataSoureAry.count;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.dataSoureAry[component].count;
}

- (void)selectRow:(NSInteger)row inComponent:(NSInteger)component animated:(BOOL)animated {
    [self.pickerView selectRow:row inComponent:component animated:animated];
}

- (NSInteger)selectedRowInComponent:(NSInteger)component {
    return [self.pickerView selectedRowInComponent:component];
}

#pragma mark - event
- (void)clickCancleBtn {
    if (self.delegate && [self.delegate respondsToSelector:@selector(pickerViewControllerCanceld:)]) {
        [self.delegate pickerViewControllerCanceld:self];
    }
}

- (void)clickSureBtn {
    if (self.delegate && [self.delegate respondsToSelector:@selector(pickerViewControllerDidSelect:)]) {
        
        [self.delegate pickerViewControllerDidSelect:self];
    }
}

#pragma mark - getter
- (UIPickerView *)pickerView {
    if (_pickerView == nil) {
        _pickerView = [[UIPickerView alloc] init];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
    }
    return _pickerView;
}

- (UIView *)btnBackView {
    if (!_btnBackView) {
        _btnBackView = [[UIView alloc] init];
        _btnBackView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
    }
    return _btnBackView;
}

- (UIButton *)cancleBtn {
    if (!_cancleBtn) {
        _cancleBtn = [[UIButton alloc] init];
        [_cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
        _cancleBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        [_cancleBtn setTitleColor:UIColorFromHex(0x057dff) forState:UIControlStateNormal];
        [_cancleBtn addTarget:self action:@selector(clickCancleBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancleBtn;
}

- (UIButton *)sureBtn {
    if (!_sureBtn) {
        _sureBtn = [[UIButton alloc] init];
        [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        _sureBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        [_sureBtn setTitleColor:UIColorFromHex(0x057dff) forState:UIControlStateNormal];
        [_sureBtn addTarget:self action:@selector(clickSureBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureBtn;
}

- (NSMutableArray *)selectAry {
    if (!_selectAry) {
        _selectAry = [[NSMutableArray alloc] init];
        for (int i = 0; i < self.dataSoureAry.count; i++) {
            [_selectAry addObject:@""];
        }
    }
    return _selectAry;
}

@end
