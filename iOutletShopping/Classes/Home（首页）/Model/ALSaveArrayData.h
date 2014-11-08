//
//  ALSaveArrayData.h
//  iOutletShopping
//
//  Created by Huashen on 14-10-15.
//  Copyright (c) 2014年 aolaigo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ALSaveArrayData : NSObject
{
    NSArray *_dataSaved;
}
@property (nonatomic,copy) NSString *key;

// 如果用property，不好重写get方法
-(void)setDataSaved:(NSArray *)dataSaved;
-(NSArray *)dataSaved;

-(void)clearAllData;
@end
