//
//  ALSettingCell.h
//  iOutletShopping
//
//  Created by Huashen on 14-9-27.
//  Copyright (c) 2014年 aolaigo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALSettingItem.h"
// 获得RGB颜色
#define kColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define ALGlobalBg kColor(226, 226, 226)

@interface ALSettingCell : UITableViewCell
@property (nonatomic, strong) ALSettingItem *item;
//@property (nonatomic, strong) NSIndexPath *indexPath;

+ (instancetype)settingCellWithTableView:(UITableView *)tableView;
@end
