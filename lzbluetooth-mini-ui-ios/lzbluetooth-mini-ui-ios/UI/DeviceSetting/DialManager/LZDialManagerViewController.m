//
//  LZDialManagerViewController.m
//  lzbluetooth-mini-ui-ios
//
//  Created by tanjian on 2021/11/17.
//

#import "LZDialManagerViewController.h"

typedef NS_ENUM(NSUInteger, LZUIDialAction) {
   
    LZUIDialActionPushPhoto,
    LZUIDialActionPushYun1,
    LZUIDialActionPushYun2,
    LZUIDialActionDelete,
    LZUIDialActionSelect1,
    LZUIDialActionSelect2,
    LZUIDialActionSelect3,
    LZUIDialActionSelect4,
    LZUIDialActionSelect5,
    LZUIDialActionSelect6,
    LZUIDialActionSelect7,
};

@interface LZDialManagerViewController ()

@property (nonatomic, strong) NSArray *list;

@end

@implementation LZDialManagerViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.list = @[
        @(LZUIDialActionPushPhoto),
        @(LZUIDialActionPushYun1),
        @(LZUIDialActionPushYun2),
        @(LZUIDialActionDelete),
        @(LZUIDialActionSelect1),
        @(LZUIDialActionSelect2),
        @(LZUIDialActionSelect3),
        @(LZUIDialActionSelect4),
        @(LZUIDialActionSelect5),
        @(LZUIDialActionSelect6),
        @(LZUIDialActionSelect7),
      
    ];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LZBaseSetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(LZBaseSetTableViewCell.class) forIndexPath:indexPath];
    LZUIDialAction action = [self.list[indexPath.row] integerValue];
    
    cell.titleLabel.text = [self titleFor:action];

    cell.rightSelectImageView.hidden = NO;
    return cell;
}
    
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    LZUIDialAction action = [self.list[indexPath.row] integerValue];
    switch (action) {
            
        case LZUIDialActionPushPhoto: {
            [self pushPhoto];
            break;
        }
        case LZUIDialActionPushYun1: {
            [self pushYun1];
            break;
        }
        case LZUIDialActionPushYun2: {
            [self pushYun2];
            break;
        }
        case LZUIDialActionDelete:{
            [self deleteDial];
            break;
        }
        case LZUIDialActionSelect1:{
            [self selectDiaWithIndex:1];
            break;
        }
        case LZUIDialActionSelect2:{
            [self selectDiaWithIndex:2];
            break;
        }
        case LZUIDialActionSelect3:{
            [self selectDiaWithIndex:3];
            break;
        }
        case LZUIDialActionSelect4:{
            [self selectDiaWithIndex:4];
            break;
        }
        case LZUIDialActionSelect5:{
            [self selectDiaWithIndex:5];
            break;
        }
        case LZUIDialActionSelect6:{
            [self selectDiaWithIndex:6];
            break;
        }
        case LZUIDialActionSelect7:{
            [self selectDiaWithIndex:7];
            break;
        }
            
    }
}
    
- (void)deleteDial {
    LZA5SettingMutipleData *temp = [LZA5SettingMutipleData new];
    LZMDeleteDialInfo *info = [[LZMDeleteDialInfo alloc] init];
    info.tag = LZSettingTagDeleteDial;
    LZMDialInfoObj *obj = [LZMDialInfoObj new];
    obj.dialType = 1;
    obj.index = 5;
    info.list = @[obj];
    temp.settings = @[info];
    [self.device sendDataModel:temp completion:^(LZBluetoothErrorCode result, id  _Nullable response) {
        NSLog(@"表盘删除 result %@", @(result));
    }];
}

