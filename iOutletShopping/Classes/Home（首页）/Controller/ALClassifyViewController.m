//
//  ALClassifyViewController.m
//  iOutletShopping
//
//  Created by Huashen on 14-9-30.
//  Copyright (c) 2014年 aolaigo. All rights reserved.
//

#import "ALClassifyViewController.h"
#import "ALCategoryTitleItem.h"
#import "UILabel+ALLabel.h"
#import "ALCollectionHeaderView.h"
#import "PPRevealSideViewController.h"

#define kCollectionId @"collectionID"
#define kTableViewId @"LeftSideCellId"
#define kReuseID @"reuseID"

@interface ALClassifyViewController ()<UITableViewDataSource,UITabBarDelegate,UISearchBarDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
{
    NSMutableArray *_titleArray;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation ALClassifyViewController

#pragma mark - 初始化

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //1. 让搜索框内的光标呈蓝色
    _searchBar.tintColor = [UIColor blueColor];
    _searchBar.backgroundImage = [self imageWithColor:[UIColor clearColor]];
    
    //2. 让“搜索”文字呈白色
    [self.navigationItem.leftBarButtonItem setTitleTextAttributes:@{
                                                                    NSForegroundColorAttributeName:[UIColor whiteColor]
                                                                    }forState:UIControlStateNormal];

    [self setupUI];

}

- (void)setupUI
{
    _titleArray = [NSMutableArray array];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"CategoryTitles" ofType:@"plist"];
    NSArray *titleContents = [NSArray arrayWithContentsOfFile:path];
    for(NSDictionary *tempDic in titleContents)
    {
        ALCategoryTitleItem *item = [ALCategoryTitleItem categoryTitleItemWithDic:tempDic];
        [_titleArray addObject:item];
    }
    
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kCollectionId];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kTableViewId];
    
    
    UINib *headerNib = [UINib nibWithNibName:@"ALCollectionReusableView" bundle:nil];
    
    [self.collectionView registerNib:headerNib forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kReuseID];
}

#pragma mark - 去除搜索框背景色
- (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


#pragma mark - TableView代理方法的实现


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTableViewId forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:120/255.0 green:120/255.0 blue:120/255.0 alpha:1];
    UIView *backgrdView = [[UIView alloc] initWithFrame:cell.frame];
    backgrdView.backgroundColor = [UIColor blackColor];
    cell.selectedBackgroundView = backgrdView;
    ALCategoryTitleItem *item = _titleArray[indexPath.row];
    cell.textLabel.text = item.labelTitle;
    cell.textLabel.textColor = [UIColor whiteColor];
    [cell.imageView setImage:[UIImage imageNamed:item.leftView]];
    return  cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - collectionView代理方法的实现

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 5;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 5;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCollectionId forIndexPath:indexPath];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(indexPath.row*40, 20, 40, 40);
    [btn setImage:[UIImage imageNamed:@"touxiangwan"] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor whiteColor];
    
    cell.backgroundView = btn;
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}
#pragma mark - 返回上一界面

- (IBAction)popToLastUI:(UIButton *)sender {
    [self.revealSideViewController popViewControllerAnimated:YES];
}

//返回标题
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    ALCollectionHeaderView *reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader){
        reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader  withReuseIdentifier:kReuseID forIndexPath:indexPath];
        //建模型，取标题
        reusableview.headerLabel.text = @"123";
        
    }
    return reusableview;
}
@end
