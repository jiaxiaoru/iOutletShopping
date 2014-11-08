//
//  ALSearchViewController.m
//  iOutletShopping
//
//  Created by Huashen on 14-9-25.
//  Copyright (c) 2014年 aolaigo. All rights reserved.
//

#import "ALSearchViewController.h"
#import "ALSaveArrayData.h"
#import "ALSettingKeys.h"
@interface ALSearchViewController ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_oldSearchResults;
    NSString *_keyWords;
    ALSaveArrayData *_data;
}
@end

@implementation ALSearchViewController

#pragma mark - 初始化
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    _data.dataSaved = [NSArray arrayWithArray:_oldSearchResults];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTitleView];
    [self setUp];
}

-(void)setUp
{
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"ID"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    //1. 添加tableview的tableHeaderView以显示“最近搜索：”
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 44, 44)];
    label.text = @"最近搜索：";
    self.tableView.tableHeaderView = label;
    
    //2. 如果不设置这个高度，section的footerview会紧贴着tableview
    self.tableView.sectionFooterHeight = 44;
    //3. 从数据库取出搜索历史记录
    _data = [[ALSaveArrayData alloc] init];
    _data.key = ALSaveSearchRecord;
    _oldSearchResults = [NSMutableArray arrayWithArray:_data.dataSaved];
//    _oldSearchResults = [NSMutableArray arrayWithArray:@[@"箱包",@"连衣裙",@"手机",@"奶粉",@"拉杆箱"]];
}
#pragma mark - 添加搜索框

-(void)addTitleView
{
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    UISearchBar *searchBar = [[UISearchBar alloc] init];
    searchBar.placeholder = @"搜索你喜欢的商品";
    searchBar.delegate = self;
    
    //1. 让搜索框内的光标呈蓝色
    searchBar.tintColor = [UIColor blueColor];
    searchBar.backgroundImage = [self imageWithColor:[UIColor clearColor]];
    
    //2. 让“搜索”文字呈白色
    [self.navigationItem.leftBarButtonItem setTitleTextAttributes:@{
               NSForegroundColorAttributeName:[UIColor whiteColor]
    }forState:UIControlStateNormal];
    
    [searchBar sizeToFit];
    self.navigationItem.titleView = searchBar;
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

#pragma mark - 实现UISearchBar的代理方法
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    ALLog(@"clicked");
    if (searchBar != nil) {
        _keyWords = searchBar.text;
    }
#warning 调用接口取搜索结果并跳转到搜索结果的页面
    [self saveSearchResult];
}
#pragma mark - 保存搜索的历史记录
-(void)saveSearchResult
{
    [_oldSearchResults insertObject:_keyWords atIndex:0];
    if (_oldSearchResults.count > 10) {
        [_oldSearchResults removeLastObject];
    }
}
#pragma mark - 实现UITableView的代理方法

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _oldSearchResults.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ID" forIndexPath:indexPath];
    cell.textLabel.text = _oldSearchResults[indexPath.row];
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIButton *clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    NSString *title = @"";
    if (_oldSearchResults.count > 0) {
        title = @"清除历史记录";
        [clearBtn addTarget:self action:@selector(clearAllResults) forControlEvents:UIControlEventTouchUpInside];
    }
    //1. 清除记录之后或无记录，按钮不可用，并显示“最近无搜索记录”
    else{
        title = @"最近无搜索记录";
        clearBtn.enabled = NO;
    }
    [clearBtn setTitle:title forState:UIControlStateNormal];
    [clearBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    return clearBtn;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    _keyWords = _oldSearchResults[indexPath.row];
    [self searchBarSearchButtonClicked:nil];
}
#pragma mark - 清除历史记录
-(void)clearAllResults
{
    //清除数据库所有的搜索历史记录
    [_data clearAllData];
    //清除tableview的数据
    [_oldSearchResults removeAllObjects];
    [self.tableView reloadData];
}


@end
