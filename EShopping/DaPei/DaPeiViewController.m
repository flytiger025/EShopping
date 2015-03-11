//
//  DapeiViewController.m
//  EShopping
//
//  Created by 任龙宇 on 15/3/7.
//  Copyright (c) 2015年 renlongyu. All rights reserved.
//

#import "DaPeiViewController.h"
#import "SBNavTabBarController.h"
#import "WebServer.h"
#import "URL.h"
#import "DaPeiCategory.h"
#import "WaterfallViewController.h"

@interface DaPeiViewController () <WebServerDelegate>

@end

@implementation DaPeiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"搭配";
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self loadCategory];
    }
    return self;
}

- (void)loadCategory {
    WebServer *webServer = [[WebServer alloc] init];
    webServer.delegate = self;
    [webServer requestDataWithURL:[URL daPeiURL]];
}

- (void)webServerDidReceiveDataSuccess:(id)responseObject {
    NSMutableArray *viewControllers = [NSMutableArray array];
    SBNavTabBarController *navTabBarController = [[SBNavTabBarController alloc] init];

    @autoreleasepool {
        for (NSDictionary *dic in responseObject) {
            DaPeiCategory *category = [DaPeiCategory category];
            [category setValuesForKeysWithDictionary:dic];
            
            WaterfallViewController *viewController = [WaterfallViewController viewControllerWithType:ViewControllerTypeDaPei];
            viewController.title = category.title;
            viewController.category = category.category;
            [viewControllers addObject:viewController];
        }
    }
    
    navTabBarController.viewControllers = viewControllers;
    [navTabBarController addParentController:self];
}

- (void)webServerDidReceiveDataFailure:(NSError *)error {
    NSLog(@"%@", error);
    //TODO: 搭配 网络错误处理
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
