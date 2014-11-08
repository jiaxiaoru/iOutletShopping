//
//  ALShoppingCarCell.h
//  iOutletShopping
//
//  Created by Huashen on 14/10/23.
//  Copyright (c) 2014年 aolaigo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALShoppingCarItem.h"
typedef void(^ALCountAndPrice)(NSString *smallTotally);

@class ALShoppingCarCell;
@protocol ALShoppingCarCellDelegate <NSObject>

@optional
-(void)shoppingCarCell:(ALShoppingCarCell *)cell tag:(NSInteger)tag supTag:(NSInteger)supTag number:(NSString *)number countAndPrice:(ALCountAndPrice)countAndPrice;

@end
@interface ALShoppingCarCell : UITableViewCell
@property (nonatomic,strong) ALShoppingCarItem *shoppingCarItem;
@property (nonatomic,weak) id <ALShoppingCarCellDelegate> delegate;

-(void)changeUIToEdit:(BOOL)edit;
+(instancetype)shoppingCarCell;
+(NSString *)ID;
+(CGFloat) heightNormal;
+(CGFloat) heightWithPrivilege;
+(CGFloat) heightWithAll;

@end
