//
//  ALShoppingCarTableController.m
//  iOutletShopping
//
//  Created by Huashen on 14-10-20.
//  Copyright (c) 2014年 aolaigo. All rights reserved.
//

#import "ALShoppingCarViewController.h"
#import "ALMineCollectionViewController.h"
#import "ALShoppingCarTableViewController.h"
#import "ALShoppingCarItem.h"
#import "ALGoPayViewController.h"
#import "ALEmptyShoppingCarViewController.h"

@interface ALShoppingCarViewController ()<ALGoPayViewControllerDelegate,ALShoppingCarTableViewControllerDelegate>
{
    ALGoPayViewController *_goPayView;
    ALShoppingCarTableViewController *_tableViewController;
    ALEmptyShoppingCarViewController *_emptyView;
}
@end
@implementation ALShoppingCarViewController

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
    
}
//UI布局
-(void)setUpUI
{
    //检查购物车是否为空
    BOOL flag = [self checkNoEmpty];
    if (flag) {
        //添加tableView,如果tableview没有数据则加载空购物车的View flag = no;
        [self addTableView];
    }
    //添加Nav上的删除/去主页按钮
    [self settingBarButton:flag];
    
    //添加去结算按钮或添加空购物车view
    flag ? [self addPayOffBtn]:[self addEmptyCarView];
}
-(BOOL)checkNoEmpty
{
    if (_tableViewController == nil) {
        _tableViewController  = [[ALShoppingCarTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
        
        //这句话必须放在调用hasdata之前，因为下面这句话调用了viewdidload
        _tableViewController.view.frame = self.view.frame;
    }
    BOOL hasData = _tableViewController.hasData;
    
    return hasData;

}
-(void)addEmptyCarView
{
    _emptyView = [[ALEmptyShoppingCarViewController alloc] init];
    //让view的坐标点点从navigation开始
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    [self.view addSubview:_emptyView.view];
}
//初始化标题栏
-(void)settingBarButton:(BOOL)bothAdd
{
    //设置标题
    self.title = @"购物车";
    
    //隐藏返回键
    self.navigationItem.hidesBackButton = YES;
    
    [self addNavRightItems:bothAdd];
    
}

#pragma mark -  添加删除/主页按钮
-(void)addNavRightItems:(BOOL)bothAdd
{
    self.navigationItem.rightBarButtonItem = nil;
    self.navigationItem.rightBarButtonItems = nil;
    
    //添加返回首页的按钮
    ALBarButtonItem *homeButtonItem = [ALBarButtonItem BarButtonItemWithPosition:kRightFirstBtnFrame type:barButtonItemTypeHome controller:self.navigationController];
    
    NSMutableArray *items = [NSMutableArray arrayWithObject:homeButtonItem];
    //如果tableview有数据，则添加删除按钮
    if (bothAdd) {
        //添加删除购物车项的按钮
        UIButton *trashBtn = [[UIButton alloc] initWithFrame:kRightSecondBtnFrame];
        [trashBtn setImage:[UIImage imageNamed:@"TabBar2"] forState:UIControlStateNormal];
        [trashBtn addTarget:self action:@selector(deleteBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *trashBtnItem = [[UIBarButtonItem alloc] initWithCustomView:trashBtn];
        [items addObject:trashBtnItem];
    }
   
    self.navigationItem.rightBarButtonItems = items;

}
#pragma mark - 添加tableview视图
-(void)addTableView
{
    _tableViewController.delegate = self;
    [self addChildViewController:_tableViewController];
    [self.view addSubview:_tableViewController.view];
}
#pragma mark - 添加去结算视图
-(void)addPayOffBtn
{
    _goPayView = [[ALGoPayViewController alloc] init];
    _goPayView.view.frame = CGRectMake(0, [[UIScreen mainScreen] bounds].size.height-50, [[UIScreen mainScreen] bounds].size.width, 50);
    _goPayView.delegate = self;
    [self.view addSubview:_goPayView.view];

}
#pragma mark - 去结算视图代理方法的实现
-(void)goPay:(ALGoPayViewController *)controller button:(UIButton *)button
{
    NSInteger tag = button.tag;
    //1. 点击了全选按钮
    if (tag == 1)
    {
        ALLog(@"点击了全选按钮");
        //1.1 修改tableview的数据模型
        _tableViewController.selectedAllGoods = button.selected;
        //1.2 刷新tableview
        //1.3 计算出总金额和商品数量，传值给结算视图
        NSString *price = _tableViewController.totallyStr;
        [controller totallyStr:price];
    }
    //2. 点击了去结算
    else if (tag == 2)
    {
        ALLog(@"点击了去结算");
        //2.1 跳转到去结算UI
        //[ALJumpToAnotherUI jumpToAnotherUI:@"去结算页面" withNavCtrl:self.navigationController];
    }
    //3. 点击了删除
    else if(tag == 3)
    {
        [_tableViewController removeGoods];
        
        //如果清空了，则回到购物车为空的UI
        BOOL flag = [self checkNoEmpty];
        if (!flag) {
            [self addNavRightItems:flag];
            //添加空购物车view
            [self addEmptyCarView];
        }
        
    }
}
#pragma mark - tableView的代理方法的实现
-(void)shoppingCarTable:(ALShoppingCarTableViewController *)controller totally:(NSString *)totally
{
    [_goPayView totallyStr:totally];
}

#pragma mark - 删除/完成
-(void)deleteBtnClicked:(UIButton *)btn
{
    NSInteger tag = btn.tag;
    //1. 修改去结算视图:tag->0 删除按钮点击 tag->1 完成按钮点击
    _goPayView.deleteBtnHide = tag;
    //tag->0 删除按钮点击
    if (tag == 0) {
        ALLog(@"trash button clicked");
        //2. 修改nav的右边按钮
        [self modifyNavForDeleteView];
        //3. 修改tableview的显示
        _tableViewController.edit = YES;
        
    }
    //tag==1 完成按钮点击
    else{
        [self addNavRightItems:YES];
        _tableViewController.edit = NO;
        //完成后可能删除了某些商品，需要刷新去结算的总金额
        [_goPayView totallyStr:_tableViewController.totallyStr];
    }
    
}

#pragma mark - 修改nav的右按钮
-(void)modifyNavForDeleteView
{
    UIButton *completeBtn = [[UIButton alloc] initWithFrame:CGRectMake(260, 10, 44, 24)];
    completeBtn.tag = 1;
    completeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [completeBtn setTitle:@"完成" forState:UIControlStateNormal];
    [completeBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [completeBtn addTarget:self action:@selector(deleteBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItems = nil;
    UIBarButtonItem *completeBtnItem = [[UIBarButtonItem alloc] initWithCustomView:completeBtn];
    self.navigationItem.rightBarButtonItem =completeBtnItem;
    
}

@end
