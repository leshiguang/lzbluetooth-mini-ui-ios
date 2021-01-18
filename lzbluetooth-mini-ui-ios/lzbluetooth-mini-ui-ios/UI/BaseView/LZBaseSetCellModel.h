//
//  LZBaseSetCellModel.h
//  LSBluetoothUI_iOS
//
//  Created by wm on 2020/12/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
// cell样式
typedef enum : NSUInteger {
    DEVICESETCELLSTYLE_RIGHT_IMG,
    DEVICESETCELLSTYLE_RIGHT_SWITCH,
    DEVICESETCELLSTYLE_RIGHT_SUBTITLE,
    DEVICESETCELLSTYLE_RIGHT_IMG_SUBTITLE,
    DEVICESETCELLSTYLE_UNBIND_DEVICE,
    DEVICESETCELLSTYLE_RIGHT_SELECTIMAGE
} DEVICESETCELLSTYLE;

@interface LZBaseSetCellModel : NSObject
@property (nonatomic, assign) DEVICESETCELLSTYLE cellStyle;
@property (nonatomic, strong) NSString *titleStr;
@property (nonatomic, strong) NSString *subStr;
@property (nonatomic, assign) NSUInteger setType;
@property (nonatomic, assign) BOOL switchIsOpne;

- (LZBaseSetCellModel *)initModelWithSetType:(NSUInteger)setType
                                   cellStyle:(DEVICESETCELLSTYLE)cellStyle
                                    titleStr:(NSString * _Nullable)titleStr
                                      subStr:(NSString * _Nullable)subStr;

+ (NSArray <__kindof LZBaseSetCellModel *> *)cellModelList;

@end

NS_ASSUME_NONNULL_END
