//
//  DapeiViewController.m
//  EShopping
//
//  Created by 任龙宇 on 15/3/7.
//  Copyright (c) 2015年 renlongyu. All rights reserved.
//

#import "DaPeiViewController.h"
#import "WaterfallViewController.h"
#import "SBNavTabBarController.h"

@interface DaPeiViewController ()

@end

@implementation DaPeiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"搭配";
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    WaterfallViewController *oneViewController = [[WaterfallViewController alloc] init];
    oneViewController.title = @"新闻";
    
    WaterfallViewController *twoViewController = [[WaterfallViewController alloc] init];
    twoViewController.title = @"体育";
    
    WaterfallViewController *threeViewController = [[WaterfallViewController alloc] init];
    threeViewController.title = @"娱乐八卦";
    
    WaterfallViewController *fourViewController = [[WaterfallViewController alloc] init];
    fourViewController.title = @"天府之国";
    
    WaterfallViewController *fiveViewController = [[WaterfallViewController alloc] init];
    fiveViewController.title = @"四川省";
    
    WaterfallViewController *sixViewController = [[WaterfallViewController alloc] init];
    sixViewController.title = @"政治";
    
    WaterfallViewController *sevenViewController = [[WaterfallViewController alloc] init];
    sevenViewController.title = @"国际新闻";
    
    WaterfallViewController *eightViewController = [[WaterfallViewController alloc] init];
    eightViewController.title = @"自媒体";
    
    WaterfallViewController *ninghtViewController = [[WaterfallViewController alloc] init];
    ninghtViewController.title = @"科技";
    
    SBNavTabBarController *navTabBarController = [[SBNavTabBarController alloc] init];
    navTabBarController.viewControllers = @[oneViewController, twoViewController, threeViewController, fourViewController, fiveViewController, sixViewController, sevenViewController, eightViewController, ninghtViewController];
    [navTabBarController addParentController:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
