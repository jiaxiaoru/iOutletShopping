//
//  ALSettingSwitchItem.m
//  iOutletShopping
//
//  Created by Huashen on 14-9-27.
//  Copyright (c) 2014年 aolaigo. All rights reserved.
//

#import "ALSettingSwitchItem.h"

@implementation ALSettingSwitchItem
- (void)setOff:(BOOL)off
{
    _off = off;
    
    [ALSettingTool setBool:off forKey:self.key];
}

- (void)setKey:(NSString *)key
{
    [super setKey:key];
    
    _off = [ALSettingTool boolForKey:key];
}

@end
