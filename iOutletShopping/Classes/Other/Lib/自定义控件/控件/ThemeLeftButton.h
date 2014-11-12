//
//  ThemeLeftButton.h
//  YBossWeibo
//
//  Created by wxhl_zy104 on 14-9-27.
//  Copyright (c) 2014年 wxhl_zy104. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThemeLeftButton : UIControl
{
    UIImageView *_bgImageView;
//    UIImageView *_titleImageView;
    UILabel *_titleLabel;

}
@property (nonatomic,copy)UIImageView *titleImageView;
@property(nonatomic,copy)NSString *imageName;
@property(nonatomic,copy)NSString *bgImageName;
@property(nonatomic,copy)NSString *title;

//自定义初始化方法
- (instancetype)initWithTitle:(NSString *)title
                    ImageName:(NSString *)imageName
                  BgImageName:(NSString *)bgImageName
                        frame:(CGRect)frame;
@end
