//
//  ALBaseSettingViewController.m
//  iOutletShopping
//
//  Created by Huashen on 14-9-27.
//  Copyright (c) 2014年 aolaigo. All rights reserved.
//

#import "ALBaseSettingViewController.h"
#import "ALSettingCell.h"


@interface ALBaseSettingViewController ()

@end
const int ALCellSectionHeaderH = 40;
@implementation ALBaseSettingViewController

- (void)loadView
{
    _allGroups = [NSMutableArray array];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    
    // 设置背景
//    tableView.backgroundView = nil;
//    tableView.backgroundColor = ALGlobalBg;
    
    // group状态下，sectionFooterHeight和sectionHeaderHeight是有值的
//    tableView.sectionFooterHeight = 0.000001f;
//    tableView.sectionHeaderHeight = ALCellSectionHeaderH;
    tableView.rowHeight = 40;
    
    // 在tableView初始化的时候设置contentInset
    // 在tableView展示完数据的时候给contentInset.top增加64的值
//    tableView.contentInset = UIEdgeInsetsMake(ALCellSectionHeaderH - 35, 0, 0, 0);
    
    // 隐藏分隔线
//    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.view = tableView;
    
    _tableView = tableView;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _allGroups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    ALSettingGroup *group = _allGroups[section];
    return group.items.count;
}

#pragma mark 每当有一个cell进入视野范围内就会调用，返回当前这行显示的cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.创建一个ALSettingCell
    ALSettingCell *cell = [ALSettingCell settingCellWithTableView:tableView];
    
    // 2.取出这行对应的模型（ALSettingItem）
    ALSettingGroup *group = _allGroups[indexPath.section];
    cell.item = group.items[indexPath.row];
//    cell.indexPath = indexPath;
    return cell;
}

#pragma mark 点击了cell后的操作
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 去除选中时的背景
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // 0.取出这行对应的模型
    ALSettingGroup *group = _allGroups[indexPath.section];
    ALSettingItem *item = group.items[indexPath.row];
    
    // 1.取出这行对应模型中的block代码
    if (item.operation) {
        // 执行block
        item.operation();
        return;
    }
    
    // 2.检测有没有要跳转的控制器
    if ([item isKindOfClass:[ALSettingArrowItem class]]) {
        ALSettingArrowItem *arrowItem = (ALSettingArrowItem *)item;
        if (arrowItem.showVCClass) {
            UIViewController *vc = [[arrowItem.showVCClass alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

#pragma mark 返回每一组的header标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    ALSettingGroup *group = _allGroups[section];
    
    return group.header;
}
#pragma mark 返回每一组的footer标题
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    ALSettingGroup *group = _allGroups[section];
    
    return group.footer;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.000001f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return ALCellSectionHeaderH;
}
@end
