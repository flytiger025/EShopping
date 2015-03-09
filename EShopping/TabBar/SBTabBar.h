//
//  SBTabBar.h
//  EShopping
//
//  Created by 任龙宇 on 15/3/7.
//  Copyright (c) 2015年 renlongyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SBTabBar;

@protocol SBTabBarDelegate <NSObject>

- (void)tabBar:(SBTabBar *)tabBar didSelectItemWithIndex:(NSInteger)index;

@end

@interface SBTabBar : UIView

@property (nonatomic, weak) id<SBTabBarDelegate> delegate;
@property (nonatomic, strong) NSArray *itemsTitle;
@property (nonatomic, assign) NSInteger currentIndex;

- (void)updateData;

@end
