//
//  LZBaseDeviceInfoViewController.m
//  lzbluetooth-mini-ui-ios
//
//  Created by tanjian on 2021/1/25.
//

#import "LZBaseDeviceInfoViewController.h"
#import <Masonry/Masonry.h>
#import "LZSettingTableViewCell.h"
#import "LZDeviceSettingDBUtil.h"

//设置类型
typedef enum : NSUInteger {
    DEVICESETTYPE_DEVICE_NAME,                          //设备名称
    DEVICESETTYPE_MAC,                                  //MAC地址
    DEVICESETTYPE_SN,
    DEVICESETTYPE_REMLTIMEHR, // 实时心率
    DEVICESETTYPE_FOTA, //固件升级
    DEVICESETTYPE_UNBIND, //解除绑定
    
} DEVICESETTYPE;

typedef NS_ENUM(NSUInteger, LZDeviceInfoType) {
    LZDeviceInfoTypeName,
    LZDeviceInfoTypeMac,
    LZDeviceInfoTypeSN,
    LZDeviceInfoTypeOTA,
    LZDeviceInfoTypeUnbind
};

@interface LZBaseDeviceInfoViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray <LZBaseSetCellModel *> * dataSourceAry;

@end

@implementation LZBaseDeviceInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设备详情";
    self.view.backgroundColor = [UIColor whiteColor];
    [self createUI];
    [self reloadData];
}

- (void)createUI {
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)reloadData {
    [self.dataSourceAry enumerateObjectsUsingBlock:^(LZBaseSetCellModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        switch (obj.setType) {
            case DEVICESETTYPE_DEVICE_NAME:
                obj.subStr = self.device.name;
                break;
            case DEVICESETTYPE_MAC:
                obj.subStr = self.device.mac;
                break;
            case DEVICESETTYPE_SN:
                obj.subStr = self.device.sn;
                break;
            case DEVICESETTYPE_FOTA:
                obj.subStr = self.device.deviceInfo[kLZBluetoothDeviceInfoKeySoftwareVersion];
                break;
                
            default:
                break;
        }
    }];
    [self.tableView reloadData];
}

#pragma mark - LZSettingTableViewCellDelegate
- (void)unbindClick:(LZBaseSetCellModel *)cellModel {
//    __weak typeof(self) weakSelf = self;
    [self.deviceManager deleteMonitorDeviceWithMacString:self.device.mac];
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - cell select
- (void)cellSelect:(LZBaseSetCellModel *)model {
    NSString *className = nil;
    switch (model.setType) {
        case DEVICESETTYPE_UNBIND:
            [self unbindClick:model];
            break;
        case LZDeviceSettingTypeDial: {
            className = @"LZDialSetViewController";
        }
            break;
        case LZDeviceSettingTypeTargetEncourage: {
            className = @"LZGoalSetViewController";
        }
            break;
        case LZDeviceSettingTypeEventReminder: {
            className = @"LZEventToRemindViewController";
        }
            break;
        case LZDeviceSettingTypeCustomSportHrReminder: {
            className = @"LZHeartRataWarningViewController";
        }
            break;
        case LZDeviceSettingTypeMsgReminder: {
            className = @"LZMessageToRemindViewController";
        }
            break;
        case LZDeviceSettingTypeNightMode: {
            className = @"LZNightModeViewController";
        }
            break;
        case LZDeviceSettingTypeNoDisturb: {
            className = @"LZDndModeViewController";
        }
            break;
        case LZDeviceSettingTypeScreenDirection: {
            className = @"LZScreenOrientationViewController";
        }
            break;
        case LZDeviceSettingTypeTimeMode: {
            className = @"LZTimeFormatViewController";
        }
            break;
        case LZDeviceSettingTypeWristHabit: {
            className = @"LZWearingHabitsViewController";
        }
            break;
        case LZDeviceSettingTypeCustomScreen: {
            className = @"LZScreenContentViewController";
        }
            break;
        case LZDeviceSettingTypeSmartHrDetection: {
            className = @"LZHRReminderViewController";
        }
            break;
        case LZDeviceSettingTypeLanguage: {
            className = @"LZLanguageSettingViewController";
            break;
        }
        case LZDeviceSettingTypeSwiming: {
            className = @"LZSwimingViewController";
            break;
        }
        case LZDeviceSettingTypeWeather: {
            className = @"LZWeatherViewController";
            break;
        }
        case LZDeviceSettingTypeUnit: {
            className = @"LZUnitViewController";
            break;
        }

        case LZDeviceSettingTypeScaleUnit: {
            className = @"LZScaleUnitViewController";
            break;
        }
        case LZDeviceSettingTypeWifiScan: {
            className = @"LZWifiSettingViewController";
        }
        case LZDeviceSettingTypeSedentaryRemainder: {
            className = @"LZLongSitViewController";
            break;
        }
        case LZDeviceSettingTypeRealtimeHR: {
            className = @"LZReadRealTimeHRViewController";
            break;
        }
          
        default:
            break;
    }
    
    if (className) {
        LZDeviceManagerViewController *vc = [[NSClassFromString(className) alloc] init];
        if (vc) {
            vc.device = self.device;
            vc.settingType = model.setType;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == self.dataSourceAry.count-1) {
        return 100;
    }
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    LZBaseSetCellModel *model = self.dataSourceAry[indexPath.row];
    [self cellSelect:model];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSourceAry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LZSettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LZSettingTableViewCell class])];
    cell.unbindButton.userInteractionEnabled = NO;
    [cell updateCellWithModel:self.dataSourceAry[indexPath.row]];
    return cell;
}

