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

@property (nonatomic, weak) UIActivityIndicatorView *activityView;

@end

@implementation DaPeiViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self loadCategory];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"搭配";
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self.activityView startAnimating];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadCategory {
    WebServer *webServer = [[WebServer alloc] init];
    webServer.delegate = self;
    [webServer requestDataWithURL:[URL daPeiURL]];
}

#pragma mark - ActivityIndicatorView

- (UIActivityIndicatorView *)activityView {
    if (!_activityView) {
        UIActivityIndicatorView *view = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        view.frame = CGRectMake(self.view.center.x, self.view.center.y - 64, 0, 0);
        [self.view addSubview:_activityView = view];
    }
    return _activityView;
}

- (void)removeActivityView {
    [_activityView stopAnimating];
    [_activityView removeFromSuperview];
    _activityView = nil;
}

#pragma mark - WebServerDelegate

- (void)webServerDidReceiveDataSuccess:(id)responseObject {
    NSMutableArray *viewControllers = [NSMutableArray array];
    SBNavTabBarController *navTabBarController = [[SBNavTabBarController alloc] init];

    for (NSDictionary *dic in responseObject) {
        @autoreleasepool {
            DaPeiCategory *category = [[DaPeiCategory alloc] init];
            [category setValuesForKeysWithDictionary:dic];
            
            WaterfallViewController *viewController = [WaterfallViewController viewControllerWithType:ViewControllerTypeDaPei];
            viewController.title = category.title;
            viewController.category = category.category;
            [viewControllers addObject:viewController];
        }
    }
    
    navTabBarController.viewControllers = viewControllers;
    [navTabBarController addParentController:self];
    
    self.firstLanuchFinished = YES;
    [self removeActivityView];
}

- (void)webServerDidReceiveDataFailure:(NSError *)error {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self loadCategory];
    });
}

@end
