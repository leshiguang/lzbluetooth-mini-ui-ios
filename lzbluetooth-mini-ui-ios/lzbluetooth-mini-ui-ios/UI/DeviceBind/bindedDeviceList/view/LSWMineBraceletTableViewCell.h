//
//  LSWMineBraceletTableViewCell.h
//  LSWearable
//
//  Created by malai on 2016/12/10.
//  Copyright © 2016年 lifesense. All rights reserved.
//

#import <UIKit/UIKit.h>


@class LZBaseDevice;

@interface LSWMineBraceletTableViewCell : UITableViewCell

- (void)updateUIWithDevice:(LZBaseDevice *)LSDevice isOnlyOne:(BOOL)isOnlyOne bluetoothEnabled:(BOOL)bluetoothEnabled;
@end
