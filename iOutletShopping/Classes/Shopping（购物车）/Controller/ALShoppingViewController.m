//
//  ALShoppingViewController.m
//  iOutletShopping
//
//  Created by Huashen on 14-9-30.
//  Copyright (c) 2014年 aolaigo. All rights reserved.
//

#import "ALShoppingViewController.h"
@interface ALShoppingViewController ()

@end

@implementation ALShoppingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    [ALJumpToAnotherUI jumpToAnotherUI:@"ALShoppingCarViewController" withNavCtrl:self.navigationController];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
