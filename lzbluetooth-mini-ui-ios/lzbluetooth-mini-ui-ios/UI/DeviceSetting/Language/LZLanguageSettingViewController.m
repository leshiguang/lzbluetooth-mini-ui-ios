//
//  LZLanguageSettingViewController.m
//  lzbluetooth-mini-ui-ios
//
//  Created by tanjian on 2021/1/19.
//

#import "LZLanguageSettingViewController.h"


@interface LZLanguageSettingViewController ()

@property (nonatomic, strong) LZA5SettingLanguageData *data;

@end

@implementation LZLanguageSettingViewController

@dynamic data;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *array = @[
      @(LZA5LanguageCodeCN),
      @(LZA5LanguageCodeFrench),
      @(LZA5LanguageCodeJapenese),
      @(LZA5LanguageCodeEnglish),
      @(LZA5LanguageCodeKorean),
      @(LZA5LanguageCodeTW),
    ];
    [self.dataSource addObject:array.mutableCopy];
    
    [self updateUI];
}

- (void)updateUI {
    NSMutableArray *array = self.dataSource[0];
    NSInteger index = [array indexOfObject:@(self.data.languageCode)];
    [self.tableView reloadData];
    if (index != NSNotFound) {
        [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LZBaseSetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(LZBaseSetTableViewCell.class) forIndexPath:indexPath];
    NSNumber *code = self.dataSource[indexPath.section][indexPath.row];
    cell.titleLabel.text = [self languageStringWithCode:code.integerValue];
    cell.rightSelectImageView.hidden = NO;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSNumber *code = self.dataSource[indexPath.section][indexPath.row];
    self.data.languageCode = code.integerValue;
    [self sendData:self.data];
}

- (NSString *)languageStringWithCode:(LZA5LanguageCode)languageCode {
    switch (languageCode) {
        case LZA5LanguageCodeCN:
            return @"中文简体";
        case LZA5LanguageCodeTW:
            return @"中文繁体";
        case LZA5LanguageCodeFrench:
            return @"法语";
        case LZA5LanguageCodeKorean:
            return @"韩语";
        case LZA5LanguageCodeEnglish:
            return @"英语";
        case LZA5LanguageCodeJapenese:
            return @"日文";
        default:
            NSAssert(NO, @"不支持的code");
            break;
    }
    return @"";
}

@end
