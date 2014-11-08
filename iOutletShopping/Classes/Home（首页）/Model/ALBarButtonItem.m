//
//  ALSearchBarButtonItem.m
//  iOutletShopping
//
//  Created by Huashen on 14-10-16.
//  Copyright (c) 2014年 aolaigo. All rights reserved.
//

#import "ALBarButtonItem.h"
#import "ALSearchViewController.h"
#import "ALTabBarController.h"

@implementation ALBarButtonItem

+(instancetype)BarButtonItemWithPosition:(CGRect)frame type:(barButtonItemType)type controller:(UINavigationController *)controller
{
    UIButton *barBtn = [[UIButton alloc] initWithFrame:frame];
   
    ALBarButtonItem *barBtnItem = [[self alloc] initWithCustomView:barBtn];
    NSString *imageName = @"";
    NSString *selectorName = @"";
    [barBtnItem getImageName:&imageName clickedEvent:&selectorName withType:type];
    [barBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [barBtn addTarget:barBtnItem action:NSSelectorFromString(selectorName) forControlEvents:UIControlEventTouchUpInside];
    barBtnItem.currentCtr = controller;
    return barBtnItem;
}

-(void)getImageName:(NSString **)imageName clickedEvent:(NSString **)selectorName withType:(barButtonItemType)type
{
    switch (type) {
        case barButtonItemTypeSearch:
        {
            *imageName = @"TabBar2";
            *selectorName = @"searchBtnClicked";
            break;
        }
        case barButtonItemTypeHome:
        {
            *imageName = @"TabBar2";
            *selectorName = @"homeBtnClicked";
            break;
        }
        default:
            break;
    }
}
-(void)searchBtnClicked
{
    
    ALSearchViewController *searchView = [[ALSearchViewController alloc] initWithStyle:UITableViewStyleGrouped];
    CATransition *animation = [CATransition animation];
    
    [animation setDuration:0.3];
    
    [animation setType: kCATransitionMoveIn];
    
    [animation setSubtype: kCATransitionFromRight];
    
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    
    [self.currentCtr pushViewController:searchView animated:NO];
        [self.currentCtr.view.layer addAnimation:animation forKey:nil];
}
-(void)homeBtnClicked
{
    [self.currentCtr popToRootViewControllerAnimated:YES];
    ALTabBarController *tabBar = [ALTabBarController sharedInstance];
    for(ALTabBarButton *button in tabBar.btnArray)
    {
        if (button.tag == 0) {
            [tabBar clicked:button];
        return;
        }
    }
    
}
@end
