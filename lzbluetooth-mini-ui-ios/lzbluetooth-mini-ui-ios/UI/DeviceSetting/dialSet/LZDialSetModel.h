//
//  LZDialSetModel.h
//  LSBluetoothUI_iOS
//
//  Created by wm on 2020/12/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LZDialSetModel : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSInteger dialModeType;
@property (nonatomic, strong) NSURL *imageUrl;

+ (NSArray <LZDialSetModel *> *)dialSetModel;

@end

NS_ASSUME_NONNULL_END
