//
//  ALDropDownTable.m
//  iOutletShopping
//
//  Created by Huashen on 14-9-27.
//  Copyright (c) 2014年 aolaigo. All rights reserved.
//

#import "ALDropDownTable.h"
#import "QuartzCore/QuartzCore.h"
#define kCellH 40
@interface ALDropDownTable()
{
    CGFloat _x;
    CGFloat _width;
}
@property(nonatomic, strong) UIButton *btnSender;
@property(nonatomic, retain) NSArray *list;
@end

@implementation ALDropDownTable

@synthesize btnSender;
@synthesize list;
@synthesize delegate;
-(id)initWithDropDown:(UIButton *)b width:(CGFloat)width arr:(NSArray *)arr
{
    btnSender = b;
    self = [super init];
    if (self) {
        _hiden = YES;
        // Initialization code
        CGRect btn = btnSender.frame;
        _width = width;
        _x = btn.origin.x+btn.size.width-width;
        
        self.list = [NSArray arrayWithArray:arr];

        
        self.frame = CGRectMake(_x, btn.origin.y+btn.size.height, _width, 0);
        self.layer.cornerRadius = 5;
//        self.backgroundColor = [UIColor colorWithRed:0.239 green:0.239 blue:0.239 alpha:1];
        self.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        self.separatorColor = [UIColor grayColor];
        self.delegate = self;
        self.dataSource = self;
    }
    
    return self;
}
-(void)showTable
{
    _hiden = NO;
    CGFloat height = self.list.count * kCellH;
    CGRect btn = btnSender.frame;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    self.frame = CGRectMake(_x, btn.origin.y+btn.size.height+20, _width, height+10);
    [UIView commitAnimations];
    NSLog(@"%@",btnSender.superview.superview.superview);
    [btnSender.superview.superview addSubview:self];
    
}
-(void)hideTable {
    _hiden = YES;
    CGRect btn = btnSender.frame;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    self.frame = CGRectMake(_x, btn.origin.y+btn.size.height, _width, 0);
    [UIView commitAnimations];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kCellH;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.list count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    cell.textLabel.text =[list objectAtIndex:indexPath.row];
    cell.backgroundColor = [UIColor blackColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    UIView * v = [[UIView alloc] init];
    v.backgroundColor = [UIColor whiteColor];
    cell.selectedBackgroundView = v;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self hideTable];
    UITableViewCell *c = [tableView cellForRowAtIndexPath:indexPath];
    [btnSender setTitle:c.textLabel.text forState:UIControlStateNormal];
    if ([_selectedDelegate respondsToSelector:@selector(dropDownDelegate:selected:)]) {
        [_selectedDelegate dropDownDelegate:self selected:indexPath.row];
    }
}

@end
