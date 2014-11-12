//
//  ALLikeViewController.h
//  iOutletShopping
//
//  Created by Chris on 14/11/8.
//  Copyright (c) 2014年 aolaigo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ALLikeViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,strong)NSArray *dataList;
@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,assign)BOOL isAllDelete;

@end
