//
//  ALJumpToAnotherUI.m
//  iOutletShopping
//
//  Created by Huashen on 14/10/31.
//  Copyright (c) 2014年 aolaigo. All rights reserved.
//

#import "ALJumpToAnotherUI.h"

@implementation ALJumpToAnotherUI

+(void)jumpToAnotherUI:(NSString *)className withNavCtrl:(UINavigationController *)nav
{
    Class controller = NSClassFromString(className);
    UIViewController *viewController = [[controller alloc] init];
    [nav pushViewController:viewController animated:YES];
}
@end
