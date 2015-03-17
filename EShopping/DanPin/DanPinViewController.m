//
//  DanPinViewController.m
//  EShopping
//
//  Created by 任龙宇 on 15/3/7.
//  Copyright (c) 2015年 renlongyu. All rights reserved.
//

#import "DanPinViewController.h"
#import "DanPinCollectionViewController.h"
#import "SBNavTabBarController.h"
#import "URL.h"
#import "WebServer.h"
#import "DanPinCategory.h"

@interface DanPinViewController () <WebServerDelegate>

@property (nonatomic, weak) UIActivityIndicatorView *activityView;

@end

@implementation DanPinViewController

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
    self.navigationItem.title = @"潮流单品";
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
    [webServer requestDataWithURL:[URL danPinURL]];
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
    
    if ([responseObject[@"list"] isEqual:[NSNull null]]) {
        [self webServerDidReceiveDataFailure:nil];
        return;
    }

    for (NSDictionary *dic in responseObject[@"list"]) {
        @autoreleasepool {
            DanPinCategory *category = [[DanPinCategory alloc] init];
            [category setValuesForKeysWithDictionary:dic];
            
            DanPinCollectionViewController *viewController = [[DanPinCollectionViewController alloc] init];
            viewController.title = category.name;
            viewController.category = category.ID;
            [viewControllers addObject:viewController];
        }
    }
    
    SBNavTabBarController *navTabBarController = [[SBNavTabBarController alloc] init];
    navTabBarController.viewControllers = viewControllers;
    [navTabBarController addParentController:self];
    
    [self removeActivityView];
}

- (void)webServerDidReceiveDataFailure:(NSError *)error {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self loadCategory];
    });
}

@end
