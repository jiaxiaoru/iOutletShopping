//
//  ALTabBarController.m
//  ItcastLottery
//
//  Created by Huashen on 14-9-17.
//  Copyright (c) 2014年 aolaigo. All rights reserved.
//

#import "ALTabBarController.h"
#import "UINavigationItem+AL.h"
#import "ALClassifyViewController.h"
#import "PPRevealSideViewController.h"
static ALTabBarController * _sharedInstance;
const NSInteger kBtnTotalNumber = 5;
@interface ALTabBarController ()
{
    ALTabBarButton *_selectedBtn;
}

@end

@implementation ALTabBarController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void) preloadView {
    ALClassifyViewController *left = [[ALClassifyViewController alloc] init];
    [self.revealSideViewController preloadViewController:left
                                                 forSide:PPRevealSideDirectionLeft
                                              withOffset:0.0];
    //    RightViewController *right = [[[RightViewController alloc] init] autorelease];
    //    [self.revealSideViewController preloadViewController:right
    //                                                 forSide:PPRevealSideDirectionRight
    //                                              withOffset:_offset];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(preloadView) object:nil];
    [self performSelector:@selector(preloadView) withObject:nil afterDelay:0.3];
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        for(UIControl *btn in self.tabBar.subviews)
        {
            [btn removeFromSuperview];
        }
        
        _sharedInstance = self;
        _btnArray = [NSMutableArray array];
        
        self.tabBar.backgroundImage = [UIImage imageNamed:@"TabBarBack"];
        for (int i = 0; i < kBtnTotalNumber; i++) {
            NSString *imageName = [NSString stringWithFormat:@"TabBar%d",i+1];
            NSString *selImageName = [NSString stringWithFormat:@"%@Sel",imageName];
            ALTabBarButton *button = [[ALTabBarButton alloc] initTabBarButtonWithImage:imageName SelectImage:selImageName index:i totalNumber:kBtnTotalNumber];
            
            [button addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchDown];
            if (i == 0) {
                [self clicked:button];
            }
            //tag只用于自控制器跳转到各个父控制器的接口
            button.tag = i;
            [_btnArray addObject:button];
            
            [self.tabBar addSubview:button];
        }

    });
   }

-(void)clicked:(ALTabBarButton *)button
{
    _selectedBtn.selected = NO;
    button.selected = YES;
    _selectedBtn = button;
    
    self.selectedIndex = button.tag;
    [self rewriteTitle];
}

/*
 把各viewcontroller的属性代替父类的navigation的属性
 */
-(void) rewriteTitle
{
    UIViewController *controller = self.viewControllers[self.selectedIndex];
    [self.navigationItem copyFromItem:controller.navigationItem];
}
/*
 单例模式
 */
+(id)sharedInstance
{
    @synchronized ([ALTabBarController class]) {
        if (_sharedInstance == nil) {
            _sharedInstance = [[ALTabBarController alloc] init];
        }
    }
    return _sharedInstance;
}
@end
