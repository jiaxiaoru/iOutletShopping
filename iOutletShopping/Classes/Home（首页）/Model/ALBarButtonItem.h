//
//  ALSearchBarButtonItem.h
//  iOutletShopping
//
//  Created by Huashen on 14-10-16.
//  Copyright (c) 2014年 aolaigo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    barButtonItemTypeSearch, //增加搜索按钮，跳转到搜索界面
    barButtonItemTypeHome  //增加跳到Home界面的按钮
}barButtonItemType;

@interface ALBarButtonItem : UIBarButtonItem
//获得当前控制器，跳转到search界面
@property (nonatomic,strong) UINavigationController *currentCtr;

/*
 frame:调整要增加的button在navigationbar的位置
 type:增加的button功能
 controller：获取当前控制器进行跳转
 **/
+(instancetype)BarButtonItemWithPosition:(CGRect)frame type:(barButtonItemType)type controller:(UINavigationController *)controller;

@end
