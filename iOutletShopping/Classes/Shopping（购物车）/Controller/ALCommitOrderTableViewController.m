//
//  ALCommitOrderTableViewController.m
//  iOutletShopping
//
//  Created by Huashen on 14/11/10.
//  Copyright (c) 2014年 aolaigo. All rights reserved.
//

#import "ALCommitOrderTableViewController.h"
#import "ALSettingArrowItem.h"
#import "ALSettingGroup.h"
#import "ALSettingButtonItem.h"
#import "ALCommitOrderItem.h"
#import "ALCommitOrderCell.h"
#import "ALSettingCell.h"
#import "ALSimpleView.h"


@interface ALCommitOrderTableViewController ()
{
    NSArray *_titleArr;
    NSMutableArray *_allGroups; // 所有的组模型
}
@end

@implementation ALCommitOrderTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.tableView.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0];
    _allGroups = [NSMutableArray array];
    
    [self add0SectionItems];
    
    [self add1SectionItems];
    
    [self add2SectionItems];
    
    [self add3SectionItems];
    
}
#pragma mark - 收货地址
-(void)add0SectionItems
{
    ALSettingArrowItem *address = [ALSettingArrowItem itemWithTitle:@"范冰冰，13800013800\n广东省 深圳市 罗湖区\nxxx街道星星花园6栋1001，518000"];
//    address.showVCClass = [ALAddressViewController class];
    
    ALSettingGroup *group = [[ALSettingGroup alloc] init];
    group.items = @[address];
    group.header = @"收货地址";
    
    [_allGroups addObject:group];
}

#pragma mark - 支付方式
-(void)add1SectionItems
{
    ALSettingButtonItem *payMethod = [ALSettingButtonItem itemWithIcon:@"pay" title:@"微信支付"];
    payMethod.normalImageName = @"nohookselected";
    payMethod.selectedImageName = @"selectedhook";
    
    ALSettingItem *item = [ALSettingItem itemWithIcon:@"down" title:@"选择其他支付方式"];

    
    ALSettingGroup *group = [[ALSettingGroup alloc] init];
    group.items = @[payMethod,item];
    group.header = @"支付方式";
    
    [_allGroups addObject:group];
        
}
#pragma mark - 商品清单

-(void)add2SectionItems
{
    NSDictionary *dic = @{
                          @"imageName":@"people",
                          @"title":@"Laneige/兰芝 水凝轻盈保湿乳120ml",
                          @"unitPrice":@"142.20",
                          @"preUnitPrice":@"288.00",
                          @"stype":@"颜色:蓝色条纹窗花 尺码:XXL",
                          @"smallTotally":@"289.80",
                          @"discountInfo":@"使用优惠券：满1000减100",
                          @"pointsInfo":@"可用50积分抵用0.5元",
                          @"goodsCount":@"6",
                          @"presentCount":@"1",
                          @"totally":@"920.50",
                          @"freight":@"10.00",
                          @"discountPrice":@"100.00"
                          };
    ALCommitOrderItem *item = [ALCommitOrderItem commitOrderItemWithDic:dic];
    
    ALSettingGroup *group = [[ALSettingGroup alloc] init];
    group.items = @[item];
    group.header = @"商品清单";
    
    [_allGroups addObject:group];
    
}

#pragma mark - 发票信息

-(void)add3SectionItems
{
    ALSettingGroup *group = [[ALSettingGroup alloc] init];
    group.header = @"发票信息";
    [_allGroups addObject:group];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _allGroups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    ALSettingGroup *group = _allGroups[section];
    return group.items.count;
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 2.取出这行对应的模型（ALSettingItem）
    ALSettingGroup *group = _allGroups[indexPath.section];
    ALSettingItem *item = group.items[indexPath.row];
    
    NSUInteger section = indexPath.section;
    NSUInteger row = indexPath.row;
    if (section == 1 && row == 1 && group.items.count == 2)
    {
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        UIButton *button = [[UIButton alloc] init];
        button.frame = cell.frame;
        [button setTitle:item.title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:item.icon] forState:UIControlStateNormal];
        //让button左边是文字右边是图片
        [button setTitleEdgeInsets:UIEdgeInsetsMake(0, -button.imageView.frame.size.width, 0, button.imageView.frame.size.width)];
        [button setImageEdgeInsets:UIEdgeInsetsMake(0, button.titleLabel.bounds.size.width, 0, -button.titleLabel.bounds.size.width)];
        
        [cell addSubview:button];
        return cell;
    }
    else if (section == 2)
    {
        ALCommitOrderCell *cell = [ALCommitOrderCell commitOrderCell];
        cell.item = (ALCommitOrderItem *)item;
        return cell;
    }
    else
    {
        ALSettingCell *cell = [ALSettingCell settingCellWithTableView:tableView];
    
        cell.item = item;
        cell.textLabel.numberOfLines = 0;
        //    cell.indexPath = indexPath;
        return cell;
    }

}

#pragma mark 返回每一组的header标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    ALSettingGroup *group = _allGroups[section];
    
    return group.header;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 3) {
        ALSimpleView *headerView = [[ALSimpleView alloc] init];
        headerView.view.backgroundColor = self.tableView.backgroundColor;
        headerView.view.frame = CGRectMake(0, 0, kScreenWidth, 30);
        headerView.titleLabel.text = @"发票信息";
        [headerView.button addTarget:self action:@selector(billBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [headerView.button setImage:[UIImage imageNamed:@"nohookselected"] forState:UIControlStateNormal];
        [headerView.button setImage:[UIImage imageNamed:@"selectedhook"] forState:UIControlStateSelected];
        
        return headerView.view;
    }
    return nil;
}

-(void)billBtnClicked:(UIButton *)btn
{
    btn.selected = !btn.selected;
    if (btn.selected) {
        ALSettingGroup *group = _allGroups[3];
        group.items = @[]
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.000001f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger section = indexPath.section;
    NSUInteger height = 40;
    if (section == 0) height = 80;
    else if (section == 2) height = [ALCommitOrderCell height];
    return height;
}
@end
