//
//  LZEventToRemindTableViewCell.m
//  LSBluetoothUI_iOS
//
//  Created by wm on 2020/12/8.
//

#import "LZEventToRemindTableViewCell.h"
#import <Masonry/Masonry.h>
#import "LSWAppColorConfigrationMacro.h"

@interface LZEventToRemindTableViewCell ()

@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UILabel *eventLabel;
@property (nonatomic,strong) UIImageView *delectImageView;

@end


@implementation LZEventToRemindTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createUI];
    }
    return self;
}

- (void)createUI {
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.eventLabel];
    [self.contentView addSubview:self.delectImageView];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView.mas_leading).with.offset(15);
        make.top.equalTo(self.contentView.mas_top).with.offset(15);
        make.width.offset(80);
    }];
    
    [self.eventLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.timeLabel.mas_trailing).with.offset(0);
        make.topMargin.equalTo(self.timeLabel.mas_topMargin);
        make.trailing.equalTo(self.delectImageView.mas_leading).with.offset(-10);
        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-15);
    }];

    [self.delectImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.contentView.mas_trailing).with.offset(-15);
        make.centerY.equalTo(self.timeLabel.mas_centerY);
        make.size.mas_equalTo(self.delectImageView.image.size);
    }];
    
}


#pragma mark - getter
- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _timeLabel.text = @"20:00";
        _timeLabel.font = [UIFont systemFontOfSize:16];
        _timeLabel.textColor = [UIColor blackColor];
        _timeLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _timeLabel;
}

- (UILabel *)eventLabel {
    if (!_eventLabel) {
        _eventLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _eventLabel = [[UILabel alloc] init];
        _eventLabel.text = @"阿拉阿拉阿拉阿拉阿拉";
        _eventLabel.font = [UIFont systemFontOfSize:14];
        _eventLabel.textColor = LSWWeakContentFontColor;
        _eventLabel.textAlignment = NSTextAlignmentLeft;
        _eventLabel.numberOfLines = 0;
    }
    return _eventLabel;
}

- (UIImageView *)delectImageView {
    if (!_delectImageView) {
        _delectImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:(@"scale_ic_alarm_delete")]];
    }
    return _delectImageView;
}
@end
