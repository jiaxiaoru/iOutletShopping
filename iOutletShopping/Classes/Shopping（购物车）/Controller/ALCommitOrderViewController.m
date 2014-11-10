//
//  ALCommitOrderViewController.m
//  iOutletShopping
//
//  Created by Huashen on 14/11/10.
//  Copyright (c) 2014年 aolaigo. All rights reserved.
//

#import "ALCommitOrderViewController.h"
#import "ALGoPayViewController.h"
#import "ALCommitOrderTableViewController.h"

@interface ALCommitOrderViewController ()
{
    ALGoPayViewController *_commitActionCtl;
    ALCommitOrderTableViewController *_tableViewCtl;
}
@end

@implementation ALCommitOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"提交订单";
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //1. 添加tableview
    [self addTableView];
    
    //2. 添加提交订单view
    [self addCommitActionView];
}
#pragma mark - 添加提交订单view
-(void)addCommitActionView
{
    _commitActionCtl = [[ALGoPayViewController alloc] init];
    _commitActionCtl.view.frame = CGRectMake(0, kScreenHeight-50, kScreenWidth, 50);
    _commitActionCtl.type = ALGoPayViewCommitType;
    [self.view addSubview:_commitActionCtl.view];
}

#pragma mark - 添加tableview
-(void)addTableView
{
    _tableViewCtl = [[ALCommitOrderTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    _tableViewCtl.view.frame = self.view.frame;
    [self addChildViewController:_tableViewCtl];
    [self.view addSubview:_tableViewCtl.view];
}

@end
