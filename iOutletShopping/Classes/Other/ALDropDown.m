//
//  ALDropDown.m
//  iOutletShopping
//
//  Created by Huashen on 14-9-26.
//  Copyright (c) 2014年 aolaigo. All rights reserved.
//

#import "ALDropDown.h"
#import "QuartzCore/QuartzCore.h"
const NSUInteger kCellH = 30;
const NSUInteger kIndicatorH = 10;

@interface ALDropDown ()
{
    CGFloat _x;
    CGFloat _y;
    CGFloat _width;
    CGFloat _height;
}
@property(nonatomic, strong) UITableView *table;
@property(nonatomic, strong) UIButton *btnSender;
@property(nonatomic, retain) NSArray *list;
@property (nonatomic,assign) BOOL onNavigationBar;
@end

@implementation ALDropDown
//@synthesize table;
//@synthesize btnSender;
//@synthesize list;

#pragma mark - 初始化
-(id)initWithPosition:(ALDropDownPosition)position withBtn:(UIButton *)clickedBtn width:(CGFloat)width data:(NSArray *)data onNavigationBar:(BOOL)onNavigationBar
{
    self = [super init];
    if (self) {
        _alphaValue = 1;
        _hiden = YES;
        _btnSender = clickedBtn;
        CGRect btn = _btnSender.frame;
        _y = btn.origin.y+btn.size.height;
        (_onNavigationBar = onNavigationBar)? _y+=20:_y;
        _width = width;
        [self ajustPosition:position frame:btn];
        [self setUpWithData:data];
    }
    return self;
}
-(void)ajustPosition:(ALDropDownPosition)position frame:(CGRect)frame
{
    switch (position) {
        case ALDropDownPositionDefault:
        {
            _x = frame.origin.x;
            _width = frame.size.width;
            break;
        }
        case ALDropDownPositionRight:
        {
            _x = frame.origin.x+frame.size.width-_width;
            break;
        }
        case ALDropDownPositionLeft:
        {
            _x = frame.origin.x;
            break;
        }
        default:
            break;
    }

}
-(void)setUpWithData:(NSArray *)data
{
    self.frame = CGRectMake(_x,_y, _width, 0);
    self.list = [NSArray arrayWithArray:data];
//    self.layer.masksToBounds = NO;
//    self.layer.cornerRadius = 8;
//    self.layer.shadowOffset = CGSizeMake(-5, 5);
//    self.layer.shadowRadius = 5;
//    self.layer.shadowOpacity = 0.5;
    
    if (_onNavigationBar) {
        _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, _width, 0) style:UITableViewStyleGrouped];
    }
    else
        _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, _width, 0)];
    
    _table.delegate = self;
    _table.dataSource = self;
//    _table.layer.cornerRadius = 5;
    _table.backgroundColor = [UIColor clearColor];//[UIColor colorWithRed:0.239 green:0.239 blue:0.239 alpha:1];
    self.backgroundColor = [UIColor clearColor];
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
   
}
//-(id)initWithDropDown:(UIButton *)b width:(CGFloat)width arr:(NSArray *)arr
//{
//    btnSender = b;
//    self = [super init];
//    if (self) {
//        _hiden = YES;
//        // Initialization code
//        CGRect btn = btnSender.frame;
//        _width = width;
//        _x = btn.origin.x+btn.size.width-width;
//        _y = btn.origin.y+btn.size.height+20;
//        self.frame = CGRectMake(_x,_y, _width, 0);
//        self.list = [NSArray arrayWithArray:arr];
//        self.layer.masksToBounds = NO;
//        self.layer.cornerRadius = 8;
//        self.layer.shadowOffset = CGSizeMake(-5, 5);
//        self.layer.shadowRadius = 5;
//        self.layer.shadowOpacity = 0.5;
//        
//        table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, _width, 0)];
//        _table.delegate = self;
//        _table.dataSource = self;
//        _table.layer.cornerRadius = 5;
//        _table.backgroundColor = [UIColor colorWithRed:0.239 green:0.239 blue:0.239 alpha:1];
//        _table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
//        _table.separatorColor = [UIColor grayColor];
//        
//    }
//
//    return self;
//}
#pragma mark - 显示隐藏下拉菜单

-(void)showTable
{
    _table.frame = CGRectMake(0, 0, _width, 0);
    _hiden = NO;
    _height = self.list.count * kCellH;
    if (_onNavigationBar) {
        _height += kIndicatorH;
    }
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    self.frame = CGRectMake(_x,_y, _width, _height);
    _table.frame = CGRectMake(0, 0, _width, _height);
    [UIView commitAnimations];
    UIView *view = _btnSender.superview;
    view = _onNavigationBar? view.superview:view;
    [view addSubview:self];
    [self addSubview:_table];
    
}
-(void)hideTable {
    _hiden = YES;    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    self.frame = CGRectMake(_x,_y, _width, 0);
    _table.frame = CGRectMake(0, _height, _width, 0);
    [UIView commitAnimations];
}

#pragma mark - 实现tableview的代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
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
    cell.textLabel.text =[_list objectAtIndex:indexPath.row];
    cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tanchuang2"]];
    cell.backgroundView.alpha = _alphaValue;
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.table deselectRowAtIndexPath:indexPath animated:YES];
    [self hideTable];
    if ([_delegate respondsToSelector:@selector(dropDownDelegate:selected:)]) {
        [_delegate dropDownDelegate:self selected:indexPath.row];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _width, kIndicatorH)];
    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tanchuang1"]];
    image.frame = CGRectMake(_width-kIndicatorH-_btnSender.frame.size.width/2, 0, 20, kIndicatorH);
    view.alpha = _alphaValue;
    [view addSubview:image];
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    CGFloat height = kIndicatorH;
    if (!_onNavigationBar) {
        height = 0;
    }
    return height;
}

@end
