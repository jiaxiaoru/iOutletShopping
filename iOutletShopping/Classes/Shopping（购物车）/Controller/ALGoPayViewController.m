//
//  ALGoPayViewController.m
//  iOutletShopping
//
//  Created by Huashen on 14/11/4.
//  Copyright (c) 2014年 aolaigo. All rights reserved.
//

#import "ALGoPayViewController.h"

@interface ALGoPayViewController ()


@property (weak, nonatomic) IBOutlet UIButton *selectAllBtn;
@property (weak, nonatomic) IBOutlet UILabel *totallyLabel;
@property (weak, nonatomic) IBOutlet UIButton *goPayBtn;
@property (weak, nonatomic) IBOutlet UIView *goPayView;

@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;

- (IBAction)deleteBtnClicked:(UIButton *)sender;


@end

@implementation ALGoPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

#pragma mark - 去结算/全选按钮点击了

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

- (IBAction)deleteBtnClicked:(UIButton *)sender {
    ALLog(@"delete button clicked");
}
#pragma mark - 切换删除/去结算视图
-(void)setDeleteBtnHide:(BOOL)deleteBtnHide
{
    _deleteBtnHide = deleteBtnHide;
    _deleteBtn.hidden = deleteBtnHide;
    _goPayView.hidden = !deleteBtnHide;
//    _selectAllBtn.selected = NO;
    
}
@end
