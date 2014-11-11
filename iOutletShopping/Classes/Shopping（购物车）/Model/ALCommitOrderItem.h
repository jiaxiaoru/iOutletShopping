//
//  ALCommitOrderItem.h
//  iOutletShopping
//
//  Created by Huashen on 14/11/11.
//  Copyright (c) 2014年 aolaigo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ALCommitOrderItem : NSObject
@property (nonatomic,copy) NSString *imageName;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *unitPrice;
@property (nonatomic,copy) NSString *preUnitPrice;
@property (nonatomic,copy) NSString *stype;
@property (nonatomic,copy) NSString *smallTotally;
@property (nonatomic,copy) NSString *discountInfo;
@property (nonatomic,copy) NSString *pointsInfo;
@property (nonatomic,copy) NSString *goodsCount;
@property (nonatomic,copy) NSString *presentCount;
@property (nonatomic,copy) NSString *totally;
@property (nonatomic,copy) NSString *freight;
@property (nonatomic,copy) NSString *discountPrice;

+(instancetype)commitOrderItemWithDic:(NSDictionary *)dic;
@end
