//
//  JudgeLogin.m
//  iOutletShopping
//
//  Created by Huashen on 14-9-27.
//  Copyright (c) 2014年 aolaigo. All rights reserved.
//

#import "JudgeLogin.h"

@implementation JudgeLogin
static JudgeLogin *_judgeLogin;

#pragma mark - 单例模式
+(instancetype)shareInstance
{
    if (_judgeLogin == nil) {
        _judgeLogin = [[JudgeLogin alloc] init];
#warning 暂时让其处于登陆状态
        _judgeLogin.login = YES;
    }
    return _judgeLogin;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
#warning 判断登陆文件是否存在
        //这里判断一下登陆文件是否存在
        //1. 如果存在
//        self.login = true;
        //2. 如果不存在,
        self.login = false;
    }
    return self;
}
@end
