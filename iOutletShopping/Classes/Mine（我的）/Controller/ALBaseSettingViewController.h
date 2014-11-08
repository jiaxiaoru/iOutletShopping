//
//  ALBaseSettingViewController.h
//  iOutletShopping
//
//  Created by Huashen on 14-9-27.
//  Copyright (c) 2014年 aolaigo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALSettingGroup.h"
#import "ALSettingItem.h"
#import "ALSettingArrowItem.h"
#import "ALSettingSwitchItem.h"
#import "ALSettingLabelItem.h"

@interface ALBaseSettingViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *_allGroups; // 所有的组模型
}
@property (nonatomic, weak, readonly) UITableView *tableView;

@end
