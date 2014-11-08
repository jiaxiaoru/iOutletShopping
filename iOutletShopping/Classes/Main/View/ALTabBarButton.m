//
//  ALTabBarButton.m
//  ItcastLottery
//
//  Created by Huashen on 14-9-17.
//  Copyright (c) 2014年 aolaigo. All rights reserved.
//

#import "ALTabBarButton.h"
@interface ALTabBarButton ()
{
    
}
@end

@implementation ALTabBarButton

-(id)initTabBarButtonWithImage:(NSString *)imgName SelectImage:(NSString *)selectImage index:(NSInteger)index totalNumber:(NSInteger)number
{
    self = [self init];
    if (self) {
        self.frame = [self adjustPositionWithIndex:index totalNumber:number];
        [self setBackgroundImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:selectImage] forState:UIControlStateSelected];
        self.tag = index;
    }
    return self;
}
/*
 调整button的位置
 */
-(CGRect)adjustPositionWithIndex:(NSInteger)index  totalNumber:(NSInteger)number
{
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat width = screenWidth/number;
    CGFloat x = index * width;
    CGFloat y = 0;
    CGFloat height = 49;
    
    CGRect rect = CGRectMake(x, y, width, height);
    return rect;
}


/*
 去除按钮点击时的灰暗效果
 */
-(void)setHighlighted:(BOOL)highlighted
{
    highlighted = NO;
}

@end

