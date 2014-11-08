//
//  ALMyOrderTableViewController.m
//  iOutletShopping
//
//  Created by Huashen on 14/10/31.
//  Copyright (c) 2014年 aolaigo. All rights reserved.
//

#import "ALMyOrderTableViewController.h"

@interface ALMyOrderTableViewController ()

@end

@implementation ALMyOrderTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"ID"];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ID" forIndexPath:indexPath];
    cell.textLabel.textColor = [UIColor redColor];
    cell.textLabel.text = @"123";
    
    return cell;
}

@end
