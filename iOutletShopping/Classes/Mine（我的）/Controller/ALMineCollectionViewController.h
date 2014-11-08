//
//  ALMineCollectionViewController.h
//  iOutletShopping
//
//  Created by Huashen on 14/10/28.
//  Copyright (c) 2014年 aolaigo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ALMineCollectionViewController;
@protocol ALMineCollectionViewControllerDelegate <NSObject>

@required
-(void)mineCollectionViewController:(ALMineCollectionViewController *)controller jumpTo:(NSString *)className;
@end

@interface ALMineCollectionViewController : UICollectionViewController
@property (nonatomic,weak) id <ALMineCollectionViewControllerDelegate> delegate;

-(void)changeTabClicked;
@end
