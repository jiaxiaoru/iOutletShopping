//
//  ALMyOrdersViewController.m
//  iOutletShopping
//
//  Created by Huashen on 14/10/31.
//  Copyright (c) 2014年 aolaigo. All rights reserved.
//

#import "ALMyOrdersViewController.h"
#import "ALSlideSwitchView.h"
#import "ALMyOrderTableViewController.h"

@interface ALMyOrdersViewController ()<ALSlideSwitchViewDelegate>
{
    ALSlideSwitchView *_slideSwitchView;
    NSMutableArray *_tableViewArray;

}
@end

@implementation ALMyOrdersViewController

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    [self settingBarButton];
    [self addMyOrderCollectionView];
}

-(void)settingBarButton
{
    //设置背景色和标题
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"我的订单";
    
    //添加返回键
    
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 24, 24)];
    [backBtn addTarget:self action:@selector(backTopView) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"CellArrow"] forState:UIControlStateNormal];
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backButtonItem;

    //添加返回首页的按钮
    ALBarButtonItem *homeButtonItem = [ALBarButtonItem BarButtonItemWithPosition:kRightFirstBtnFrame type:barButtonItemTypeHome controller:self.navigationController];
    self.navigationItem.rightBarButtonItem = homeButtonItem;
}
-(void)addMyOrderCollectionView
{
    _slideSwitchView = [[ALSlideSwitchView alloc] initWithFrame:self.view.bounds];
    _slideSwitchView.delegate = self;
    [self.view addSubview:_slideSwitchView];
    //让view的坐标点点从navigation开始
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    //0. 设置tab的字体的颜色和背景
    _slideSwitchView.tabItemNormalColor = [ALSlideSwitchView colorFromHexRGB:@"868686"];
    _slideSwitchView.tabItemSelectedColor = [ALSlideSwitchView colorFromHexRGB:@"bb0b15"];
    _slideSwitchView.shadowImage = [[UIImage imageNamed:@"red_line_and_shadow.png"]
                                    stretchableImageWithLeftCapWidth:59.0f topCapHeight:0.0f];
    NSArray *tabTitles = [NSArray arrayWithObjects:@"全部",@"待付款",@"待发货",@"待收货",@"已完成",@"已取消", nil];
    
    //2. 有多个标题创建多少个collectionView以展示不同的数据
    int count = tabTitles.count;
    _tableViewArray = [NSMutableArray arrayWithCapacity:count+1];
    for (int  i = 0; i < count; i++) {
        ALMyOrderTableViewController *tableViewCtrl = [[ALMyOrderTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
        tableViewCtrl.title = tabTitles[i];
        [_tableViewArray addObject:tableViewCtrl];
    }
    
    [_slideSwitchView buildUIFix:NO];

}
#pragma mark - 返回我的奥莱购界面
-(void)backTopView
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 滑动tab视图代理方法

- (NSUInteger)numberOfTab:(ALSlideSwitchView *)view
{
    return _tableViewArray.count;
}

- (UIViewController *)slideSwitchView:(ALSlideSwitchView *)view viewOfTab:(NSUInteger)number
{
    return _tableViewArray[number];
}

@end
