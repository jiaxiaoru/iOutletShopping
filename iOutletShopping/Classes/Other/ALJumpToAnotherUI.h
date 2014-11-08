//
//  ALJumpToAnotherUI.h
//  iOutletShopping
//
//  Created by Huashen on 14/10/31.
//  Copyright (c) 2014年 aolaigo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ALJumpToAnotherUI : NSObject
//获得当前控制器，跳转到search界面
@property (nonatomic,strong) UINavigationController *currentCtr;

+(void)jumpToAnotherUI:(NSString *)className withNavCtrl:(UINavigationController *)nav;
@end
