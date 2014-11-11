//
//  ALCommitOrderItem.m
//  iOutletShopping
//
//  Created by Huashen on 14/11/11.
//  Copyright (c) 2014年 aolaigo. All rights reserved.
//

#import "ALCommitOrderItem.h"

@implementation ALCommitOrderItem
+(instancetype)commitOrderItemWithDic:(NSDictionary *)dic
{
    ALCommitOrderItem *item = [[self alloc] init];
    
    item.imageName = dic[@"imageName"];
    item.title = dic[@"title"];
    item.unitPrice = dic[@"unitPrice"];
    item.preUnitPrice = dic[@"preUnitPrice"];
    item.stype = dic[@"stype"];
    item.smallTotally = dic[@"smallTotally"];
    item.discountInfo = dic[@"discountInfo"];
    item.pointsInfo = dic[@"pointsInfo"];
    item.goodsCount = dic[@"goodsCount"];
    item.presentCount = dic[@"presentCount"];
    item.totally = dic[@"totally"];
    item.freight = dic[@"freight"];
    item.discountPrice = dic[@"discountPrice"];
    
    return item;
}
@end
