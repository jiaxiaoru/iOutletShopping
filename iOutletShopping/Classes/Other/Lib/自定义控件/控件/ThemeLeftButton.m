//
//  ThemeLeftButton.m
//  YBossWeibo
//
//  Created by wxhl_zy104 on 14-9-27.
//  Copyright (c) 2014年 wxhl_zy104. All rights reserved.
//

#import "ThemeLeftButton.h"

@implementation ThemeLeftButton

//自定义初始化方法
- (instancetype)initWithTitle:(NSString *)title
                    ImageName:(NSString *)imageName
                  BgImageName:(NSString *)bgImageName
                        frame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //初始化属性
        self.title = title;
        self.imageName = imageName;
        self.bgImageName = bgImageName;
        //初始化子视图
        [self _loadViews];
        
    }
    return self;
}

//初始化子视图
- (void)_loadViews{
    //1.创建背景图片
    if (_bgImageView == nil) {
        _bgImageView = [[UIImageView alloc]initWithFrame:self.bounds];
        [self addSubview:_bgImageView];
    }
    //设置图片
    UIImage *bgImage = [UIImage imageNamed:self.bgImageName];
   // bgImage = [bgImage stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    _bgImageView.image = bgImage;
    
    //2.标题图片
    if (_titleImageView == nil) {
        _titleImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, (self.height - 24)/2.0, 16, 24)];
        [self addSubview:_titleImageView];
    }
    //设置图片
    UIImage *titleImage = [UIImage imageNamed:self.imageName];
    _titleImageView.image = titleImage;
    
    //3.设置标题文本
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_titleImageView.right +10, (self.height - 30)/2.0, 100, 30)];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont boldSystemFontOfSize:17];
        _titleLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:_titleLabel];
    }
    
    _titleLabel.text = self.title;
}

- (void)setImageName:(NSString *)imageName{
   _imageName = [imageName copy];
    
}

@end
