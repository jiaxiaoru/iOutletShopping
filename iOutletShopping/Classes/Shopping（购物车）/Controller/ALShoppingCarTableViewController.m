//
//  ALShoppingCarTableViewController.m
//  iOutletShopping
//
//  Created by Huashen on 14/11/4.
//  Copyright (c) 2014年 aolaigo. All rights reserved.
//

#import "ALShoppingCarTableViewController.h"
#import "ALShoppingCarCell.h"

@interface ALShoppingCarTableViewController ()<ALShoppingCarCellDelegate>
{
     NSMutableArray *_itemArray;
}
@end

@implementation ALShoppingCarTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.sectionHeaderHeight = 20;
    self.tableView.sectionFooterHeight = 0.1;
    
    //默认购物车有商品
    self.hasData = YES;
    _itemArray = [[NSMutableArray alloc] initWithCapacity:100];
    for (int i = 0; i < 100; i++) {
        
        NSString *pri = @"满299减50";
        NSString *pre = @"兰蔻爽肤水小样5ml  x1";
        if(i%4 == 0)
        {
            pri = @"";
        }
        if (i%3 == 0) {
            pre = @"";
        }
        ALShoppingCarItem *item = [ALShoppingCarItem shoppingCarItemWithDic:@{
                                                                              @"imageUrlStr":@"touxiangwan",
                                                                              @"title":[NSString stringWithFormat:@"Laneige/兰芝 水凝清盈保湿乳120ml %d",i],
                                                                              @"unitPrice":@"142.20",
                                                                              @"preUnitPrice":@"288.00",
                                                                              @"number":[NSString stringWithFormat:@"200+%d",i],
                                                                              @"describe":@"颜色:蓝色条纹窗花 尺码:XXL",
                                                                              @"totally":@"289.80",
                                                                              @"privilege":pri,
                                                                              @"present":pre}
                                   ];
        [_itemArray addObject:item];
        
        if (_itemArray.count == 0) {
            self.hasData = NO;
        }
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _itemArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _itemArray.count/_itemArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ALShoppingCarCell *cell = [tableView dequeueReusableCellWithIdentifier:[ALShoppingCarCell ID]];
    if (cell == nil) {
        cell = [ALShoppingCarCell shoppingCarCell];
        cell.delegate = self;
    }
    else
    {
        //不删除，复用会出问题
        UIView *view = [cell viewWithTag:100];
        [view removeFromSuperview];
        UIView *view1 = [cell viewWithTag:101];
        [view1 removeFromSuperview];
    }
    [cell changeUIToEdit:self.edit];
    cell.tag = indexPath.section;
    cell.shoppingCarItem = _itemArray[indexPath.section];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = [ALShoppingCarCell heightNormal];
    ALShoppingCarItem *item = _itemArray[indexPath.section];
    if (item.present.length && item.privilege.length) {
        height = [ALShoppingCarCell heightWithAll];
    }
    else if(item.present.length || item.privilege.length){
        height = [ALShoppingCarCell heightWithPrivilege];
    }
    return height;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:indexPath.section];
        [self removeGoodsWithIndexSet:indexSet];
    }
}

#pragma mark - 删除商品
-(void)removeGoodsWithIndexSet:(NSIndexSet *)indexSet
{
    [_itemArray removeObjectsAtIndexes:indexSet];
    [self.tableView deleteSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
    if (_itemArray.count == 0) {
        self.hasData = NO;
    }

#warning 把要删除的商品上传服务器
}


-(void)removeGoods
{
    NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSet];
    for (int i = 0; i < _itemArray.count; i++) {
        ALShoppingCarItem *item = _itemArray[i];
        if (item.selected) {
            [indexSet addIndex:i];
        }
    }
    [self removeGoodsWithIndexSet:indexSet];
}

#pragma mark - cell的代理方法的实现

-(void)shoppingCarCell:(ALShoppingCarCell *)cell tag:(NSInteger)tag supTag:(NSInteger)supTag number:(NSString *)number countAndPrice:(ALCountAndPrice)countAndPrice
{
    NSInteger section = supTag;
    ALShoppingCarItem *item = _itemArray[section];

    if (tag == 1) {
        ALLog(@"点击了选择按钮");
        item.selected = !item.selected;
    }
    else if (tag == 2){
        ALLog(@"点击了收藏按钮");
        item.favourite = !item.favourite;
#warning 点击收藏按钮要上传服务器
    }
    else{
        item.number = number;
        float totally = [item.number intValue] * [item.unitPrice floatValue];
        item.totally = [NSString stringWithFormat:@"%.2f",totally];
        countAndPrice(item.totally);
    }
    //选择/number的改变都会引起赠送view的label值改变
    if (tag != 2) {
        [self postValueToPresentViewWithStr:self.totallyStr];
    }
}

-(void)postValueToPresentViewWithStr:(NSString *)string
{
    if (_delegate && [_delegate respondsToSelector:@selector(shoppingCarTable:totally:)]) {
        [_delegate shoppingCarTable:self totally:string];
    }
}

#pragma mark - 所有商品都选中
-(void)setSelectedAllGoods:(BOOL)selectedAllGoods
{
    _selectedAllGoods = selectedAllGoods;
    for (ALShoppingCarItem *item in _itemArray) {
        item.selected = selectedAllGoods;
    }
    [self.tableView reloadData];
}

#pragma mark - 给结算view传值
-(NSString *)totallyStr
{
    NSString *totallyStr = [NSString stringWithFormat:@"0.0（共0件）"];
    float bigTotally = 0.0;
    NSUInteger count = 0;
    for (ALShoppingCarItem *item in _itemArray) {
        if (item.selected) {
            bigTotally += item.totally.floatValue;
            count += item.number.intValue;
        }
    }
    totallyStr = [NSString stringWithFormat:@"%.2f（共%lu件）",bigTotally,(unsigned long)count];
    
    return totallyStr;
}

#pragma mark - 修改模型成编辑UI
-(void)setEdit:(BOOL)edit
{
    _edit = edit;
    [self.tableView reloadData];
    
}

@end
