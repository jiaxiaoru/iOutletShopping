//
//  ALShoppingCarTableViewController.h
//  iOutletShopping
//
//  Created by Huashen on 14/11/4.
//  Copyright (c) 2014年 aolaigo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ALShoppingCarTableViewController;

@protocol ALShoppingCarTableViewControllerDelegate <NSObject>

@optional
-(void)shoppingCarTable:(ALShoppingCarTableViewController *)controller totally:(NSString *)totally;
@end

@interface ALShoppingCarTableViewController : UITableViewController

@property (nonatomic,assign) BOOL selectedAllGoods;
@property (nonatomic,copy) NSString *totallyStr;
@property (nonatomic,assign) BOOL edit;
@property (nonatomic,assign) BOOL hasData;

@property (nonatomic,weak) id <ALShoppingCarTableViewControllerDelegate> delegate;
-(void)removeGoods;
@end
