//
//  NvZhuangViewController.m
//  EShopping
//
//  Created by 任龙宇 on 15/3/11.
//  Copyright (c) 2015年 renlongyu. All rights reserved.
//

#import "NvZhuangViewController.h"
#import "UINavigationController+M13ProgressViewBar.h"
#import "Macro.h"
#import "NZInfoViewController.h"

@interface NvZhuangViewController () <UIWebViewDelegate>

@property (nonatomic, weak) UIWebView *webView;
@property (nonatomic, strong) NSArray *urlArray;

@end

@implementation NvZhuangViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"精品女装";
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:NV_ZHUANG_URL]]];

    UIImage *image = [[UIImage imageNamed:@"newBack"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:image
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(backItemAction)];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
    
    self.urlArray = @[@"http://zhekou.repai.com/lws/view/nvzhuang_mobile.php?app_id=2222&sche=fenfen",
                      @"http://zhekou.repai.com/lws/wangyu/index.php?control=tianmao&model=show_view&styl=nvzhuang",
                      @"http://zhekou.repai.com/lws/wangyu/index.php?control=tianmao&model=show_view&styl=nvzhuang#",
                      @"http://zhekou.repai.com/lws/wangyu/index.php?control=tianmao&model=show_view&styl=nvzhuang&cate=0",
                      @"http://zhekou.repai.com/lws/wangyu/index.php?control=tianmao&model=show_view&styl=nvzhuang&cate=1",
                      @"http://zhekou.repai.com/lws/wangyu/index.php?control=tianmao&model=show_view&styl=nvzhuang&cate=2",
                      @"http://zhekou.repai.com/lws/wangyu/index.php?control=tianmao&model=show_view&styl=nvzhuang&cate=3",
                      @"http://zhekou.repai.com/lws/wangyu/index.php?control=tianmao&model=show_view&styl=nvzhuang&cate=4",
                      @"http://zhekou.repai.com/lws/wangyu/index.php?control=tianmao&model=show_view&styl=nvzhuang&cate=5",
                      @"http://zhekou.repai.com/lws/wangyu/index.php?control=tianmao&model=show_view&styl=nvzhuang&cate=6",
                      @"http://zhekou.repai.com/lws/wangyu/index.php?control=tianmao&model=show_view&styl=nvzhuang&cate=7",
                      @"http://zhekou.repai.com/lws/wangyu/index.php?control=tianmao&model=show_view&styl=nvzhuang&cate=8"];
}

- (void)backItemAction {
    if ([self.navigationController isShowingProgressBar]) {
        [self.navigationController cancelProgress];
        [self.navigationController setProgress:0 animated:NO];
        [self deleteWebView];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIWebView *)webView {
    if (_webView == nil) {
        UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
        webView.delegate = self;
        [self.view addSubview:_webView = webView];
    }
    return _webView;
}

- (void)dealloc {
    [self deleteWebView];
}

- (void)deleteWebView {
    if (_webView) {
        [_webView removeFromSuperview];
        _webView = nil;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    if (self.isViewLoaded) {
        [self deleteWebView];
        [self.webView reload];
    }
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    for (NSString *string in self.urlArray) {
        if ([request.URL.absoluteString isEqualToString:string]) {
            return YES;
        }
    }
    
    NZInfoViewController *nzInfoVC = [[NZInfoViewController alloc] init];
    nzInfoVC.request = request;
    [self.navigationController pushViewController:nzInfoVC animated:YES];
    
    return NO;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    if ([self.navigationController isShowingProgressBar]) {
        [self.navigationController cancelProgress];
        [self.navigationController setProgress:0 animated:NO];
    }
    
    [self.navigationController showProgress];
    [self.navigationController setProgress:0.3 animated:YES];
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(changeProgress:) userInfo:nil repeats:NO];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.navigationController finishProgress];
    [self.navigationController setProgress:0 animated:NO];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self.navigationController setProgress:0 animated:NO];
    [self.navigationController cancelProgress];
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
