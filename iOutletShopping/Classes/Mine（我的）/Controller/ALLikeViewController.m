
//
//  ALLikeViewController.m
//  iOutletShopping
//
//  Created by Chris on 14/11/8.
//  Copyright (c) 2014年 aolaigo. All rights reserved.
//

#import "ALLikeViewController.h"
#import "ALLikeCollectionViewCell.h"
#import "ThemeLeftButton.h"

@interface ALLikeViewController ()

@end

@implementation ALLikeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //创建导航按钮
    [self _initNavItem];
    //初始化子视图
    [self _initViews];
}
//创建导航按钮
- (void)_initNavItem{
    //1.创建返回按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 100, 44);
    [button setTitle:@"<  收藏商品" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    //添加到导航控制器上
    self.navigationItem.leftBarButtonItem = backItem;
    
    //2.创建删除按钮
    UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    deleteButton.tag = 1;
    deleteButton.frame = CGRectMake(0, 0, 30, 30);
    [deleteButton setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
    [deleteButton addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:deleteButton];

    //3.添加返回首页的按钮
    ALBarButtonItem *homeButtonItem = [ALBarButtonItem BarButtonItemWithPosition:CGRectMake(0, 0, 30, 30) type:barButtonItemTypeHome controller:self.navigationController];
    //添加到导航控制器上
    self.navigationItem.rightBarButtonItems = @[homeButtonItem,rightItem];

}

//初始化子视图
- (void)_initViews{
    //1.创建瀑布视图
    //控制样式
    UICollectionViewFlowLayout *layOut = [[UICollectionViewFlowLayout alloc]init];
    //1.设置每个item的大小
    layOut.itemSize = CGSizeMake((kScreenWidth-15)/2.0, 250);
    //2.设置行的间距
    layOut.minimumLineSpacing = 5;
    
    //3.设置列的间距
    layOut.minimumInteritemSpacing = 5;
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(5, 5, kScreenWidth-10, kScreenHeight) collectionViewLayout:layOut];
    
    //4.设置代理对象
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.backgroundView = nil;
    //5.设置item的重用类
    [_collectionView registerClass:[ALLikeCollectionViewCell class] forCellWithReuseIdentifier:@"ALLikeCellId"];
    
    [self.view addSubview:_collectionView];
    
}
#pragma mark - UICollectionView Delegate协议方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //如果有闲置的就拿到使用,如果没有,系统自动的去创建
    ALLikeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[ALLikeCollectionViewCell ID] forIndexPath:indexPath];
    return cell;
}
//点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}
#pragma mark - 点击删除按钮
- (void)deleteAction:(UIButton *)button{
   NSInteger tag = button.tag;
   //button.tag = 2; 删除按钮点击
    if (tag == 1) {
        //修改导航按钮
        [self modifyNavForDeleteView];
    }
    //tag==2 完成按钮点击
    else{
        NSLog(@"完成");
        [self _initNavItem];
    }
}
#pragma mark - 修改nav的右按钮
-(void)modifyNavForDeleteView
{
    //移除原来的按钮
    self.navigationItem.rightBarButtonItems = nil;
    self.navigationItem.leftBarButtonItem = nil;
    //1.创建按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 100, 44);
    [button setTitle:@"收藏商品" forState:UIControlStateNormal];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    //添加到导航控制器上
    self.navigationItem.leftBarButtonItem = backItem;
    
    //1.完成
    UIButton *completeBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 24)];
    completeBtn.tag = 2;
    completeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [completeBtn setTitle:@"完成" forState:UIControlStateNormal];
    [completeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [completeBtn addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *completeBtnItem = [[UIBarButtonItem alloc] initWithCustomView:completeBtn];
    
    //2.添加全选按钮
    ThemeLeftButton *allSelectedButton = [[ThemeLeftButton alloc]initWithTitle:@"全选" ImageName:@"nohookselected" BgImageName:nil frame:CGRectMake(0, 0,80, 49)];
    [allSelectedButton addTarget:self action:@selector(allSelectedAction:) forControlEvents:UIControlEventTouchUpInside];
     UIBarButtonItem *allSelectedItem = [[UIBarButtonItem alloc]initWithCustomView:allSelectedButton];
    self.isAllDelete = NO;
    self.navigationItem.rightBarButtonItems = @[allSelectedItem,completeBtnItem];
}


#pragma mark - 点击全选事件
- (void)allSelectedAction:(ThemeLeftButton *)button{
    self.isAllDelete = !self.isAllDelete;
    if (self.isAllDelete == NO) {
        //取消全选
        button.titleImageView.image = [UIImage imageNamed:@"nohookselected"];
    }else{
        //全选
        button.titleImageView.image = [UIImage imageNamed:@"selectedhook"];
        
        
    }
}
#pragma mark - 返回事件
- (void)backAction:(UIButton *)button{
    [self.navigationController popViewControllerAnimated:YES];
}
@end

