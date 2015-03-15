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

@property (nonatomic, weak) UIImageView *lanunchImageView;

@end

static void *DaPeiObserverContext = &DaPeiObserverContext;

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    DaPeiViewController *daPeiVC = [[DaPeiViewController alloc] init];
    daPeiVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil
                                                       image:[UIImage imageNamed:@"tabItem0"]
                                               selectedImage:[[UIImage imageNamed:@"tabItem_0"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    daPeiVC.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
    UINavigationController *daPeiNC = [[UINavigationController alloc] initWithRootViewController:daPeiVC];
    
    DanPinViewController *danPinVC = [[DanPinViewController alloc] init];
    danPinVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil
                                                        image:[UIImage imageNamed:@"tabItem1"]
                                                selectedImage:[[UIImage imageNamed:@"tabItem_1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    danPinVC.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
    UINavigationController *danPinNC = [[UINavigationController alloc] initWithRootViewController:danPinVC];
    
    FaXianViewController *faXianVC = [[FaXianViewController alloc] init];
    faXianVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil
                                                        image:[UIImage imageNamed:@"tabItem2"]
                                                selectedImage:[[UIImage imageNamed:@"tabItem_2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    faXianVC.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
    UINavigationController *faXianNC = [[UINavigationController alloc] initWithRootViewController:faXianVC];

    WoDeViewController *woDeVC = [[WoDeViewController alloc] init];
    woDeVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil
                                                      image:[UIImage imageNamed:@"tabItem3"]
                                              selectedImage:[[UIImage imageNamed:@"tabItem_3"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    woDeVC.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
    UINavigationController *woDeNC = [[UINavigationController alloc] initWithRootViewController:woDeVC];
    
    self.viewControllers = @[daPeiNC, danPinNC, faXianNC, woDeNC];

    
    [daPeiVC addObserver:self
              forKeyPath:@"firstLanuchFinished"
                 options:NSKeyValueObservingOptionNew
                 context:DaPeiObserverContext];
    
    [self showLanuchImage];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self finishLaunch];
    });
}

- (void)dealloc {
    [self removeObserver:self forKeyPath:@"firstLanuchFinished"];
}

- (void)showLanuchImage {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"LaunchImage-640x1136" ofType:@"png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:path]];
    imageView.frame = self.view.frame;
    imageView.contentMode = UIViewContentModeScaleToFill;
    self.lanunchImageView = imageView;
    [self.view addSubview:imageView];
}

- (void)finishLaunch {
    if (self.lanunchImageView) {
        [self.lanunchImageView removeFromSuperview];
        self.lanunchImageView = nil;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (context == DaPeiObserverContext && [change[NSKeyValueChangeNewKey] boolValue]) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self finishLaunch];
        });
    }
}


@end
