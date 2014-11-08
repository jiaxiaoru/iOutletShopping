//
//  ALGoPayViewController.h
//  iOutletShopping
//
//  Created by Huashen on 14/11/4.
//  Copyright (c) 2014年 aolaigo. All rights reserved.
//

#import <UIKit/UIKit.h>

//typedef void(^ALTotallyPrice)(NSString *totally);

@class ALGoPayViewController;
@protocol ALGoPayViewControllerDelegate <NSObject>

@optional

/**
 *  给ALShoppingCarViewController发送代理，让其对tableview进行修改
 *
 *  @param controller 知道是谁发的delegate
 *  @param button     全选/去结算按钮，根据tag进行判断，全选就修改tableview所有的           选择按钮，如果是去结算，跳到去结算页面
 */
-(void)goPay:(ALGoPayViewController *)controller button:(UIButton *)button;
@end

@interface ALGoPayViewController : UIViewController

@property (nonatomic,weak) id <ALGoPayViewControllerDelegate> delegate;
//隐藏删除，显示去结算view
@property (nonatomic,assign) BOOL deleteBtnHide;
/**
 *  设置总金额
 *
 *  @param string 跟文字组合后的总金额字符串 （9200.50 (共5件)）
 */
-(void)totallyStr:(NSString *)string;
@end
