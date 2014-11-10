//
//  ALCommitOrderTableViewController.m
//  iOutletShopping
//
//  Created by Huashen on 14/11/10.
//  Copyright (c) 2014年 aolaigo. All rights reserved.
//

#import "ALCommitOrderTableViewController.h"


@interface ALCommitOrderTableViewController ()
{
    NSArray *_titleArr;
}
@end

@implementation ALCommitOrderTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpData];
}

-(void)setUpData
{
    _titleArr = @[@"收货信息",@"支付方式",@"商品清单",@"发票信息"];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return _titleArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}
//-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 5,kScreenWidth, 30)];
    label.text = _titleArr[section];
    return label;
}

@end
