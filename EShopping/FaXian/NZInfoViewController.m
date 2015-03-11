//
//  NZInfoViewController.m
//  EShopping
//
//  Created by 任龙宇 on 15/3/11.
//  Copyright (c) 2015年 renlongyu. All rights reserved.
//

#import "NZInfoViewController.h"
#import "UINavigationController+M13ProgressViewBar.h"

@interface NZInfoViewController () <UIWebViewDelegate>

@property (nonatomic, weak) UIWebView *webView;

@end

@implementation NZInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"详情页";
    
    [self.webView loadRequest:_request];
    
    UIImage *image = [[UIImage imageNamed:@"newBack"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:image
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(backItemAction)];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
}

- (void)backItemAction {
    if ([self.navigationController isShowingProgressBar]) {
        [self.navigationController cancelProgress];
        [self.navigationController setProgress:0 animated:NO];
        [self deleteWebView];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    if (self.isViewLoaded) {
        [self deleteWebView];
        [self.webView reload];
    }
}

- (UIWebView *)webView {
    if (_webView == nil) {
        UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
        webView.delegate = self;
        [self.view addSubview:_webView = webView];
    }
    return _webView;
}

- (void)deleteWebView {
    if (_webView) {
        [_webView removeFromSuperview];
        _webView = nil;
    }
}

- (void)dealloc {
    [self deleteWebView];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self deleteWebView];
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self.navigationController showProgress];
    [self.navigationController setProgress:0.3 animated:YES];
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(changeProgress:) userInfo:nil repeats:NO];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.navigationController finishProgress];
    [self.navigationController setProgress:0 animated:NO];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self.navigationController cancelProgress];
    [self.navigationController setProgress:0 animated:NO];
}

#pragma mark -

- (void)changeProgress:(NSTimer *)timer {
    if ([self.navigationController isShowingProgressBar]) {
        [self.navigationController setProgress:0.8 animated:YES];
    } else {
        [timer invalidate];
    }
}


@end
