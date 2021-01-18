//
//  LZDialSetCollectionViewCell.m
//  LSBluetoothUI_iOS
//
//  Created by wm on 2020/12/8.
//

#import "LZDialSetCollectionViewCell.h"
#import <Masonry/Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface LZDialSetCollectionViewCell ()

@property (nonatomic, strong) UIImageView *dialImageView;
@property (nonatomic, strong) UIImageView *selectImageView;

@end

@implementation LZDialSetCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    self.selectImageView.image = [UIImage imageNamed:(selected ? @"DB_ic_multiselect_gray" : @"DB_ic_unselect_gray")];
}

- (void)createUI {
    [self.contentView addSubview:self.dialImageView];
    [self.contentView addSubview:self.selectImageView];
    
    [self.dialImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.contentView);
        make.height.offset(120);
        make.width.offset(60);
    }];
    
    [self.selectImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView.mas_centerX).offset(0);
        make.top.mas_equalTo(self.dialImageView.mas_bottom).offset(10);
        make.size.mas_equalTo(self.selectImageView.image.size);
    }];
}

#pragma mark - pudlic Methods

- (void)updateCellWithLZDiaSetModel:(LZDialSetModel *)model {
    
    [self.dialImageView sd_setImageWithURL:model.imageUrl completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            
    }];
}

#pragma mark - getter
- (UIImageView *)dialImageView {
    if (!_dialImageView) {
        _dialImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _dialImageView.backgroundColor = [UIColor grayColor];
    }
    return _dialImageView;
}

- (UIImageView *)selectImageView {
    if (!_selectImageView) {
        _selectImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _selectImageView.backgroundColor = [UIColor whiteColor];
        _selectImageView.image = [UIImage imageNamed:@"DB_ic_unselect_gray"];
    }
    return _selectImageView;
}

@end
