//
//  ALMineCollectionViewController.m
//  iOutletShopping
//
//  Created by Huashen on 14/10/28.
//  Copyright (c) 2014年 aolaigo. All rights reserved.
//

#import "ALMineCollectionViewController.h"
#import "ALMineCollectionItem.h"
#import "ALMineCollectionViewCell.h"

#import "ALLoginViewController.h"

@interface ALMineCollectionViewController ()
{
    NSArray *_data;
    NSDictionary *_allDataDic;
}
@end

@implementation ALMineCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.collectionView registerClass:[ALMineCollectionViewCell class] forCellWithReuseIdentifier:[ALMineCollectionViewCell ID]];
    
    [self setUpData];
}

#pragma mark - 从plist取数据
-(void)setUpData
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"MineAllNames.plist" ofType:nil];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
    _allDataDic = [NSDictionary dictionaryWithDictionary:dic];
    _data =[NSArray arrayWithArray:_allDataDic[self.title]];
#warning 判断有无登陆，有登陆就要从服务器取右上角数字的数据
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _data.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ALMineCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[ALMineCollectionViewCell ID] forIndexPath:indexPath];
    cell.mineCollectionItem = [ALMineCollectionItem mineCollectionItemWithDic:_data[indexPath.row]];
    return cell;
}

#pragma mark <UICollectionViewDelegate>
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [ALMineCollectionViewCell cellSize];
}
//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ALMineCollectionViewCell * cell = (ALMineCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    ALLog(@"selected %@",self.title);
    NSString *className = [JudgeLogin shareInstance].login ? cell.className:@"ALLoginViewController";
    //使用代理方法到父控制器进行页面的跳转，因为在本控制器跳转无效
    if (_delegate && [_delegate respondsToSelector:@selector(mineCollectionViewController:jumpTo:)]) {
        [_delegate mineCollectionViewController:self jumpTo:className];
    }
}
-(void)changeTabClicked
{
    _data = _allDataDic[self.title];
    [self.collectionView reloadData];
}
@end
