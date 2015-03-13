//
//  SBWebViewController.m
//  EShopping
//
//  Created by 任龙宇 on 15/3/11.
//  Copyright (c) 2015年 renlongyu. All rights reserved.
//

#import "SBWebViewController.h"
#import "UINavigationController+M13ProgressViewBar.h"

@interface SBWebViewController () <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *leftItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *rightItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *refreshItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sharedItem;

@end

@implementation SBWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.webView loadRequest:[NSURLRequest requestWithURL:_url]];
    
    self.navigationItem.title = @"宝贝详情";
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    UIImage *image = [[UIImage imageNamed:@"newBack"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:image
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(backItemAction)];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)backItemAction {
    if ([self.navigationController isShowingProgressBar]) {
        [self.navigationController cancelProgress];
        [self.navigationController setProgress:0 animated:NO];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self changeItemColor];
    [self.navigationController showProgress];
    [self.navigationController setProgress:0.3 animated:YES];
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(changeProgress:) userInfo:nil repeats:NO];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self changeItemColor];
    [self.navigationController finishProgress];
    [self.navigationController setProgress:0 animated:NO];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self changeItemColor];
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

- (void)changeItemColor {
    if ([self.webView canGoBack]) {
        self.leftItem.tintColor = [UIColor colorWithWhite:0.2 alpha:1];
    }
    if ([self.webView canGoForward]) {
        self.rightItem.tintColor = [UIColor colorWithWhite:0.2 alpha:1];
    }
}

- (IBAction)back:(id)sender {
    [self.webView goBack];
}

- (IBAction)forward:(id)sender {
    [self.webView goForward];
}

- (IBAction)refresh:(id)sender {
    [self.webView reload];
}

- (IBAction)share:(id)sender {
    //TODO: share
}

@end
