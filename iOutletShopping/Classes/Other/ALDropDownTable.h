//
//  ALDropDownTable.h
//  iOutletShopping
//
//  Created by Huashen on 14-9-27.
//  Copyright (c) 2014年 aolaigo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ALDropDownTable;

@protocol ALDropDownTableDelegate <NSObject>

@optional
- (void) dropDownDelegate:(ALDropDownTable *) object selected:(NSInteger)index;

@end

@interface ALDropDownTable : UITableView <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) id <ALDropDownTableDelegate> selectedDelegate;
@property (nonatomic,assign) BOOL hiden;

-(void)showTable;
-(void)hideTable;
-(id)initWithDropDown:(UIButton *)b width:(CGFloat)width arr:(NSArray *)arr;

@end