- (void)pushPhoto {
    
    UIImage *image = [UIImage imageNamed:@"home_page_bluetooth"];
    NSString *model = self.device.deviceInfo[kLZBluetoothDeviceInfoKeyModelName];
    NSData *data = nil;
    if ([model containsString:@"456"]) {
        data = [LZDialUtil packingWatchFaceFileWithImage:image size:CGSizeMake(120, 240) previewSize:CGSizeMake(90, 180) model:model];
    } else if ([model containsString:@"437"]) {
        data = [LZDialUtil packingWatchFaceFileWithImage:image size:CGSizeMake(240, 240) previewSize:CGSizeMake(148, 148) model:model];
    } else if ([model containsString:@"460"]) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"template" ofType:@"bin"];
        NSData *templateData = [NSData dataWithContentsOfFile:path];
        data = [LZDialUtil packingWatchFaceFileWithTemplateData:templateData image:image size:CGSizeMake(320, 385) previewSize:CGSizeMake(256, 308) model:model];
    } else {
        NSAssert(NO, @"不支持相册表盘");
    }
    
    
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"WatchFace-Custom" ofType:@"bin"];
//
//    NSData *data = [NSData dataWithContentsOfFile:path];
//    NSData *result = [LZDialUtil compressWithData:data fileName:@"WatchFace-Custom" model:@"456B1"];
    
    LZA5SettingPushDialData *temp = [LZA5SettingPushDialData new];
    temp.id = @"5";
    // hr 相册表盘位置固定在5的位置
    temp.dialIndex = 5;
    temp.dialType = 1;
    temp.fileBuf = data;
    temp.backgroundImageName = @"test";
    temp.fileName = @"test";
    static UInt32 styleId = 0;
    temp.styleId = styleId;
    styleId += 1;
    temp.progress = ^(double progress) {
        NSLog(@"进度 %@", @(progress));
    };
    
    [self.device sendDataModel:temp completion:^(LZBluetoothErrorCode result, id  _Nullable response) {
        NSLog(@"表盘发送 result %@", @(result));
    }];
}

- (void)pushYun1 {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"WatchFace124.lzo" ofType:@"lsf"];
    
    NSData *data = [NSData dataWithContentsOfFile:path];
    LZA5SettingPushDialData *temp = [LZA5SettingPushDialData new];
    temp.id = @"6";
    // hr 6云端表盘控制位置在 6与7的位置
    temp.dialIndex = 6;
    temp.dialType = 0;
    temp.fileBuf = data;
    temp.backgroundImageName = @"test";
    temp.fileName = @"test";
    temp.progress = ^(double progress) {
        NSLog(@"进度 %@", @(progress));
    };
    
    [self.device sendDataModel:temp completion:^(LZBluetoothErrorCode result, id  _Nullable response) {
        NSLog(@"表盘发送 result %@", @(result));
    }];
}

- (void)pushYun2 {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"WatchFace124.lzo" ofType:@"lsf"];
    
    NSData *data = [NSData dataWithContentsOfFile:path];
    LZA5SettingPushDialData *temp = [LZA5SettingPushDialData new];
    temp.id = @"7";
    // hr 6云端表盘控制位置在 6与7的位置
    temp.dialIndex = 7;
    temp.dialType = 0;
    temp.fileBuf = data;
    temp.backgroundImageName = @"test";
    temp.fileName = @"test";
    temp.progress = ^(double progress) {
        NSLog(@"进度 %@", @(progress));
    };
    
    [self.device sendDataModel:temp completion:^(LZBluetoothErrorCode result, id  _Nullable response) {
        NSLog(@"表盘发送 result %@", @(result));
    }];
}
    
- (void)selectDiaWithIndex:(UInt32)index {
    LZA5SettingDialEnableData *temp = [LZA5SettingDialEnableData new];
    temp.dialIndex = index;
    temp.list = @[@1, @2, @3, @4, @5, @6, @7];
    [self.device sendDataModel:temp completion:^(LZBluetoothErrorCode result, id  _Nullable response) {
        NSLog(@"选择表盘 result %@", @(result));
    }];
}

- (NSString *)titleFor:(LZUIDialAction)action {
    switch (action) {
        case LZUIDialActionPushPhoto:
            return @"推送相册表盘";
        case LZUIDialActionPushYun1:
            return @"推送云端表盘1";
        case LZUIDialActionPushYun2:
            return @"推送云端表盘2";
        case LZUIDialActionDelete:
            return @"删除表盘";
        case LZUIDialActionSelect1:
            return @"选择表盘1";
        case LZUIDialActionSelect2:
            return @"选择表盘2";
        case LZUIDialActionSelect3:
            return @"选择表盘3";
        case LZUIDialActionSelect4:
            return @"选择表盘4";
        case LZUIDialActionSelect5:
            return @"选择表盘5";
        case LZUIDialActionSelect6:
            return @"选择表盘6";
        case LZUIDialActionSelect7:
            return @"选择表盘7";
            
    }
    return @"";
}

@end
