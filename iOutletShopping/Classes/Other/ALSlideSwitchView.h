//
//  ALSlideSwitchView.h
//  iOutletShopping
//
//  Created by Huashen on 14/10/29.
//  Copyright (c) 2014年 aolaigo. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol  ALSlideSwitchViewDelegate;

@interface ALSlideSwitchView : UIView

//正常时tab的背景
@property (nonatomic,strong) UIImage *tabItemNormalBackgroundImage;
//选中时tab的背景
@property (nonatomic,strong) UIImage *tabItemSelectedBackgroundImage;

@property (nonatomic,strong) UIImageView *shadowImageView;
@property (nonatomic,strong) UIImage *shadowImage;

//正常时tab文字颜色
@property (nonatomic,strong) UIColor *tabItemNormalColor;
//选中时tab文字颜色
@property (nonatomic,strong) UIColor *tabItemSelectedColor;
//右侧按钮
@property (nonatomic,strong) UIButton *rigthSideButton;

@property (nonatomic,weak)id <ALSlideSwitchViewDelegate> delegate;
/*!
 * @method 创建子视图UI
 * @abstract
 * @discussion
 * @param 固定按钮的宽度
 * @result
 */
- (void)buildUIFix:(BOOL)fix;

/*!
 * @method 通过16进制计算颜色
 * @abstract
 * @discussion
 * @param 16机制
 * @result 颜色对象
 */
+ (UIColor *)colorFromHexRGB:(NSString *)inColorString;

@end

@protocol ALSlideSwitchViewDelegate <NSObject>

@required

/*!
 * @method 顶部tab个数
 * @abstract
 * @discussion
 * @param 本控件
 * @result tab个数
 */
- (NSUInteger)numberOfTab:(ALSlideSwitchView *)view;

/*!
 * @method 每个tab所属的viewController
 * @abstract
 * @discussion
 * @param tab索引
 * @result viewController
 */
- (UIViewController *)slideSwitchView:(ALSlideSwitchView *)view viewOfTab:(NSUInteger)number;

@optional

/*!
 * @method 滑动左边界时传递手势
 * @abstract
 * @discussion
 * @param   手势
 * @result
 */
- (void)slideSwitchView:(ALSlideSwitchView *)view panLeftEdge:(UIPanGestureRecognizer*) panParam;

/*!
 * @method 滑动右边界时传递手势
 * @abstract
 * @discussion
 * @param   手势
 * @result
 */
- (void)slideSwitchView:(ALSlideSwitchView *)view panRightEdge:(UIPanGestureRecognizer*) panParam;

/*!
 * @method 点击tab
 * @abstract
 * @discussion
 * @param tab索引
 * @result
 */
- (void)slideSwitchView:(ALSlideSwitchView *)view didselectTab:(NSUInteger)number;

@end

