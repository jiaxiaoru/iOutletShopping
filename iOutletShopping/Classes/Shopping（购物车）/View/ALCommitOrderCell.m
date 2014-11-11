//
//  ALCommitOrderCell.m
//  iOutletShopping
//
//  Created by Huashen on 14/11/11.
//  Copyright (c) 2014年 aolaigo. All rights reserved.
//

#import "ALCommitOrderCell.h"
#import "ALCommitOrderItem.h"

@interface ALCommitOrderCell()
@property (weak, nonatomic) IBOutlet UIImageView *goodImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *unitPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *preUnitPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *styleLabel;
@property (weak, nonatomic) IBOutlet UILabel *smallTotallyLabel;
@property (weak, nonatomic) IBOutlet UILabel *couponLabel;
@property (weak, nonatomic) IBOutlet UILabel *pointsLabel;
@property (weak, nonatomic) IBOutlet UILabel *pointRedLabel;
@property (weak, nonatomic) IBOutlet UITextField *messageText;
@property (weak, nonatomic) IBOutlet UILabel *goodCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *presentCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *totallyLabel;
@property (weak, nonatomic) IBOutlet UILabel *freightLabel;
@property (weak, nonatomic) IBOutlet UILabel *discountPriceLabel;


@end
@implementation ALCommitOrderCell
+(instancetype)commitOrderCell
{
    return [[NSBundle mainBundle] loadNibNamed:@"ALCommitOrderCell" owner:self options:nil][0];
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setItem:(ALCommitOrderItem*)item
{
    _item = item;
    _goodImageView.image = [UIImage imageNamed:item.imageName];
    _titleLabel.text = item.title;
    _unitPriceLabel.text = item.unitPrice;
    _preUnitPriceLabel.text = item.preUnitPrice;
    _styleLabel.text = item.stype;
    _smallTotallyLabel.text = item.smallTotally;
    _couponLabel.text = item.discountInfo;
    _pointsLabel.text = item.pointsInfo;
    _goodCountLabel.text = item.goodsCount;
    _presentCountLabel.text = item.presentCount;
    _totallyLabel.text = item.totally;
    _freightLabel.text = item.freight;
    _discountPriceLabel.text = item.discountPrice;
}

+(CGFloat)height
{
    return 267;
}
@end
