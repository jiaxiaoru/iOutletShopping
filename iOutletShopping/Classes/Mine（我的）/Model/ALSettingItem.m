//
//  ALSettingItem.m
//  iOutletShopping
//
//  Created by Huashen on 14-9-27.
//  Copyright (c) 2014年 aolaigo. All rights reserved.
//

#import "ALSettingItem.h"

@implementation ALSettingItem
+ (id)itemWithIcon:(NSString *)icon title:(NSString *)title
{
    ALSettingItem *item = [[self alloc] init];
    item.icon = icon;
    item.title = title;
    return item;
}

+ (id)itemWithTitle:(NSString *)title
{
    return [self itemWithIcon:nil title:title];
}
@end
