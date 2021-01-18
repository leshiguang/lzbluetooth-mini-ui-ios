//
//  LZDialSetModel.m
//  LSBluetoothUI_iOS
//
//  Created by wm on 2020/12/8.
//

#import "LZDialSetModel.h"

@implementation LZDialSetModel

- (instancetype)initWithDialModeType:(NSInteger)dialModelType name:(NSString *)name imageUrl:(NSURL *)imageUrl {
    self = [super init];
    if (self) {
        self.dialModeType = dialModelType;
        self.name  = name;
        self.imageUrl = imageUrl;
    }
    return self;
}


+ (NSArray <LZDialSetModel *> *)dialSetModel {
    
    NSMutableArray<LZDialSetModel *> *dataItems = [[NSMutableArray alloc] init];
//    NSArray<LSEDialProertyValue *> *dialProperties = [deviceInfo getDialProperties];
    for (NSInteger i = 0; i < 4; i++) {
        LZDialSetModel *item = [[LZDialSetModel alloc] initWithDialModeType:i name:@"" imageUrl:nil];
        [dataItems addObject:item];
    }
    return [dataItems copy];
}
@end
