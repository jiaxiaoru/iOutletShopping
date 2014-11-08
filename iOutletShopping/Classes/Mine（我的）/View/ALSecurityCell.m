//
//  ALSecurityCell.m
//  iOutletShopping
//
//  Created by Huashen on 14-9-29.
//  Copyright (c) 2014年 aolaigo. All rights reserved.
//

#import "ALSecurityCell.h"

@implementation ALSecurityCell

+ (instancetype)settingCellWithTableView:(UITableView *)tableView view:(UIView *)view
{
    // 0.用static修饰的局部变量，只会初始化一次
    static NSString *ID = @"Cell";
    
    // 1.拿到一个标识先去缓存池中查找对应的Cell
    ALSecurityCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    // 2.如果缓存池中没有，才需要传入一个标识创建新的Cell
    if (cell == nil) {
        cell = [[ALSecurityCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID withView:view];
    }
    
    return cell;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withView:(UIView *)view
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 1.中间添加一个UIView
        [self addViewInCell:view];
    }
    return self;
}

-(void)addViewInCell:(UIView *)view
{
    view.center = self.center;
    [self.contentView addSubview:view];
}
@end
