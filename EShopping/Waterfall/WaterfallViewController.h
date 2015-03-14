//
//  WaterfallViewController.h
//  EShopping
//
//  Created by 任龙宇 on 15/3/7.
//  Copyright (c) 2015年 renlongyu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ViewControllerType) {
    ViewControllerTypeDaPei,
    ViewControllerTypeDanPin,
    ViewControllerTypeFaXian,
};

@interface WaterfallViewController : UIViewController

@property (nonatomic, weak, readonly) UICollectionView *waterfallView;

@property (nonatomic, copy) NSString *category;

@property (nonatomic, assign) BOOL isLoad;

+ (WaterfallViewController *)viewControllerWithType:(ViewControllerType)type;
- (NSString *)cellIdentifier;

@end
