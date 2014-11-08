//
//  UINavigationItem+AL.m
//  ItcastLottery
//
//  Created by Huashen on 14-9-17.
//  Copyright (c) 2014年 aolaigo. All rights reserved.
//

#import "UINavigationItem+AL.h"

@implementation UINavigationItem (AL)
-(void)copyFromItem:(UINavigationItem *)other
{
    self.title = other.title;
    self.leftBarButtonItem = other.leftBarButtonItem;
    self.rightBarButtonItem = other.rightBarButtonItem;
    self.leftBarButtonItems = other.leftBarButtonItems;
    self.rightBarButtonItems = other.rightBarButtonItems;
    self.titleView = other.titleView;
}
@end
