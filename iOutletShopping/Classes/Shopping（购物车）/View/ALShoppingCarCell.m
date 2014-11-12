//
//  ALShoppingCarCell.m
//  iOutletShopping
//
//  Created by Huashen on 14/10/23.
//  Copyright (c) 2014年 aolaigo. All rights reserved.
//

#import "ALShoppingCarCell.h"
#define kViewFrame CGRectMake(0, 0, 320, 30)

@interface ALShoppingCarCell()<UITextFieldDelegate,UIAlertViewDelegate>
{
    //用于输入取消的时候恢复到原来的数字
    NSString *_preNumber;
}

@property (weak, nonatomic) IBOutlet UIButton *selectedBtn;
@property (weak, nonatomic) IBOutlet UIImageView *shoppingImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *unitPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *preUnitPrice;
@property (weak, nonatomic) IBOutlet UITextField *numberText;
@property (weak, nonatomic) IBOutlet UILabel *describeLabel;
@property (weak, nonatomic) IBOutlet UILabel *totallyLabel;
@property (weak, nonatomic) IBOutlet UIButton *favourtiteBtn;

@property (weak, nonatomic) IBOutlet UIView *mainView;
//加减和中间的textfield视图
@property (weak, nonatomic) IBOutlet UIView *minAddView;
//编辑UI的商品数量视图
@property (weak, nonatomic) IBOutlet UIView *countShowView;
@property (weak, nonatomic) IBOutlet UILabel *countLabelEdit;


//键盘的inputview
@property (weak, nonatomic) IBOutlet UIView *keyboardHideView;
- (IBAction)cancelClicked:(UIButton *)sender;
- (IBAction)doneClicked:(id)sender;

- (IBAction)selectedClicked:(UIButton *)sender;

@end
@implementation ALShoppingCarCell

#pragma mark - 初始化

+(instancetype)shoppingCarCell
{
    ALShoppingCarCell *cell = [[NSBundle mainBundle] loadNibNamed:@"ALShoppingCarCell" owner:nil options:nil][0];
    //在xib中指定delegate会导致程序崩溃，对象不明确
    cell.numberText.delegate = cell;
    cell.numberText.inputAccessoryView = cell.keyboardHideView;
    
    return cell;
}

#pragma mark - 模型赋值View

-(void)setShoppingCarItem:(ALShoppingCarItem *)shoppingCarItem
{
    //1. 正常赋值
    _shoppingCarItem = shoppingCarItem;
    if (_selectedBtn.hidden) {
        ALLog(@"%d",shoppingCarItem.selected);
        _favourtiteBtn.selected = shoppingCarItem.selected;
    }
    else{
        _selectedBtn.selected = shoppingCarItem.selected;
        _favourtiteBtn.selected = shoppingCarItem.favourite;
    }
    _shoppingImageView.image = [UIImage imageNamed: shoppingCarItem.imageUrlStr];
    _titleLabel.text = shoppingCarItem.title;
    _unitPriceLabel.text = shoppingCarItem.unitPrice;
    _preUnitPrice.text = shoppingCarItem.preUnitPrice;
    _describeLabel.text = shoppingCarItem.describe;
    
    _numberText.text = shoppingCarItem.number;
    _preNumber = _numberText.text;
    _countLabelEdit.text = shoppingCarItem.number;
    
    _totallyLabel.text = shoppingCarItem.totally;
    //2. 根据优惠/赠的数据添加View
    [self adjustUIWithPri:shoppingCarItem.privilege pre:shoppingCarItem.present];
    
}
#pragma mark - 添加优惠和赠view

-(void)adjustUIWithPri:(NSString *)privilege pre:(NSString *)present
{
    CGFloat privilegateH = 0;
    //1. 根据取到的数据添加三个view到cell中去
    if (privilege.length) {
        
        //把优惠view添加到cell中去
        UIView *privilegeView = [self addViewsWithStr:@"优惠" labelText:privilege];
        ALLog(@"%@",NSStringFromCGRect(privilegeView.frame));
        privilegeView.tag = 100;
        [self addSubview:privilegeView];
        
        privilegateH += privilegeView.frame.size.height;
    }
    if (present.length) {
        
        UIView *presentView = [self addViewsWithStr:@"赠  " labelText:present];
        //tag用于tableview复用的时候用
        presentView.tag = 101;
        //计算坐标
        CGRect frame = presentView.frame;
        frame.origin.y += privilegateH;
        presentView.frame = frame;
        
        //把赠送view添加到cell中去
        [self addSubview:presentView];
        
    }

}

