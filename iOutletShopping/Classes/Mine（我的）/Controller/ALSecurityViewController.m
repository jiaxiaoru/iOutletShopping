//
//  ALSecurityViewController.m
//  iOutletShopping
//
//  Created by Huashen on 14-9-29.
//  Copyright (c) 2014年 aolaigo. All rights reserved.
//

#import "ALSecurityViewController.h"
#import "ALSecurityCell.h"
@interface ALSecurityViewController ()

@end

@implementation ALSecurityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self add0Section];
}

-(void)add0Section
{
    ALSettingArrowItem *password = [ALSettingArrowItem itemWithTitle:@"修改登陆密码"];
//    password.showVCClass =
    
    ALSettingArrowItem *number = [ALSettingArrowItem itemWithTitle:@"修改手机号码"];
//    number.showVCClass =
    
    ALSettingArrowItem *email = [ALSettingArrowItem itemWithTitle:@"绑定邮箱"];
//    email.showVCClass =
    
    ALSettingGroup *group = [[ALSettingGroup alloc] init];
    group.items = @[password,number,email];
    
    [_allGroups addObject:group];
}

#pragma mark 每当有一个cell进入视野范围内就会调用，返回当前这行显示的cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.创建一个ALSettingCell
    ALSecurityCell *cell = [ALSecurityCell settingCellWithTableView:tableView view:[self getCentreView:indexPath.row]];
    
    // 2.取出这行对应的模型（ALSettingItem）
    ALSettingGroup *group = _allGroups[indexPath.section];
    cell.item = group.items[indexPath.row];
//    cell.indexPath = indexPath;
    
    return cell;
}

-(UIView *)getCentreView:(NSUInteger)row
{
    UIView *view = [[UIView alloc] init];
    [view sizeToFit];
    switch (row) {
        case 0:
        {
            [self newLabel:@"安全性中" image:@"tanchuang1" view:view textColor:nil];
            break;
        }
        case 1:
        {
            [self newLabel:@"15*******00" image:nil view:view textColor:nil];
            break;
        }
        case 2:
        {
            [self newLabel:@"未绑定" image:nil view:view textColor:[UIColor orangeColor]];
            break;
        }
        default:
            break;
    }
    return view;
}

-(void)newLabel:(NSString *)text image:(NSString *)imageName view:(UIView *)view textColor:(UIColor *)textColor
{
    UIImageView *imageView = nil;
    if (imageName!= nil) {
        imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        [imageView sizeToFit];
    }
    if (text != nil) {
        UILabel *label = [[UILabel alloc] init];
        label.text = text;
        if (imageView != nil) {
            CGRect frame = label.frame;
            frame.origin.x =imageView.frame.origin.x+imageView.frame.size.width;
            label.frame = frame;
            [view addSubview:imageView];
        }
        if (textColor != nil) {
            label.textColor = textColor;
        }
        [label sizeToFit];
        [view addSubview:label];
    }
}
@end
