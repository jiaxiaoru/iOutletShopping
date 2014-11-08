//
//  ALHomeViewController.m
//  iOutletShopping
//
//  Created by Huashen on 14-9-25.
//  Copyright (c) 2014年 aolaigo. All rights reserved.
//

#import "ALHomeViewController.h"
#import "JudgeLogin.h"
#import "ALDropDown.h"
#import "ALSettingViewController.h"
#import "ALLoginViewController.h"
#import "ALClassifyViewController.h"
#import "PPRevealSideViewController.h"
#import "WebViewJavascriptBridge.h"

@interface ALHomeViewController ()<ALDropDownDelegate,UIWebViewDelegate>
{
    ALDropDown *_dropDown;
    ALDropDown *_titleDropDown;
    NSArray *_operations;
    BOOL _isVCBasedStatusBarAppearance;
}
@property WebViewJavascriptBridge* bridge;
@end

@implementation ALHomeViewController

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    //改变下一个界面的返回键的颜色
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self setUp];
    ALLog(@"12341241");
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    if (_bridge) { return; }
    
    //启用日志记录
//    [WebViewJavascriptBridge enableLogging];
    
    //实例化WebViewJavascriptBridge并定义native端的默认消息处理器
    
//    _bridge = [WebViewJavascriptBridge bridgeForWebView:_webView webViewDelegate:self handler:^(id data, WVJBResponseCallback responseCallback) {
//        NSLog(@"ObjC received message from JS: %@", data);
//        responseCallback(@"Response for message from ObjC");
//    }];
//    //注册一个供UI端调用的名为testObjcCallback的处理器，并定义用于响应的处理逻辑
//    [_bridge registerHandler:@"testObjcCallback" handler:^(id data, WVJBResponseCallback responseCallback) {
//        NSLog(@"testObjcCallback called: %@", data);
//        responseCallback(@"Response from testObjcCallback");
//    }];
    //发送一条消息给UI端并定义回调处理逻辑
//    [_bridge send:@"A string sent from ObjC before Webview has loaded." responseCallback:^(id responseData) {
//        NSLog(@"objc got response! %@", responseData);
//    }];
    //调用一个在UI端定义的名为testJavascriptHandler的处理器，没有定义回调
//    [_bridge callHandler:@"testJavascriptHandler" data:@{ @"foo":@"before ready" }];
    
//    [self renderButtons:_webView];
//    [self loadExamplePage:_webView];
    //单纯发送一条消息给UI端
//    [_bridge send:@"A string sent from ObjC after Webview has loaded."];

}
-(void)viewWillDisappear:(BOOL)animated
{
    _dropDown.hiden ? nil:[_dropDown hideTable];
    _titleDropDown.hiden ? nil:[_titleDropDown hideTable];
}
-(void)setUp
{
    //0. 添加标题按钮
    UIButton *titleBtn = [[UIButton alloc] initWithFrame:CGRectMake(110, 10, 100, 44)];
    [titleBtn setTitle:@"奥莱购" forState:UIControlStateNormal];
    [titleBtn addTarget:self action:@selector(showTitleDropList:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleBtn;
    
    //1. 添加扫一扫按钮
    UIButton *scanBtn = [[UIButton alloc] initWithFrame:kRightFirstBtnFrame];
    [scanBtn addTarget:self action:@selector(showScanDropList:) forControlEvents:UIControlEventTouchUpInside];
    [scanBtn setImage:[UIImage imageNamed:@"TabBar2"] forState:UIControlStateNormal];
    UIBarButtonItem *scanButtonItem = [[UIBarButtonItem alloc] initWithCustomView:scanBtn];
    
    //2. 添加搜索按钮
    ALBarButtonItem *searchButtonItem =[ALBarButtonItem BarButtonItemWithPosition:kRightSecondBtnFrame type:barButtonItemTypeSearch controller:self.navigationController];
    self.navigationItem.rightBarButtonItems =  @[scanButtonItem,searchButtonItem];
    //3.添加分类按钮
    UIButton *classifyBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 24, 24)];
    [classifyBtn addTarget:self action:@selector(showClassify) forControlEvents:UIControlEventTouchUpInside];
    [classifyBtn setImage:[UIImage imageNamed:@"TabBar2"] forState:UIControlStateNormal];
    UIBarButtonItem *classifyButtonItem = [[UIBarButtonItem alloc] initWithCustomView:classifyBtn];
    self.navigationItem.leftBarButtonItem = classifyButtonItem;
    
    //4.调用web显示首页内容
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://192.168.115.161:9000"]];
    [_webView loadRequest:request];
}

#pragma mark - 获取扫描下拉菜单的标题

