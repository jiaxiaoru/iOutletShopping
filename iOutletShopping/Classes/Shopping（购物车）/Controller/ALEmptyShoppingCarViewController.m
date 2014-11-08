//
//  ALEmptyShoppingCarViewController.m
//  iOutletShopping
//
//  Created by Huashen on 14/11/5.
//  Copyright (c) 2014年 aolaigo. All rights reserved.
//

#import "ALEmptyShoppingCarViewController.h"

@interface ALEmptyShoppingCarViewController ()
@property (weak, nonatomic) IBOutlet UIView *loginView;
@property (weak, nonatomic) IBOutlet UIView *hangView;

- (IBAction)loginBtnClicked:(UIButton *)sender;
- (IBAction)hangBtnClicked:(UIButton *)sender;

@end

@implementation ALEmptyShoppingCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    BOOL login = [JudgeLogin shareInstance].login;
    //    self.loginView.hidden = login;
    if (login) {
        CGRect frame = self.hangView.frame;
        
        frame.origin.y = 10;
        self.hangView.frame = frame;
        ALLog(@"%@",NSStringFromCGRect(frame));
        
    }
    else{
        self.loginView.frame = CGRectMake(0, 10, self.view.frame.size.width, 50);
        self.hangView.frame = CGRectMake(0, self.loginView.frame.size.height+10, self.view.frame.size.width, self.view.frame.size.height-self.loginView.frame.size.height-10);
    }
}


- (IBAction)loginBtnClicked:(id)sender {
    ALLog(@"登录按钮点击了");
    
}

- (IBAction)hangBtnClicked:(id)sender {
    ALLog(@"马上逛逛按钮点击了");
    ALLog(@"%@",NSStringFromCGRect(self.hangView.frame));
}
@end
