//
//  ALNavigationController.m
//  ItcastLottery
//
//  Created by Huashen on 14-9-17.
//  Copyright (c) 2014年 aolaigo. All rights reserved.
//

#import "ALNavigationController.h"

@interface ALNavigationController ()

@end

@implementation ALNavigationController

+(void)initialize
{
    UINavigationBar *bar = [UINavigationBar appearance];
//    UIBarButtonItem *barItem = [UIBarButtonItem appearance];
    bar.backgroundColor = [UIColor blackColor];
    [bar setBackgroundImage:[UIImage imageNamed:@"NavBar64"]forBarMetrics:UIBarMetricsDefault];
    [bar setTitleTextAttributes:@{
            NSForegroundColorAttributeName:[UIColor whiteColor]
                                  }];
//    bar.tintColor = [UIColor whiteColor];
//    
//    [barItem setTitleTextAttributes:@{
//            NSForegroundColorAttributeName:[UIColor whiteColor],
//            NSFontAttributeName:[UIFont systemFontOfSize:14]
//                                      } forState:UIControlStateNormal];
}
//-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
//{
//    
//}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
