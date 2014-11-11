//
//  ALSettingCell.m
//  iOutletShopping
//
//  Created by Huashen on 14-9-27.
//  Copyright (c) 2014年 aolaigo. All rights reserved.
//

#import "ALSettingCell.h"
#import "ALSettingItem.h"
#import "ALSettingSwitchItem.h"
#import "ALSettingArrowItem.h"
#import "ALSettingLabelItem.h"
#import "ALSettingButtonItem.h"

const int ALCellMargin = 10;

@interface ALSettingCell()
{
    UIImageView *_arrow;
    UISwitch *_switch;
    UIButton *_button;
    UILabel *_label;
    
//    UIView *_divider;
}
@end

@implementation ALSettingCell

+ (instancetype)settingCellWithTableView:(UITableView *)tableView
{
    // 0.用static修饰的局部变量，只会初始化一次
    static NSString *ID = @"Cell";
    
    // 1.拿到一个标识先去缓存池中查找对应的Cell
    ALSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    // 2.如果缓存池中没有，才需要传入一个标识创建新的Cell
    if (cell == nil) {
        cell = [[ALSettingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    return cell;
}

//- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
//{
//    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
//    if (self) {
//        // 1.设置背景
//        [self setupBg];
//        
//        // 2.设置子控件属性
//        [self setupSubviews];
//        
//        // 3.添加分隔线
//        [self setupDivider];
//    }
//    return self;
//}

#pragma mark 添加分隔线
//- (void)setupDivider
//{
//    UIView *divider = [[UIView alloc] init];
//    divider.backgroundColor = kColor(200, 200, 200);
//    // 不能在这里设置分隔线的x值（原因：cell没有具体的数据，里面的label就不知道最终的位置）
//    //    divider.frame = CGRectMake(0, 0, self.contentView.frame.size.width, 1.5);
//    [self.contentView addSubview:divider];
//    _divider = divider;
//}

//- (void)setIndexPath:(NSIndexPath *)indexPath
//{
//    _indexPath = indexPath;
//    
//    _divider.hidden = indexPath.row == 0;
//}

#pragma mark 设置子控件属性
- (void)setupSubviews
{
    self.textLabel.backgroundColor = [UIColor clearColor];
    self.textLabel.font = [UIFont systemFontOfSize:14];
    
    self.detailTextLabel.backgroundColor = [UIColor clearColor];
    self.detailTextLabel.font = [UIFont systemFontOfSize:12];
}

#pragma mark 设置背景
- (void)setupBg
{
    // 1.默认
    UIView *bg = [[UIView alloc] init];
    bg.backgroundColor = [UIColor whiteColor];
    self.backgroundView = bg;
    
    // 2.选中
    UIView *selectedBg = [[UIView alloc] init];
    selectedBg.backgroundColor = kColor(237, 233, 218);
    self.selectedBackgroundView = selectedBg;
}

- (void)setItem:(ALSettingItem *)item
{
    _item = item;
    
    // 设置数据
    self.imageView.image = [UIImage imageNamed:item.icon];
    self.textLabel.text = item.title;
    self.detailTextLabel.text = item.subtitle;
    
    if ([item isKindOfClass:[ALSettingArrowItem class]]) {
        ALSettingArrowItem *arrowItem = (ALSettingArrowItem *)item;
        [self settingArrowWithImage:arrowItem.imageName];
    } else if ([item isKindOfClass:[ALSettingButtonItem class]]){
        [self settingButton];
    }else if ([item isKindOfClass:[ALSettingSwitchItem class]]) {
        [self settingSwitch];
    } else if ([item isKindOfClass:[ALSettingLabelItem class]]) {
        [self settingLabel];
    }else {
        // 什么也没有，清空右边显示的view
        self.accessoryView = nil;
        // 用默认的选中样式
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
    }
}

#pragma mark 当cell的宽高改变了就会调用
// 需要调节cell内部子控件的frame，在layoutSubviews方法最可靠\最有效
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 0.设置分隔线的位置
//    _divider.frame = CGRectMake(self.textLabel.frame.origin.x, 0, self.contentView.frame.size.width + 100, 1.2);
    
    return;
    
//    // 1.cell的frame
//    CGRect cellF = self.frame;
//    cellF.origin.x = -ALCellMargin;
//    CGFloat deltaW = ALCellMargin * 2;
//    cellF.size.width = [UIScreen mainScreen].bounds.size.width + deltaW;
//    self.frame = cellF;
//    
//    // 2.右边控件的frame
//    CGRect accessF = self.accessoryView.frame;
//    accessF.origin.x = cellF.size.width - accessF.size.width - deltaW;
//    self.accessoryView.frame = accessF;
}

#pragma mark 设置右边的文本标签
- (void)settingLabel
{
    if (_label == nil) {
        _label = [[UILabel alloc] init];
        _label.bounds = CGRectMake(0, 0, 100, self.frame.size.height);
        _label.textAlignment = NSTextAlignmentRight;
        _label.backgroundColor = [UIColor clearColor];
        _label.textColor = kColor(173, 69, 14);
        _label.font = [UIFont systemFontOfSize:13];
    }
    
    // 设置右边label的值
    ALSettingLabelItem *labelItem = (ALSettingLabelItem *)_item;
    _label.text = labelItem.text;
    
    // 右边显示开关
    self.accessoryView = _label;
    // 禁止选中
    self.selectionStyle = UITableViewCellSelectionStyleDefault;
}

#pragma mark 设置右边的开关
- (void)settingSwitch
{
    if (_switch == nil) {
        _switch = [[UISwitch alloc] init];
        [_switch addTarget:self action:@selector(switchChange) forControlEvents:UIControlEventValueChanged];
    }
    
    // 设置开关的状态
    ALSettingSwitchItem *switchItem = (ALSettingSwitchItem *)_item;
    _switch.on = !switchItem.off;
    
    // 右边显示开关
    self.accessoryView = _switch;
    // 禁止选中
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

#pragma mark 开关状态改变
- (void)switchChange
{
    ALSettingSwitchItem *switchItem = (ALSettingSwitchItem *)_item;
    switchItem.off = !_switch.on;
}

#pragma mark 设置右边的箭头
- (void)settingArrowWithImage:(NSString *)imageName
{
    if (imageName != nil) {
        if (_arrow == nil) {
            _arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        }
        
        // 右边显示箭头
        self.accessoryView = _arrow;
    }
    else
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    // 用默认的选中样式
    self.selectionStyle = UITableViewCellSelectionStyleDefault;
}

#pragma mark 设置右边的按钮
-(void)settingButton
{
    ALSettingButtonItem *buttonItem = (ALSettingButtonItem *)_item;
    
    if (_button == nil) {
        _button = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth-40, 0, 30, 30)];
        [_button setImage:[UIImage imageNamed:buttonItem.normalImageName] forState:UIControlStateNormal];
        [_button setImage:[UIImage imageNamed:buttonItem.selectedImageName] forState:UIControlStateSelected];
        
        [_button addTarget:self action:@selector(buttonChange) forControlEvents:UIControlEventTouchUpInside];
    }
    
    // 设置开关的状态
    _button.selected = !buttonItem.off;
    
    // 右边显示开关
    self.accessoryView = _button;
    // 禁止选中
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
}

#pragma mark 按钮状态改变
-(void)buttonChange
{
    ALSettingButtonItem *buttonItem = (ALSettingButtonItem *)_item;
    buttonItem.off = !_button.selected;
    _button.selected = buttonItem.off;
}
@end
