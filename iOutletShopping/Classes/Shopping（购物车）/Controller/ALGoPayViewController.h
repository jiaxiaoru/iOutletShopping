//
//  ALGoPayViewController.h
//  iOutletShopping
//
//  Created by Huashen on 14/11/4.
//  Copyright (c) 2014年 aolaigo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    ALGoPayViewDefaultType,
    ALGoPayViewDeleteType,
    ALGoPayViewCommitType
}ALGoPayViewType;

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
////yes：显示去结算的UI，隐藏删除和提交订单的UI no则反之
//@property (nonatomic,assign) BOOL showGoPayView;
//
////yes：显示删除的UI，隐藏去结算和提交订单的UI no则反之
//@property (nonatomic,assign) BOOL showDeleteView;
//
////yes：显示提交订单的UI，隐藏删除和去结算的UI no则反之
//@property (nonatomic,assign) BOOL showCommitOrderView;

//隐藏删除，显示去结算view
@property (nonatomic,assign) BOOL deleteBtnHide;
@property (assign,nonatomic) ALGoPayViewType type;
/**
 *  设置总金额
 *
 *  @param string 跟文字组合后的总金额字符串 （9200.50 (共5件)）
 */
-(void)totallyStr:(NSString *)string;
@end
