//
//  Macro.h
//  EShopping
//
//  Created by 任龙宇 on 15/3/7.
//  Copyright (c) 2015年 renlongyu. All rights reserved.
//

#ifndef EShopping_Macro_h
#define EShopping_Macro_h


#define DEBUG_LOG           NSLog(@"%s", __FUNCTION__)


#define SCREEN_WIDTH        [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT       [UIScreen mainScreen].bounds.size.height

#define NAV_TAB_BAR_HEIGHT  44


#define RANDOM_COLOR [UIColor colorWithRed:arc4random() % 256 / 255. green:arc4random() % 256 / 255. blue:arc4random() % 256 / 255. alpha:1.]


#endif
