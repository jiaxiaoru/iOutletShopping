//
//  ALLikeCollectionViewCell.m
//  iOutletShopping
//
//  Created by Chris on 14/11/8.
//  Copyright (c) 2014年 aolaigo. All rights reserved.
//

#import "ALLikeCollectionViewCell.h"
#import "UIView+ViewController.h"
@implementation ALLikeCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    //设置边框颜色
    self.layer.borderColor = [UIColor grayColor].CGColor;
    self.layer.borderWidth = 1;
    self.alpha = .5;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // 初始化时加载collectionCell.xib文件
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"ALLikeCollectionViewCell" owner:self options:nil];
        
        // 如果路径不存在，return nil
        if (arrayOfViews.count < 1)
        {
            return nil;
        }
        // 如果xib中view不属于UICollectionViewCell类，return nil
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[UICollectionViewCell class]])
        {
            return nil;
        }
        // 加载nib
        self = [arrayOfViews objectAtIndex:0];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    //重新设置原来价格的坐标
    _orignalPriceLabel.frame = CGRectMake(self.width/2 - 20, _priceLabel.top-2, 70, 21);
    
}

+(NSString *)ID
{
    return @"ALLikeCellId";
}

- (IBAction)_selectedAction:(UIButton *)sender {
    UIViewController *VC = [[UIViewController alloc]init];
    [self.ViewController.navigationController pushViewController:VC animated:YES];
    
}
@end
