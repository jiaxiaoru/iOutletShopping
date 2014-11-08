//
//  ALMineCollectionItem.h
//  iOutletShopping
//
//  Created by Huashen on 14/10/28.
//  Copyright (c) 2014年 aolaigo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ALMineCollectionItem : NSObject

@property (nonatomic,copy) NSString *imageName;

@property (nonatomic,copy) NSString *title;

@property (nonatomic,copy) NSString *number;
//点击跳转的UI类名
@property (nonatomic,copy) NSString *className;

+(instancetype)mineCollectionItemWithDic:(NSDictionary *)dic;
@end
