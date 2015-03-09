//
//  RootViewController.m
//  EShopping
//
//  Created by 任龙宇 on 15/3/7.
//  Copyright (c) 2015年 renlongyu. All rights reserved.
//

#import "RootViewController.h"
#import "DaPeiViewController.h"
#import "DanPinViewController.h"
#import "FaXianViewController.h"
#import "WoDeViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    DaPeiViewController *daPeiVC = [[DaPeiViewController alloc] init];
    daPeiVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:[UIImage imageNamed:@"tabItem0"] selectedImage:[[UIImage imageNamed:@"tabItem_0"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    daPeiVC.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
    UINavigationController *daPeiNC = [[UINavigationController alloc] initWithRootViewController:daPeiVC];
    
    DanPinViewController *danPinVC = [[DanPinViewController alloc] init];
    danPinVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:[UIImage imageNamed:@"tabItem1"] selectedImage:[[UIImage imageNamed:@"tabItem_1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    danPinVC.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
    UINavigationController *danPinNC = [[UINavigationController alloc] initWithRootViewController:danPinVC];
    
    FaXianViewController *faXianVC = [[FaXianViewController alloc] init];
    faXianVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:[UIImage imageNamed:@"tabItem2"] selectedImage:[[UIImage imageNamed:@"tabItem_2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    faXianVC.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
    UINavigationController *faXianNC = [[UINavigationController alloc] initWithRootViewController:faXianVC];

    WoDeViewController *woDeVC = [[WoDeViewController alloc] init];
    woDeVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:[UIImage imageNamed:@"tabItem3"] selectedImage:[[UIImage imageNamed:@"tabItem_3"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    woDeVC.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
    UINavigationController *woDeNC = [[UINavigationController alloc] initWithRootViewController:woDeVC];
    
    self.viewControllers = @[daPeiNC, danPinNC, faXianNC, woDeNC];    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
