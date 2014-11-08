//
//  ALMineCollectionViewCell.h
//  iOutletShopping
//
//  Created by Huashen on 14/10/28.
//  Copyright (c) 2014年 aolaigo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ALMineCollectionItem;

@interface ALMineCollectionViewCell : UICollectionViewCell

@property (nonatomic,copy) ALMineCollectionItem *mineCollectionItem;
@property (copy,nonatomic) NSString *className;

+(NSString *)ID;
+(CGSize)cellSize;
@end
