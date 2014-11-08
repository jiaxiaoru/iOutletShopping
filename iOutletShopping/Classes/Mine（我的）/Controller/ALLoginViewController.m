//
//  ALLoginViewController.m
//  iOutletShopping
//
//  Created by Huashen on 14-9-29.
//  Copyright (c) 2014年 aolaigo. All rights reserved.
//

#import "ALLoginViewController.h"

@interface ALLoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *account;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *autoLoginBtn;
@end

@implementation ALLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)listAccounts:(UIButton *)sender {
    sender.selected = !sender.selected;
#warning 从数据库去取近半年内最近的登陆的账号
    
}
- (IBAction)registerNewAccount:(UIButton *)sender {
#warning 跳到注册界面
}

- (IBAction)login:(UIButton *)sender {
}

- (IBAction)forgetPassword:(UIButton *)sender {
#warning 跳到忘记密码界面
}


- (IBAction)theThirdLogin:(UIButton *)sender {
    ALLog(@"跳到第三方登陆界面");
    switch (sender.tag) {
        case 1:  //QQ登陆
#warning 调用QQ SDK跳到QQ登陆界面
            break;
        case 2: //支付宝登陆
#warning 调用支付宝 SDK跳到支付宝登陆界面
            break;
        case 3: //新浪微博登陆
#warning 调用新浪微博 SDK跳到新浪微博登陆界面
            break;
        default:
            break;
    }
}

@end
