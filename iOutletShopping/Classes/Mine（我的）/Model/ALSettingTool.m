//
//  ALSettingTool.m
//  iOutletShopping
//
//  Created by Huashen on 14-9-27.
//  Copyright (c) 2014年 aolaigo. All rights reserved.
//
#define ALUserDefaults [NSUserDefaults standardUserDefaults]
#import "ALSettingTool.h"

@implementation ALSettingTool
+ (id)objectForKey:(NSString *)defaultName
{
    return [ALUserDefaults objectForKey:defaultName];
}

+ (void)setObject:(id)value forKey:(NSString *)defaultName
{
    [ALUserDefaults setObject:value forKey:defaultName];
    [ALUserDefaults synchronize];
}

+ (BOOL)boolForKey:(NSString *)defaultName
{
    return [ALUserDefaults boolForKey:defaultName];
}

+ (void)setBool:(BOOL)value forKey:(NSString *)defaultName
{
    [ALUserDefaults setBool:value forKey:defaultName];
    [ALUserDefaults synchronize];
}

+ (NSArray *)ArrayForKey:(NSString *)defaultName
{
    return [ALUserDefaults arrayForKey:defaultName];
}

+ (void)setArray:(NSArray *)array forKey:(NSString *)defaultName
{
    [ALUserDefaults setObject:array forKey:defaultName];
    [ALUserDefaults synchronize];
}

+(void)removerObjectForKey:(NSString *)key
{
    [ALUserDefaults removeObjectForKey:key];
}
@end
