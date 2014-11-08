//
//  AppDelegate.m
//  iOutletShopping
//
//  Created by Huashen on 14-9-19.
//  Copyright (c) 2014年 aolaigo. All rights reserved.
//

#import "AppDelegate.h"
#import "ALNavigationController.h"
#import "ALTabBarController.h"
#import "PPRevealSideViewController.h"

@interface AppDelegate ()<PPRevealSideViewControllerDelegate>
{
    PPRevealSideViewController *_revealSideViewController;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //0. 改掉info文件里的属性值为No后，设置电池栏的颜色
    application.statusBarStyle = UIStatusBarStyleLightContent;
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    //1. 取出storyboard对象
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    //2. 取出storyboard根视图
    ALNavigationController *nav =(ALNavigationController *)[storyBoard instantiateInitialViewController];
    //3. 取出ALNavigation的root View
    ALTabBarController *tabBar = [storyBoard instantiateViewControllerWithIdentifier:@"Tab"];
    _revealSideViewController = [[PPRevealSideViewController alloc] initWithRootViewController:nav];
//    _revealSideViewController.bouncingOffset = -1;
    _revealSideViewController.delegate = self;
    self.window.rootViewController = _revealSideViewController;
    
    PP_RELEASE(tabBar);
    PP_RELEASE(nav);
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
@end
