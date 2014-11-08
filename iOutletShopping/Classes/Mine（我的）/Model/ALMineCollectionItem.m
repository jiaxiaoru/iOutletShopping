//
//  ALMineCollectionItem.m
//  iOutletShopping
//
//  Created by Huashen on 14/10/28.
//  Copyright (c) 2014年 aolaigo. All rights reserved.
//

#import "ALMineCollectionItem.h"

@implementation ALMineCollectionItem

+(instancetype)mineCollectionItemWithDic:(NSDictionary *)dic
{
    ALMineCollectionItem *item = [[self alloc] init];
    if (item) {
        item.imageName = dic[@"imageName"];
        item.title = dic[@"title"];
        item.number = dic[@"number"];
        item.className = dic[@"className"];
    }
    return item;
}
@end