#pragma mark - getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[LZSettingTableViewCell class] forCellReuseIdentifier:NSStringFromClass([LZSettingTableViewCell class])];
    }
    return _tableView;
}

- (NSArray<LZBaseSetCellModel *> *)dataSourceAry {
    if (!_dataSourceAry) {
        
        NSMutableArray *mAry = [[NSMutableArray alloc] init];
        
        LZBaseSetCellModel *model1 = [[LZBaseSetCellModel alloc] initModelWithSetType:DEVICESETTYPE_DEVICE_NAME cellStyle:DEVICESETCELLSTYLE_RIGHT_SUBTITLE titleStr:@"设备名称" subStr:@"乐心手环Mambo HR 2"];
        [mAry addObject:model1];
        
        LZBaseSetCellModel *model2 = [[LZBaseSetCellModel alloc] initModelWithSetType:DEVICESETTYPE_MAC cellStyle:DEVICESETCELLSTYLE_RIGHT_SUBTITLE titleStr:@"MAC地址" subStr:@"C4:03:53:20:39:ID"];
        [mAry addObject:model2];
        
        LZBaseSetCellModel *model3 = [[LZBaseSetCellModel alloc] initModelWithSetType:DEVICESETTYPE_SN cellStyle:DEVICESETCELLSTYLE_RIGHT_SUBTITLE titleStr:@"sn" subStr:@""];
        [mAry addObject:model3];
        
        for (NSNumber *settingType in [self supportSettings]) {
            LZBaseSetCellModel *model = [[LZBaseSetCellModel alloc] initModelWithSetType:settingType.integerValue cellStyle:DEVICESETCELLSTYLE_RIGHT_IMG_SUBTITLE titleStr:[LZDeviceSettingDBUtil titleWithSettingType:settingType.integerValue] subStr:@""];
            [mAry addObject:model];
        }
        
        LZBaseSetCellModel *otaModel = [[LZBaseSetCellModel alloc] initModelWithSetType:DEVICESETTYPE_FOTA cellStyle:DEVICESETCELLSTYLE_RIGHT_IMG_SUBTITLE titleStr:@"固件升级" subStr:@""];
        [mAry addObject:otaModel];
        
        LZBaseSetCellModel *unbindModel = [[LZBaseSetCellModel alloc] initModelWithSetType:DEVICESETTYPE_UNBIND cellStyle:DEVICESETCELLSTYLE_UNBIND_DEVICE titleStr:nil subStr:nil];
        [mAry addObject:unbindModel];
        
        _dataSourceAry = mAry;
    }
    return _dataSourceAry;
}

- (NSArray <NSNumber *> *)supportSettings {
    switch (self.device.deviceType) {
        case LZDeviceTypeBracelet:
            return [self braceletSupportSettings];
        case LZDeviceTypeScale:
            return [self scaleSupportSettings];
        case LZDeviceTypeBloodPressure:
            return [self bloodPressureSupportSettings];
        default:
            return @[];
    }
}

- (NSArray <NSNumber *> *)braceletSupportSettings {
    return @[
        @(LZDeviceSettingTypeDial),
        @(LZDeviceSettingTypeTargetEncourage),
        @(LZDeviceSettingTypeEventReminder),
        @(LZDeviceSettingTypeCustomSportHrReminder),
        @(LZDeviceSettingTypeSmartHrDetection),
        @(LZDeviceSettingTypeMsgReminder),
        @(LZDeviceSettingTypeNightMode),
        @(LZDeviceSettingTypeNoDisturb),
        @(LZDeviceSettingTypeScreenDirection),
        @(LZDeviceSettingTypeTimeMode),
        @(LZDeviceSettingTypeWristHabit),
        @(LZDeviceSettingTypeCustomScreen),
        @(LZDeviceSettingTypeLanguage),
        @(LZDeviceSettingTypeSwiming),
        @(LZDeviceSettingTypeWeather),
        @(LZDeviceSettingTypeUnit),
        @(LZDeviceSettingTypeSedentaryRemainder),
        @(LZDeviceSettingTypeRealtimeHR)
    ];
}

- (NSArray <NSNumber *> *)scaleSupportSettings {
    return @[
        @(LZDeviceSettingTypeWifiScan),
        @(LZDeviceSettingTypeScaleUnit)
    ];
}

- (NSArray <NSNumber *> *)bloodPressureSupportSettings {
    return @[
        
    ];
}

@end
