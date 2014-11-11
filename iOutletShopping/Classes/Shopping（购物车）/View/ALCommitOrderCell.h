//
//  ALCommitOrderCell.h
//  iOutletShopping
//
//  Created by Huashen on 14/11/11.
//  Copyright (c) 2014年 aolaigo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ALCommitOrderItem;
@interface ALCommitOrderCell : UITableViewCell


@property (nonatomic,strong) ALCommitOrderItem *item;

+(instancetype)commitOrderCell;
+(CGFloat)height;
@end
