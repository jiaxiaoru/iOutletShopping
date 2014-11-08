//
//  ALDropDown.h
//  iOutletShopping
//
//  Created by Huashen on 14-9-26.
//  Copyright (c) 2014年 aolaigo. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum
{
    ALDropDownPositionDefault, //向按钮中心对齐
    ALDropDownPositionRight,  //向按钮右边对齐
    ALDropDownPositionLeft,    //向按钮左边对齐
} ALDropDownPosition;

@class ALDropDown;
@protocol ALDropDownDelegate <NSObject>

@optional
- (void) dropDownDelegate:(ALDropDown *)object selected:(NSInteger)index;

@end

@interface ALDropDown : UIView <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) id <ALDropDownDelegate> delegate;
@property (nonatomic,assign) BOOL hiden;

@property (nonatomic,assign) float alphaValue;

-(void)showTable;
-(void)hideTable;

-(id)initWithPosition:(ALDropDownPosition)position withBtn:(UIButton *)clickedBtn width:(CGFloat)width data:(NSArray *)data onNavigationBar:(BOOL)onNavigationBar;
@end
