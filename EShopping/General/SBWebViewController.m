//
//  SBWebViewController.m
//  EShopping
//
//  Created by 任龙宇 on 15/3/11.
//  Copyright (c) 2015年 renlongyu. All rights reserved.
//

#import "SBWebViewController.h"
#import "UINavigationController+M13ProgressViewBar.h"
#import "DXAlertView.h"
#import "WeiboSDK.h"
#import <ShareSDK/ShareSDK.h>
#import "MBProgressHUD.h"

@interface SBWebViewController () <UIWebViewDelegate, MBProgressHUDDelegate>

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
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_url]]];
    
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
    if ([request.URL.absoluteString hasPrefix:@"tmall"] || [request.URL.absoluteString hasPrefix:@"taobao"]) {
        return NO;
    }
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self changeItemColor];
    [self.navigationController showProgress];
    [self setQuarter];
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

#pragma mark - Progress

- (void)setQuarter
{
    [self.navigationController setProgress:0.25 animated:YES];
    [self performSelector:@selector(setTwoThirds) withObject:nil afterDelay:1.2];
}

- (void)setTwoThirds
{
    if (self.navigationController.isShowingProgressBar) {
        [self.navigationController setProgress:0.66 animated:YES];
        [self performSelector:@selector(setThreeQuarters) withObject:nil afterDelay:0.7];
    }
}

- (void)setThreeQuarters
{
    if (self.navigationController.isShowingProgressBar) {
        [self.navigationController setProgress:0.75 animated:YES];
    }
}

#pragma mark - ToolBar Item

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
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        // Do something...
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    });
    
    [self.webView reload];
}

- (IBAction)share:(id)sender {
    //TODO: share
    [self shareAction];
}

#pragma mark - Share

- (void)shareAction {
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"ShareSDK" ofType:@"png"];
    
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:[NSString stringWithFormat:@"%@\t\n链接:%@",_desc, _url]
                                       defaultContent:@"e购--淘最适合你的单品"
                                                //image:[ShareSDK imageWithUrl:_imageURL]
                                                image:[ShareSDK imageWithPath:imagePath]
                                                title:@"e购--淘最适合你的单品"
                                                  url:_url
                                          description:@"e购--淘最适合你的单品"
                                            mediaType:SSPublishContentMediaTypeNews];
    //创建弹出菜单容器
    id<ISSContainer> container = [ShareSDK container];
//    [container setIPadContainerWithView:sender arrowDirect:UIPopoverArrowDirectionUp];
    
    //弹出分享菜单
    [ShareSDK showShareActionSheet:container
                         shareList:nil
                           content:publishContent
                     statusBarTips:YES
                       authOptions:nil
                      shareOptions:nil
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                
                                if (state == SSResponseStateSuccess)
                                {
                                    [self sharedSuccess];
                                }
                                else if (state == SSResponseStateFail)
                                {
                                    [self sharedFailure:error];
                                }
                            }];
}


- (void)sharedSuccess {
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    
    // Set custom view mode
    HUD.mode = MBProgressHUDModeCustomView;
    
    HUD.delegate = self;
    HUD.labelText = @"成功";
    
    [HUD show:YES];
    [HUD hide:YES afterDelay:1.5];
}

- (void)sharedFailure:(id<ICMErrorInfo>)error {
//    NSLog(@"分享失败,错误码:%@错误描述:%@", @([error errorCode]), [error errorDescription]);
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    
    // Set custom view mode
    HUD.mode = MBProgressHUDModeCustomView;
    
    HUD.delegate = self;
    HUD.labelText = @"失败";
    
    [HUD show:YES];
    [HUD hide:YES afterDelay:1.5];
}

@end
