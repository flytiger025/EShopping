//
//  SBTabBarController.m
//  EShopping
//
//  Created by 任龙宇 on 15/3/7.
//  Copyright (c) 2015年 renlongyu. All rights reserved.
//

#import "SBNavTabBarController.h"
#import "SBTabBar.h"
#import "Macro.h"
#import "WaterfallViewController.h"

@interface SBNavTabBarController () <SBTabBarDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray *titles;
@property (nonatomic, strong) SBTabBar *navTabBar;
@property (nonatomic, strong) UIScrollView *mainView;

@end

@implementation SBNavTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        
    _currentIndex = 0;
    self.titles = [NSMutableArray arrayWithCapacity:_viewControllers.count];
    for (UIViewController *viewController in _viewControllers) {
        [_titles addObject:viewController.title];
    }
    
    self.navTabBar = [[SBTabBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NAV_TAB_BAR_HEIGHT)];
    _navTabBar.delegate = self;
    _navTabBar.backgroundColor = [UIColor colorWithRed:0.941 green:0.941 blue:0.941 alpha:1];
    _navTabBar.itemsTitle = _titles;
    [_navTabBar updateData];
    
    CGFloat originY = _navTabBar.frame.origin.y + _navTabBar.frame.size.height;
    self.mainView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, originY, SCREEN_WIDTH, SCREEN_HEIGHT - originY - 50)];
    _mainView.delegate = self;
    _mainView.pagingEnabled = YES;
    _mainView.directionalLockEnabled = YES;
    _mainView.showsHorizontalScrollIndicator = NO;
    _mainView.showsVerticalScrollIndicator = NO;
    _mainView.contentSize = CGSizeMake(SCREEN_WIDTH *_viewControllers.count, 0);
        
    [self.view addSubview:_navTabBar];
    [self.view addSubview:_mainView];
    
    [_viewControllers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIViewController *viewController = (UIViewController *)_viewControllers[idx];
        viewController.view.frame = CGRectMake(idx * SCREEN_WIDTH, 0, SCREEN_WIDTH, _mainView.frame.size.height);
        [self addChildViewController:viewController];
        if (idx == 0 || idx == 1) {
            [_mainView addSubview:viewController.view];
        }
    }];
}

- (void)addParentController:(UIViewController *)viewController {
    if ([viewController respondsToSelector:@selector(edgesForExtendedLayout)]) {
        viewController.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    [viewController addChildViewController:self];
    [viewController.view addSubview:self.view];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    _currentIndex = scrollView.contentOffset.x / SCREEN_WIDTH;
    _navTabBar.currentIndex = _currentIndex;
    [self loadRightAndLeftView];
}

- (void)tabBar:(SBTabBar *)tabBar didSelectItemWithIndex:(NSInteger)index {
    _currentIndex = index;
    
    WaterfallViewController *currentVC = (WaterfallViewController *)_viewControllers[index];
    if (!currentVC.isLoad) {
        [_mainView addSubview:currentVC.view];
        currentVC.isLoad = YES;
    }
    
    [_mainView setContentOffset:CGPointMake(index * SCREEN_WIDTH, 0) animated:NO];
    [self loadRightAndLeftView];
}


#pragma mark - 

- (void)loadRightAndLeftView {
    if (_currentIndex + 1 < _viewControllers.count) {
        WaterfallViewController *rightVC = (WaterfallViewController *)_viewControllers[_currentIndex + 1];
        if (!rightVC.isLoad) {
            [_mainView addSubview:rightVC.view];
            rightVC.isLoad = YES;
        }
    }
    
    if (_currentIndex - 1 >= 0) {
        WaterfallViewController *leftVC = (WaterfallViewController *)_viewControllers[_currentIndex - 1];
        if (!leftVC.isLoad) {
            [_mainView addSubview:leftVC.view];
            leftVC.isLoad = YES;
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
