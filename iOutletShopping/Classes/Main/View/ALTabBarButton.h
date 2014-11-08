//
//  ALTabBarButton.h
//  ItcastLottery
//
//  Created by Huashen on 14-9-17.
//  Copyright (c) 2014年 aolaigo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ALTabBarButton : UIButton
-(id)initTabBarButtonWithImage:(NSString *)imgName SelectImage:(NSString *)selectImage index:(NSInteger)index totalNumber:(NSInteger)number;
@end
