//
//  ALMineCollectionViewCell.m
//  iOutletShopping
//
//  Created by Huashen on 14/10/28.
//  Copyright (c) 2014年 aolaigo. All rights reserved.
//

#import "ALMineCollectionViewCell.h"
#import "ALMineCollectionItem.h"

@interface ALMineCollectionViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIButton *numberTip;


@end
@implementation ALMineCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // 初始化时加载collectionCell.xib文件
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"ALMineCollectionViewCell" owner:self options:nil];
        
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
-(void)setMineCollectionItem:(ALMineCollectionItem *)mineCollectionItem
{
    _mineCollectionItem = mineCollectionItem;
    self.imageView.image = [UIImage imageNamed:mineCollectionItem.imageName];
    self.title.text = mineCollectionItem.title;
    if (mineCollectionItem.number) {
        [self.numberTip setTitle:mineCollectionItem.number forState:UIControlStateNormal];
    }
    self.className = mineCollectionItem.className;
}

+(NSString *)ID
{
    return @"mineCollectionCell";
}

+(CGSize)cellSize
{
    return CGSizeMake(95, 100);
}
@end
