//
//  ALShoppingCarItem.m
//  iOutletShopping
//
//  Created by Huashen on 14/10/31.
//  Copyright (c) 2014年 aolaigo. All rights reserved.
//

#import "ALShoppingCarItem.h"

@implementation ALShoppingCarItem
+(instancetype)shoppingCarItemWithDic:(NSDictionary *)dic
{
    ALShoppingCarItem *item = [[self alloc] init];
    if (item) {
        item.imageUrlStr = dic[@"imageUrlStr"];
        item.title = dic[@"title"];
        item.unitPrice = dic[@"unitPrice"];
        item.preUnitPrice = dic[@"preUnitPrice"];
        item.favourite = (BOOL)dic[@"favourite"];
        item.number = dic[@"number"];
        item.describe = dic[@"describe"];
        item.totally = dic[@"totally"];
        item.selected = (BOOL)dic[@"selected"];
        item.privilege = dic[@"privilege"];
        item.present = dic[@"present"];
    }
    return item;
}
@end
