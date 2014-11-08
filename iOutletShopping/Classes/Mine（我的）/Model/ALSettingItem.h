//
//  ALSettingItem.h
//  iOutletShopping
//
//  Created by Huashen on 14-9-27.
//  Copyright (c) 2014年 aolaigo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ALSettingItem : NSObject
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, copy) void (^operation)() ; // 点击cell后要执行的操作

+ (id)itemWithIcon:(NSString *)icon title:(NSString *)title;
+ (id)itemWithTitle:(NSString *)title;

@end
