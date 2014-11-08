//
//  ALRushedCatchViewController.m
//  iOutletShopping
//
//  Created by Huashen on 14-9-30.
//  Copyright (c) 2014年 aolaigo. All rights reserved.
//

#import "ALRushedCatchViewController.h"
@interface ALRushedCatchViewController ()

@end

@implementation ALRushedCatchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ALBarButtonItem *searchButtonItem = [ALBarButtonItem BarButtonItemWithPosition:kRightFirstBtnFrame type:barButtonItemTypeSearch controller:self.navigationController];
    self.navigationItem.rightBarButtonItem = searchButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
