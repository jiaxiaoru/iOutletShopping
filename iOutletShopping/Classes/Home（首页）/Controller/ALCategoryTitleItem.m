//
//  ALCategoryTitleItem.m
//  SUNCommonComponent
//
//  Created by Huashen on 14-9-22.
//  Copyright (c) 2014年 中山市新联医疗科技有限公司. All rights reserved.
//

#import "ALCategoryTitleItem.h"

@implementation ALCategoryTitleItem
-(id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.labelTitle = dic[@"title"];
        self.leftView = dic[@"imageName"];
    }
    return self;
}
+(id)categoryTitleItemWithDic:(NSDictionary *)dic
{
    ALCategoryTitleItem *item = [[self alloc] initWithDic:dic];
    return item;
}

@end
