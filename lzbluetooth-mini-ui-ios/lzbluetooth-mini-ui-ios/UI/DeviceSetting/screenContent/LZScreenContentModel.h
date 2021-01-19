//
//  LZScreenContentModel.h
//  LSBluetoothUI_iOS
//
//  Created by wm on 2020/12/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LZScreenContentModel : NSObject
@property (nonatomic, copy) NSString *titleStr;
@property (nonatomic, assign) BOOL isSelect;
@property (nonatomic, assign) NSUInteger setType;

+ (NSArray <LZScreenContentModel *> *)cellModelList;
@end

NS_ASSUME_NONNULL_END
