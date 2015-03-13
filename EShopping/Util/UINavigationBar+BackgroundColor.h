//
//  UINavigationBar+BackgroundColor.h
//  EShopping
//
//  Created by 任龙宇 on 15/3/13.
//  Copyright (c) 2015年 renlongyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (BackgroundColor)

@property (nonatomic, strong, readonly) UIView *overlay;

- (void)useBackgroundColor:(UIColor *)backgroundColor;

- (void)reset;

@end
