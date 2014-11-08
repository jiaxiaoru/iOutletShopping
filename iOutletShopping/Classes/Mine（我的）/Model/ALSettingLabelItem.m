//
//  ALSettingLabelItem.m
//  iOutletShopping
//
//  Created by Huashen on 14-9-27.
//  Copyright (c) 2014年 aolaigo. All rights reserved.
//

#import "ALSettingLabelItem.h"

@implementation ALSettingLabelItem
- (void)setText:(NSString *)text
{
    _text = text;
    
    // 归档
    [ALSettingTool setObject:text forKey:self.key];
}

- (void)setKey:(NSString *)key
{
    [super setKey:key];
    
    _text = [ALSettingTool objectForKey:key];
}
@end