//创建一个大众view

-(UIView *)addViewsWithStr:(NSString *)title labelText:(NSString *)labelText
{
    UIView *view = [[UIView alloc] initWithFrame:kViewFrame];
    //1. 添加优惠button
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(8, 0, 30, 30)];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:12];
    //2. 添加优惠信息的label
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(43, 0, 269, 30)];
    label.text = labelText;
    label.font = [UIFont systemFontOfSize:12];
    
    [view addSubview:button];
    [view addSubview:label];

    return view;
}

+(NSString *)ID
{
    return @"shoppingCarCell";
}

//返回没有优惠和赠view的高度
+(CGFloat) heightNormal
{
    return 100;
}
//返回有优惠或赠view的高度
+(CGFloat) heightWithPrivilege
{
    return 130;
}

//返回既有优惠又有赠view的高度
+(CGFloat) heightWithAll
{
    return 160;
}

#pragma mark - 取消键盘的操作

//键盘点击取消，恢复原来的number，再隐藏键盘
- (IBAction)cancelClicked:(UIButton *)sender {
    ALLog(@"cancel clicked");
    self.numberText.text = _preNumber;
    [self endEditing:YES];
}

//键盘点击确定，隐藏键盘,获取最新number，检查合法性，
- (IBAction)doneClicked:(id)sender {
    ALLog(@"done clicked");
    [self endEditing:YES];
    
    NSString *number = self.numberText.text;
    //如果number没改变就不需要做任何动作
    if ([number intValue] == [_preNumber intValue]) {
        return;
    }
    _preNumber = number;
    if ([number intValue]> 200 || [number intValue]< 1) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"商品数量不能小于1 大于200！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        alert.tag = 10;
        [alert show];
    }
    //数据合法，通过代理更改数据模型，并上传服务器
    else{
        if (_delegate && [_delegate respondsToSelector:@selector(shoppingCarCell:tag:supTag:number:countAndPrice:)]) {
            [_delegate shoppingCarCell:self tag:5 supTag:self.tag number:_preNumber countAndPrice:^(NSString *smallTotally) {
                ALLog(@"%@",smallTotally);
                _totallyLabel.text = smallTotally;
                
            }];
        }
    }
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 10) {
        [self.numberText becomeFirstResponder];
    }
}

#pragma mark - 选择/收藏/加减按钮点击事件的处理

- (IBAction)selectedClicked:(UIButton *)sender {
    ALLog(@"selected clicked");
    
    [self endEditing:YES];
    
    NSInteger tag = sender.tag;
    //先修改视图
    if (tag == 1 || tag == 2) {
        sender.selected = !sender.selected;
    }
    else if (tag == 3 || tag == 4){
        int number = [_numberText.text intValue];
        tag == 3 ?number--:number++;
        number = number == 0 ? 1:number;
        number = number == 201 ? 200:number;
        _numberText.text = [NSString stringWithFormat:@"%d",number];
        _preNumber = _numberText.text;
    }
    //再通过代理去修改数据模型
    if (_delegate && [_delegate respondsToSelector:@selector(shoppingCarCell:tag:supTag:number:countAndPrice:)]) {
        [_delegate shoppingCarCell:self tag:tag supTag:self.tag number:_numberText.text countAndPrice:^(NSString *smallTotally) {
            ALLog(@"%@",smallTotally);
            _totallyLabel.text = smallTotally;
        }];
    }
}

#pragma mark - 去结算/删除视图的切换
-(void)changeUIToEdit:(BOOL)edit
{
    self.selectedBtn.hidden = edit;
    self.minAddView.hidden = edit;
    self.countShowView.hidden = !edit;
    NSString *imageName = edit ? @"nohookselected":@"heart";
    NSString *selectImageName = edit ? @"selectedhook":@"blackheart";
    
    //编辑状态，收藏按钮（tag == 2）变成选择按钮（tag == 1），去结算状态收藏按钮的tag是2
    self.favourtiteBtn.tag = edit ?  self.selectedBtn.tag:2;
    [self.favourtiteBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [self.favourtiteBtn setImage:[UIImage imageNamed:selectImageName] forState:UIControlStateSelected];
}
@end
