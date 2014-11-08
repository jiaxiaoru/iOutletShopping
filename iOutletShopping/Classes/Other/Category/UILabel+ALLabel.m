//
//  UILabel+ALLabel.m
//  iOutletShopping
//
//  Created by Huashen on 14-9-28.
//  Copyright (c) 2014年 aolaigo. All rights reserved.
//

#import "UILabel+ALLabel.h"

@implementation UILabel (ALLabel)
+ (UILabel *)labelWithTextColor:(UIColor *)color titleText:(NSString *)titleText titleFont:(NSString *)font width:(CGFloat)width height:(CGFloat)height{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    [titleLabel setTextColor:color];
    [titleLabel setText:titleText];
    titleLabel.font = [UIFont boldSystemFontOfSize:[font floatValue]];
    return titleLabel;
}

@end
