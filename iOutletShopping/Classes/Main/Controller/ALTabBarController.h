//
//  ALTabBarController.h
//  ItcastLottery
//
//  Created by Huashen on 14-9-17.
//  Copyright (c) 2014年 aolaigo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALTabBarButton.h"
@interface ALTabBarController : UITabBarController

//把tabbar的五个按钮对象放入这个数组，方便后面从自控制器直接跳到首页控制器
@property (nonatomic,strong) NSMutableArray *btnArray;
+ (id) sharedInstance;
-(void)clicked:(ALTabBarButton *)button;
-(void) rewriteTitle;
@end
