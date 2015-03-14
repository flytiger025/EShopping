//
//  SBTabBarController.h
//  EShopping
//
//  Created by 任龙宇 on 15/3/7.
//  Copyright (c) 2015年 renlongyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SBNavTabBarController;

@interface SBNavTabBarController : UIViewController

@property (nonatomic, strong) NSArray *viewControllers;
@property (nonatomic, assign) NSInteger currentIndex;

- (void)addParentController:(UIViewController *)viewController;

@end
