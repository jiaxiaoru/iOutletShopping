//
//  ALGoPayViewController.m
//  iOutletShopping
//
//  Created by Huashen on 14/11/4.
//  Copyright (c) 2014年 aolaigo. All rights reserved.
//

#import "ALGoPayViewController.h"

@interface ALGoPayViewController ()

//设置全选按钮的位置
@property (assign,nonatomic) BOOL frameFlag;

@property (weak, nonatomic) IBOutlet UIButton *selectAllBtn;
@property (weak, nonatomic) IBOutlet UILabel *totallyLabel;
@property (weak, nonatomic) IBOutlet UIButton *goPayBtn;
@property (weak, nonatomic) IBOutlet UIView *goPayView;

@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property (weak, nonatomic) IBOutlet UIView *shoppingCarView;
@property (weak, nonatomic) IBOutlet UIView *commitView;
@property (weak, nonatomic) IBOutlet UILabel *commitTotally;





@end

@implementation ALGoPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
-(void)setType:(ALGoPayViewType)type
{
    CGRect frame = self.view.frame;
    frame.origin.y = 0;
    self.shoppingCarView.frame = frame;
    switch (type) {
        case ALGoPayViewDefaultType:
            [self.view addSubview:self.shoppingCarView];
            self.deleteBtnHide = YES;
            break;
        case ALGoPayViewDeleteType:
            [self.view addSubview:self.shoppingCarView];
            self.deleteBtnHide = NO;
            break;
        case ALGoPayViewCommitType:
            self.commitView.frame = frame;
            [self.view addSubview:self.commitView];
            break;
        default:
            break;
    }
}

#pragma mark - 去结算/全选/删除按钮点击了

- (IBAction)btnClicked:(UIButton *)sender {
    NSInteger tag = sender.tag;
    //点击了全选按钮，修改视图
    if (tag == 1) {
        sender.selected = !sender.selected;
    }
    //通过代理方法去修改数据模型
    if (_delegate && [_delegate respondsToSelector:@selector(goPay:button:)])
    {
        [_delegate goPay:self button:sender];
    }

}

#pragma mark - 设置总金额
-(void)totallyStr:(NSString *)string
{
    _totallyLabel.text = string;
}

//-(void)setShowGoPayView:(BOOL)showGoPayView
//{
//    _showGoPayView = showGoPayView;
//    self.deleteBtnHide = showGoPayView;
//}
//
//-(void)setShowDeleteView:(BOOL)showDeleteView
//{
//    _showDeleteView = showDeleteView;
//    self.deleteBtnHide = !showDeleteView;
//}
//
//-(void)setShowCommitOrderView:(BOOL)showCommitOrderView
//{
//    _showCommitOrderView = showCommitOrderView;
//    _shoppingCarView.hidden = showCommitOrderView;
//    _commitView.hidden = !showCommitOrderView;
//    
//}
#pragma mark - 切换删除/去结算视图
-(void)setDeleteBtnHide:(BOOL)deleteBtnHide
{
    _deleteBtnHide = deleteBtnHide;
    _deleteBtn.hidden = deleteBtnHide;
    _goPayView.hidden = !deleteBtnHide;
    [self setFrameFlag:!deleteBtnHide] ;
}

-(void)setFrameFlag:(BOOL)frameFlag
{
    _frameFlag = frameFlag;
    CGRect frame =  _selectAllBtn.frame;
    ALLog(@"%f",kScreenWidth);
    CGFloat x = frameFlag ? kScreenWidth-_selectAllBtn.frame.size.width-10:8;
    frame.origin.x = x;
    _selectAllBtn.frame = frame;
}
@end
