//
//  ALShoppingCarItem.h
//  iOutletShopping
//
//  Created by Huashen on 14/10/31.
//  Copyright (c) 2014年 aolaigo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ALShoppingCarItem : NSObject

//图片地址
@property (nonatomic,copy) NSString *imageUrlStr;
//商品名字
@property (nonatomic,copy) NSString *title;
//现单价
@property (nonatomic,copy) NSString *unitPrice;
//原价
@property (nonatomic,copy) NSString *preUnitPrice;
//是否收藏
@property (nonatomic,assign) BOOL favourite;
//此商品数量
@property (nonatomic,copy) NSString *number;
//选择的商品款式
@property (nonatomic,copy) NSString *describe;
//小计
@property (nonatomic,copy) NSString *totally;
//是否选中
@property (nonatomic,assign) BOOL selected;

//优惠信息
@property (nonatomic,assign) NSString *privilege;

//赠送信息
@property (nonatomic,assign) NSString *present;

+(instancetype)shoppingCarItemWithDic:(NSDictionary *)dic;
@end
