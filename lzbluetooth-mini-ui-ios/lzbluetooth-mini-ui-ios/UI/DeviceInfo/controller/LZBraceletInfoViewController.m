//
//  LZBraceletInfoViewController.m
//  LSBluetoothUI_iOS
//
//  Created by wm on 2020/12/2.
//

#import "LZBraceletInfoViewController.h"
#import <Masonry/Masonry.h>
#import "LZSettingTableViewCell.h"


//设置类型
typedef enum : NSUInteger {
    DEVICESETTYPE_DEVICE_NAME,                          //设备名称
    DEVICESETTYPE_MAC,                                  //MAC地址
    DEVICESETTYPE_SN,
    DEVICESETTYPE_FOTA, //固件升级
    DEVICESETTYPE_UNBIND, //解除绑定
} DEVICESETTYPE;


@interface LZBraceletInfoViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray <LZBaseSetCellModel *> * dataSourceAry;

@property (nonatomic, assign) BOOL callRemindingIsOpen;
@property (nonatomic, assign) BOOL hearRateMonitorIsOpen;
@end

@implementation LZBraceletInfoViewController

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
        case LZBraceletSettingTypeDial: {
            className = @"LZDialSetViewController";
        }
            break;
        case LZBraceletSettingTypeTargetEncourage: {
            className = @"LZGoalSetViewController";
        }
            break;
        case LZBraceletSettingTypeEventReminder: {
            className = @"LZEventToRemindViewController";
        }
            break;
        case LZBraceletSettingTypeCustomSportHrReminder: {
            className = @"LZHeartRataWarningViewController";
        }
            break;
        case LZBraceletSettingTypeMsgReminder: {
            className = @"LZMessageToRemindViewController";
        }
            break;
        case LZBraceletSettingTypeNightMode: {
            className = @"LZNightModeViewController";
        }
            break;
        case LZBraceletSettingTypeNoDisturb: {
            className = @"LZDndModeViewController";
        }
            break;
        case LZBraceletSettingTypeScreenDirection: {
            className = @"LZScreenOrientationViewController";
        }
            break;
        case LZBraceletSettingTypeTimeMode: {
            className = @"LZTimeFormatViewController";
        }
            break;
        case LZBraceletSettingTypeWristHabit: {
            className = @"LZWearingHabitsViewController";
        }
            break;
        case LZBraceletSettingTypeCustomScreen: {
            className = @"LZScreenContentViewController";
        }
            break;
        case LZBraceletSettingTypeSmartHrDetection: {
            className = @"LZHRReminderViewController";
        }
            break;
        case LZBraceletSettingTypeLanguage: {
            className = @"LZLanguageSettingViewController";
            break;
        }
        case LZBraceletSettingTypeSwiming: {
            className = @"LZSwimingViewController";
            break;
        }
        case LZBraceletSettingTypeWeather: {
            className = @"LZWeatherViewController";
            break;
        }
        case LZBraceletSettingTypeUnit: {
            className = @"LZUnitViewController";
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
        
        LZBaseSetCellModel *model4 = [[LZBaseSetCellModel alloc] initModelWithSetType:LZBraceletSettingTypeDial cellStyle:DEVICESETCELLSTYLE_RIGHT_IMG titleStr:@"表盘样式" subStr:nil];
        [mAry addObject:model4];
        
        LZBaseSetCellModel *model5 = [[LZBaseSetCellModel alloc] initModelWithSetType:LZBraceletSettingTypeTargetEncourage cellStyle:DEVICESETCELLSTYLE_RIGHT_IMG titleStr:@"目标设置" subStr:nil];
        [mAry addObject:model5];
        
        LZBaseSetCellModel *model6 = [[LZBaseSetCellModel alloc] initModelWithSetType:LZBraceletSettingTypeEventReminder cellStyle:DEVICESETCELLSTYLE_RIGHT_IMG titleStr:@"事件提醒" subStr:nil];
        [mAry addObject:model6];
        
        LZBaseSetCellModel *model7 = [[LZBaseSetCellModel alloc] initModelWithSetType:LZBraceletSettingTypeCustomSportHrReminder cellStyle:DEVICESETCELLSTYLE_RIGHT_IMG titleStr:@"心率预警" subStr:nil];
        [mAry addObject:model7];
        
        LZBaseSetCellModel *model8 = [[LZBaseSetCellModel alloc] initModelWithSetType:LZBraceletSettingTypeSmartHrDetection cellStyle:DEVICESETCELLSTYLE_RIGHT_IMG titleStr:@"心率监测" subStr:nil];
        [mAry addObject:model8];
        
        LZBaseSetCellModel *model9 = [[LZBaseSetCellModel alloc] initModelWithSetType:LZBraceletSettingTypeMsgReminder cellStyle:DEVICESETCELLSTYLE_RIGHT_IMG titleStr:@"消息提醒" subStr:nil];
        [mAry addObject:model9];
        
        LZBaseSetCellModel *model10 = [[LZBaseSetCellModel alloc] initModelWithSetType:LZBraceletSettingTypeNightMode cellStyle:DEVICESETCELLSTYLE_RIGHT_IMG titleStr:@"夜间模式" subStr:nil];
        [mAry addObject:model10];
        
        LZBaseSetCellModel *model11 = [[LZBaseSetCellModel alloc] initModelWithSetType:LZBraceletSettingTypeNoDisturb cellStyle:DEVICESETCELLSTYLE_RIGHT_IMG titleStr:@"勿扰模式" subStr:nil];
        [mAry addObject:model11];
        
        LZBaseSetCellModel *model12 = [[LZBaseSetCellModel alloc] initModelWithSetType:LZBraceletSettingTypeScreenDirection cellStyle:DEVICESETCELLSTYLE_RIGHT_IMG titleStr:@"屏幕方向" subStr:nil];
        [mAry addObject:model12];

        LZBaseSetCellModel *model14 = [[LZBaseSetCellModel alloc] initModelWithSetType:LZBraceletSettingTypeCustomScreen cellStyle:DEVICESETCELLSTYLE_RIGHT_IMG titleStr:@"屏幕内容" subStr:nil];
        [mAry addObject:model14];

        LZBaseSetCellModel *model15 = [[LZBaseSetCellModel alloc] initModelWithSetType:LZBraceletSettingTypeTimeMode cellStyle:DEVICESETCELLSTYLE_RIGHT_IMG titleStr:@"时间制式" subStr:nil];
        [mAry addObject:model15];
        
        LZBaseSetCellModel *model16 = [[LZBaseSetCellModel alloc] initModelWithSetType:LZBraceletSettingTypeWristHabit cellStyle:DEVICESETCELLSTYLE_RIGHT_IMG titleStr:@"佩戴习惯" subStr:nil];
        [mAry addObject:model16];
        
        LZBaseSetCellModel *model17 = [[LZBaseSetCellModel alloc] initModelWithSetType:LZBraceletSettingTypeLanguage cellStyle:DEVICESETCELLSTYLE_RIGHT_IMG titleStr:@"语言" subStr:nil];
        [mAry addObject:model17];
        
        LZBaseSetCellModel *model18 = [[LZBaseSetCellModel alloc] initModelWithSetType:LZBraceletSettingTypeSwiming cellStyle:DEVICESETCELLSTYLE_RIGHT_IMG titleStr:@"游泳" subStr:nil];
        [mAry addObject:model18];
        
        LZBaseSetCellModel *model19 = [[LZBaseSetCellModel alloc] initModelWithSetType:LZBraceletSettingTypeWeather cellStyle:DEVICESETCELLSTYLE_RIGHT_IMG titleStr:@"天气" subStr:nil];
        [mAry addObject:model19];
        
        LZBaseSetCellModel *model20 = [[LZBaseSetCellModel alloc] initModelWithSetType:LZBraceletSettingTypeUnit cellStyle:DEVICESETCELLSTYLE_RIGHT_IMG titleStr:@"单位" subStr:nil];
        [mAry addObject:model20];
        
        LZBaseSetCellModel *otaModel = [[LZBaseSetCellModel alloc] initModelWithSetType:DEVICESETTYPE_FOTA cellStyle:DEVICESETCELLSTYLE_RIGHT_IMG_SUBTITLE titleStr:@"固件升级" subStr:@""];
        [mAry addObject:otaModel];
        
        LZBaseSetCellModel *unbindModel = [[LZBaseSetCellModel alloc] initModelWithSetType:DEVICESETTYPE_UNBIND cellStyle:DEVICESETCELLSTYLE_UNBIND_DEVICE titleStr:nil subStr:nil];
        [mAry addObject:unbindModel];
        
        _dataSourceAry = mAry;
    }
    return _dataSourceAry;
}

@end
