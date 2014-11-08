//
//  ALRemindViewController.m
//  iOutletShopping
//
//  Created by Huashen on 14-9-29.
//  Copyright (c) 2014年 aolaigo. All rights reserved.
//

#import "ALRemindViewController.h"

@interface ALRemindViewController ()

@end

@implementation ALRemindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self add0Section];
}

-(void)add0Section
{
    ALSettingSwitchItem *receive = [ALSettingSwitchItem itemWithTitle:@"接收消息通知"];
    
    ALSettingSwitchItem *music = [ALSettingSwitchItem itemWithTitle:@"铃声提醒"];
    
    ALSettingSwitchItem *shake = [ALSettingSwitchItem itemWithTitle:@"震动提醒"];
    
    ALSettingGroup *group = [[ALSettingGroup alloc] init];
    group.items = @[receive,music,shake];
    
    [_allGroups addObject:group];
    
}
@end
