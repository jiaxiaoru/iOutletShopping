//
//  ALSettingTool.h
//  iOutletShopping
//
//  Created by Huashen on 14-9-27.
//  Copyright (c) 2014年 aolaigo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ALSettingTool : NSObject
+ (id)objectForKey:(NSString *)defaultName;
+ (void)setObject:(id)value forKey:(NSString *)defaultName;

+ (BOOL)boolForKey:(NSString *)defaultName;
+ (void)setBool:(BOOL)value forKey:(NSString *)defaultName;

+ (NSArray *)ArrayForKey:(NSString *)defaultName;
+ (void)setArray:(NSArray *)array forKey:(NSString *)defaultName;

+(void)removerObjectForKey:(NSString *)key;
@end
