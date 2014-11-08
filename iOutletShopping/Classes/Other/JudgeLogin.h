//
//  JudgeLogin.h
//  iOutletShopping
//
//  Created by Huashen on 14-9-27.
//  Copyright (c) 2014年 aolaigo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JudgeLogin : UIView

@property (nonatomic,assign) BOOL login;
@property (nonatomic,weak) JudgeLogin *judgeLogin;

+(instancetype)shareInstance;
@end
