//
//  ALSettingViewController.m
//  iOutletShopping
//
//  Created by Huashen on 14-9-27.
//  Copyright (c) 2014年 aolaigo. All rights reserved.
//

#import "ALSettingViewController.h"
#import "UILabel+ALLabel.h"
#import "JudgeLogin.h"
#import "ALLoginViewController.h"
#import "ALAddressViewController.h"
#import "ALSecurityViewController.h"
#import "ALRemindViewController.h"
#import "ALLoginViewController.h"

extern const int ALCellSectionHeaderH;
const NSUInteger ALBtnViewH = 80;
const NSUInteger ALBtnMargin = 40;

@interface ALSettingViewController ()

@end

@implementation ALSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ALBarButtonItem *homeButton = [ALBarButtonItem BarButtonItemWithPosition:kRightFirstBtnFrame type:barButtonItemTypeHome controller:self.navigationController];
    self.navigationItem.rightBarButtonItem = homeButton;
    
    UILabel *label = [UILabel labelWithTextColor:[UIColor whiteColor] titleText:@"设置" titleFont:@"20" width:20 height:44];
    self.navigationItem.titleView = label;
    
    // 1.第0组：3个 通知设置
    [self add0SectionItems];
    
    // 2.第1组：2个 图片质量设置
//    [self add1SectionItems];
    
    // 2.第2组：6个
    [self add2SectionItems];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //如果登陆，添加退出登陆的按钮
    if ([JudgeLogin shareInstance].login) {
        [self addButton];
    }
}

#pragma mark - 增加退出登录的按钮
-(void)addButton
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, ALBtnViewH)];
    view.backgroundColor = [UIColor clearColor];
    
    UIButton *button = [[UIButton alloc]initWithFrame: CGRectMake(0,0,200, ALBtnViewH-ALBtnMargin)];
    button.center = view.center;
    [button setTitle:@"退出当前账号" forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"NavBar64"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(resignClicked) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    
    self.tableView.tableFooterView = view;

}

#pragma mark - 注销登陆

-(void)resignClicked
{
    ALLog(@"resign clicked");
    //跳转到登陆界面
    ALLoginViewController *loginController = [[ALLoginViewController alloc] init];
    [self.navigationController pushViewController:loginController animated:YES];
    //修改登陆状态
    [JudgeLogin shareInstance].login = NO;
    
}
#pragma mark - 通知设置

-(void)add0SectionItems
{
    Class name = nil;
    
    //1. 如果未登录，则通知设置group的所有UI跳转都到登录页
    if(![JudgeLogin shareInstance].login)
    {
        name = [ALLoginViewController class];
    }
    
    ALSettingArrowItem *info = [ALSettingArrowItem itemWithIcon:@"IDInfo" title:@"收货信息管理"];
    info.showVCClass = name ? name:[ALAddressViewController class];
    
    ALSettingArrowItem *security = [ALSettingArrowItem itemWithIcon:@"IDInfo" title:@"账户安全"];
    security.showVCClass = name ? name:[ALSecurityViewController class];
    
    ALSettingArrowItem *remind = [ALSettingArrowItem itemWithIcon:@"IDInfo" title:@"消息提醒"];
    remind.showVCClass = name ? name:[ALRemindViewController class];
    
    ALSettingGroup *group = [[ALSettingGroup alloc] init];
    group.items = @[info,security,remind];
    group.header = @"通知设置";
    
    [_allGroups addObject:group];
}

#pragma mark - 图片质量设置

-(void)add1SectionItems
{
//    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"高清(适合wifi环境)" ];
//    [str setAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} range:NSMakeRange(0, 5)];
#warning 调整括号里的字体
    ALSettingSwitchItem *clear = [ALSettingSwitchItem itemWithIcon:@"IDInfo" title:@"高清(适合wifi环境)"];
    clear.key = ALSettingHDV;
    
    ALSettingSwitchItem *cut = [ALSettingSwitchItem itemWithIcon:@"IDInfo" title:@"智能切换(非wifi-普通/wifi-高清显示)"];
    cut.key = ALSettingSmartTranslator;
    
    ALSettingGroup *group = [[ALSettingGroup alloc] init];
    group.header = @"图片质量设置";
    group.items = @[clear,cut];
    
    [_allGroups addObject:group];
}

#pragma mark - 服务中心
-(void)add2SectionItems
{
    ALSettingArrowItem *suggestion = [ALSettingArrowItem itemWithIcon:@"IDInfo" title:@"意见反馈"];
    //    item.showVCClass =
    
    ALSettingArrowItem *help = [ALSettingArrowItem itemWithIcon:@"IDInfo" title:@"使用帮助"];
    //    item.showVCClass =
    
    ALSettingArrowItem *version= [ALSettingArrowItem itemWithIcon:@"IDInfo" title:@"当前版本 V1.1.0"];
    version.subtitle = @"123";
    //    item.showVCClass =
    
    ALSettingArrowItem *about = [ALSettingArrowItem itemWithIcon:@"IDInfo" title:@"关于奥莱购"];
    //    item.showVCClass =
    
    ALSettingItem *cache = [ALSettingItem itemWithIcon:@"IDInfo" title:@"清除缓存"];
    cache.operation = ^{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"清除完毕" delegate:nil cancelButtonTitle:@"完成" otherButtonTitles:nil, nil];
        [alert show];
    };
    
    ALSettingGroup *group = [[ALSettingGroup alloc] init];
    group.header = @"服务中心";
    group.items = @[suggestion,help,version,about,cache];
    
    [_allGroups addObject:group];
    
}

@end
