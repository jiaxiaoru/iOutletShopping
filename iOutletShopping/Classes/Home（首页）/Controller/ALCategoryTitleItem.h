//
//  ALCategoryTitleItem.h
//  SUNCommonComponent
//
//  Created by Huashen on 14-9-22.
//  Copyright (c) 2014年 中山市新联医疗科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ALCategoryTitleItem : NSObject

@property (nonatomic,copy) NSString *labelTitle;

@property (nonatomic,copy) NSString *leftView;

-(id)initWithDic:(NSDictionary *)dic;
+(id)categoryTitleItemWithDic:(NSDictionary *)dic;

@end
