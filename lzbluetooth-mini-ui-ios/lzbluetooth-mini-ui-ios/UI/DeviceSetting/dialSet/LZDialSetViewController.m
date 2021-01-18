//
//  LZDialSetViewController.m
//  LSBluetoothUI_iOS
//
//  Created by wm on 2020/12/8.
//

#import "LZDialSetViewController.h"
#import "LZDialSetCollectionViewCell.h"
#import <Masonry/Masonry.h>
#import "LZDialSetModel.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width

@interface LZDialSetViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray <LZDialSetModel *> *modelAry;
@property (nonatomic, assign) NSInteger selectedDialModeType;



@end

@implementation LZDialSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"表盘样式";
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatUI];
    [self initSetData];
}



- (void)creatUI {
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

- (void)updateUIWithResult:(LZBluetoothErrorCode)result {
    if (result != LZBluetoothErrorCodeSuccess) {
        [self initSetData];
    }
}

- (void)initSetData {
    [self.collectionView selectItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UICollectionViewScrollPositionNone];
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self setDialModel:indexPath.row + 1];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.modelAry.count;
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LZDialSetCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([LZDialSetCollectionViewCell class]) forIndexPath:indexPath];
    if (!cell) {
        cell = [[LZDialSetCollectionViewCell alloc] init];
    }
    [cell updateCellWithLZDiaSetModel:self.modelAry[indexPath.row]];
    return cell;
}

#pragma mark - Private Methods
- (void)setDialModel:(NSInteger)model {
    LZA5SettingDialTypeData *data = [[LZA5SettingDialTypeData alloc] init];
    data.dialType = model;
    [self sendData:data];
}

#pragma mark - getter
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        CGFloat itemW = kScreenWidth/2.0;
        layout.itemSize = CGSizeMake(itemW, itemW);
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        layout.headerReferenceSize = CGSizeMake(kScreenWidth, 0);
        layout.footerReferenceSize = CGSizeMake(kScreenWidth, 0);
        if (@available(iOS 9.0, *)) {
            layout.sectionHeadersPinToVisibleBounds = NO;
            layout.sectionFootersPinToVisibleBounds = NO;
        } else {
            
        }
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[LZDialSetCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([LZDialSetCollectionViewCell class])];
    }
    return _collectionView;
}

- (NSArray<LZDialSetModel *> *)modelAry {
    if (!_modelAry) {
        _modelAry = [[NSArray alloc] init];
        _modelAry = [LZDialSetModel dialSetModel];
    }
    return _modelAry;
}

@end
