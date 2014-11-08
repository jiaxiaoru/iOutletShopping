//
//  ALSaveArrayData.m
//  iOutletShopping
//
//  Created by Huashen on 14-10-15.
//  Copyright (c) 2014年 aolaigo. All rights reserved.
//

#import "ALSaveArrayData.h"
#import "ALSettingTool.h"
@implementation ALSaveArrayData

-(void)setDataSaved:(NSArray *)dataSaved
{
    _dataSaved = dataSaved;
    //key值为keyi
    [ALSettingTool setArray:dataSaved forKey:_key];
}

-(NSArray *)dataSaved
{
    return [ALSettingTool ArrayForKey:_key];
}

-(void)clearAllData
{
    [ALSettingTool removerObjectForKey:_key];
}
@end