-(NSArray *)getScanPullDownTitles
{
    NSMutableArray *tempArr = [NSMutableArray arrayWithObjects:@"扫一扫",@"设置", nil];
    NSMutableArray *opArr = [NSMutableArray arrayWithObjects:@"ALSweepQRViewController",@"ALSettingViewController",nil];
    //1. 登陆了，显示退出登陆操作
    if ([JudgeLogin shareInstance].login) {
        [tempArr addObject:@"退出登陆"];
        [opArr addObject:@""];
    }
    //2. 未登录，显示登陆操作
    else{
        [tempArr addObject:@"登陆"];
        [opArr addObject:@"ALLoginViewController"];
    }
    _operations = [NSArray arrayWithArray:opArr];
    return tempArr;
}
#pragma mark - 获取扫描下拉菜单的标题

-(NSArray *)getTitlePullDownTitles
{
    NSMutableArray *tempArr = [NSMutableArray arrayWithObjects:@"女装",@"男装",@"运动户外",@"箱包鞋靴",@"美妆生活",@"名品荟", nil];
    NSMutableArray *opArr = [NSMutableArray arrayWithObjects:@"ALSweepQRViewController",@"ALSettingViewController",nil];
    _operations = [NSArray arrayWithArray:opArr];
    return tempArr;
}

#pragma mark - 显示扫描下拉内容

-(void)showScanDropList:(UIButton *)sender
{
    CGFloat width = 80;
    //1. 如果扫描列表存在并显示出来了，先隐藏
    if (_titleDropDown != nil && !_titleDropDown.hiden) {
        [_titleDropDown hideTable];
    }
    if (_dropDown == nil) {
        _dropDown = [[ALDropDown alloc] initWithPosition:ALDropDownPositionRight withBtn:sender width:width data:[self getScanPullDownTitles] onNavigationBar:YES];
        _dropDown.delegate = self;
        _dropDown.alphaValue = 0.6;
    }
    _dropDown.hiden ? [_dropDown showTable]:[_dropDown hideTable];
}
#pragma mark - 显示标题下拉内容
-(void)showTitleDropList:(UIButton *)sender
{
    CGFloat width = 100;
    //1. 如果扫描列表存在并显示出来了，先隐藏
    if (_dropDown != nil && !_dropDown.hiden) {
        [_dropDown hideTable];
    }
    if (_titleDropDown == nil) {
        _titleDropDown = [[ALDropDown alloc] initWithPosition:ALDropDownPositionDefault withBtn:sender width:width data:[self getTitlePullDownTitles] onNavigationBar:NO];
        _titleDropDown.delegate = self;
        _titleDropDown.alphaValue = 0.6;
    }
    _titleDropDown.hiden ? [_titleDropDown showTable]:[_titleDropDown hideTable];
}
#pragma mark - 显示分类页面
-(void)showClassify
{
    ALLog(@"clicked classify button");
    ALClassifyViewController *classifyViewController = [[ALClassifyViewController alloc] init];
    [self.revealSideViewController pushViewController:classifyViewController onDirection:PPRevealSideDirectionLeft withOffset:0.0 animated:YES completion:^{
        PPRSLog(@"This is the end!");
    }];
    PP_RELEASE(classifyViewController);
//    [ALJumpToAnotherUI jumpToAnotherUI:@"ALClassifyViewController" withNavCtrl:self.navigationController];
}


#pragma mark - 实现ALDropDownDelegate的代理方法

-(void)dropDownDelegate:(ALDropDown *)object selected:(NSInteger)index
{
    NSString *classNameStr =  _operations[index];
    if (classNameStr.length) {
        [ALJumpToAnotherUI jumpToAnotherUI:classNameStr withNavCtrl:self.navigationController];
    }
    else{
#warning 加入第三方加载功能，显示“登陆已退出”，停留三秒左右
    }

}
-(void)bingo
{
    ALLoginViewController *view = [[ALLoginViewController alloc] init];
    [self.navigationController pushViewController:view animated:YES];
}
-(void)done
{
    ALLog(@"done invoke!");
}
#pragma mark - 实现UIWebView代理方法


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
//    if (webView != _webView) { return YES; }
//    
//    NSURL *url = [request URL];
//    
//    if ([[url scheme] isEqualToString:@"CUSTOM_PROTOCOL_SCHEME"]) {
//        
//        //队列中有数据
//        
//        if ([[url host] isEqualToString:@"QUEUE_HAS_MESSAGE"]) {
//            
//            //刷出队列中数据
//            
////            [self _flushMessageQueue];
//            
//        } else {
//            
////            NSLog(@"WebViewJavascriptBridge: WARNING: Received unknown WebViewJavascriptBridge command %@://%@", CUSTOM_PROTOCOL_SCHEME, [url path]);
//            
//        }
//        
//        return NO;
//        
//    } else if (self.webViewDelegate) {
//        
//        return [self.webViewDelegate webView:webView shouldStartLoadWithRequest:request navigationType:navigationType];
//        
//    } else {
    
        return YES;
        
}

@end
