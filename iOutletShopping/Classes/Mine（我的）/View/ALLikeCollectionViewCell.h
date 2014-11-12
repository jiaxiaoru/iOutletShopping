//
//  ALLikeCollectionViewCell.h
//  iOutletShopping
//
//  Created by Chris on 14/11/8.
//  Copyright (c) 2014年 aolaigo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ALLikeCollectionViewCell : UICollectionViewCell{
    
    __weak IBOutlet UIImageView *_goodsImageView;
    __weak IBOutlet UILabel *_priceLabel;
    
    __weak IBOutlet UILabel *_goodsDetailLabel;
    
    
    __weak IBOutlet UILabel *_orignalPriceLabel;
    
}
+(NSString *)ID;
- (IBAction)_selectedAction:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *_selectedButton;


@end
