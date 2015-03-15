//
//  FaXianViewController.m
//  EShopping
//
//  Created by 任龙宇 on 15/3/7.
//  Copyright (c) 2015年 renlongyu. All rights reserved.
//

#import "FaXianViewController.h"
#import "SBTitleView.h"
#import "JKJViewController.h"
#import "BanJiaViewController.h"
#import "Macro.h"
#import "NvZhuangViewController.h"

@interface FaXianViewController () <SBTitleViewDelegate, UIScrollViewDelegate>
{
    UIScrollView *_mainView;
}

@property (nonatomic, strong) SBTitleView *titleView;

@end

@implementation FaXianViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:0.949 green:0.949 blue:0.937 alpha:1];

    self.titleView = [[SBTitleView alloc] initWithFrame:CGRectMake(0, 0, 120, 30)];
    _titleView.backgroundColor = [UIColor colorWithRed:0.945 green:0.945 blue:0.945 alpha:1];
    _titleView.delegate = self;
    _titleView.leftButtonTitle = @"九块九";
    _titleView.rightButtonTitle = @"半价";
    self.navigationItem.titleView = self.titleView;
    
    UIImage *image = [[UIImage imageNamed:@"threeBars"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:image
                                                                  style:UIBarButtonItemStylePlain
                                                                 target:self
                                                                 action:@selector(rightItemAction:)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    JKJViewController *jkjVC = [[JKJViewController alloc] init];
    [self addChildViewController:jkjVC];
    [_mainView addSubview:jkjVC.view];
    
    BanJiaViewController *banJiaVC = [[BanJiaViewController alloc] init];
    banJiaVC.view.frame = CGRectMake(self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self addChildViewController:banJiaVC];
    [_mainView addSubview:banJiaVC.view];
}

- (void)loadView {
    [super loadView];
    if (!_mainView) {
        _mainView = [[UIScrollView alloc] initWithFrame:self.view.frame];
        _mainView.contentSize = CGSizeMake(self.view.frame.size.width * 2, 0);
        _mainView.showsHorizontalScrollIndicator = 0;
        _mainView.pagingEnabled = YES;
        _mainView.delegate = self;
        self.view = _mainView;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)rightItemAction:(UIBarButtonItem *)rightItem {
    NvZhuangViewController *nzViewController = [[NvZhuangViewController alloc] init];
    nzViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:nzViewController animated:YES];
}

#pragma mark - SBTitleViewDelegate

- (void)titleViewDidClickedLeftButton:(SBTitleView *)titleView {
    [_mainView setContentOffset:CGPointZero animated:YES];
}

- (void)titleViewDidClickedRightButton:(SBTitleView *)titleView {
    [_mainView setContentOffset:CGPointMake(self.view.frame.size.width, 0) animated:YES];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    _titleView.state = scrollView.contentOffset.x == 0 ? SBTitleViewStateLeft : SBTitleViewStateRight;
}



@end
