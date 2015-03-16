//
//  DaPeiInfoViewController.m
//  EShopping
//
//  Created by 任龙宇 on 15/3/9.
//  Copyright (c) 2015年 renlongyu. All rights reserved.
//

#import "DaPeiInfoViewController.h"
#import "DaPeiInfoTableFooterViewCell.h"
#import "DaPeiInfoModel.h"
#import "WebServer.h"
#import "URL.h"
#import "Macro.h"
#import "DaPeiInfoTableHeaderViewCell.h"
#import "UIImageView+SDWebImage_M13ProgressSuite.h"
#import "DaPeiInfoTableViewCell+Configure.h"
#import "SBWebViewController.h"
#import "SBImageViewController.h"
#import "DaPeiModel.h"


static NSString * const daPeiCellIdentifier = @"DaPeiInfoTableViewCell";
static NSString * const footerViewIdentifier = @"DaPeiInfoTableFooterViewCell";
static NSString * const headerViewIdentifier = @"DaPeiInfoTableHeaderViewCell";


@interface DaPeiInfoViewController () <WebServerDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) UIImageView *headerView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, weak) UIActivityIndicatorView *activityView;

@end

@implementation DaPeiInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeBottom;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationItem.title = @"搭配信息";

    self.dataArray = [NSMutableArray array];
    
    UIImage *image = [[UIImage imageNamed:@"newBack"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:image
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(backItem:)];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;

    [self.tableView registerNib:[UINib nibWithNibName:daPeiCellIdentifier bundle:nil] forCellReuseIdentifier:daPeiCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:footerViewIdentifier bundle:nil] forCellReuseIdentifier:footerViewIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:headerViewIdentifier bundle:nil] forCellReuseIdentifier:headerViewIdentifier];
    
    CGFloat height = [_model.imageHeight floatValue] / [_model.imageWidth floatValue] * SCREEN_WIDTH;
    self.headerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, height)];
    _headerView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [_headerView addGestureRecognizer:tap];
    self.tableView.tableHeaderView = _headerView;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self loadData];
    [self.activityView startAnimating];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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


#pragma mark - Action

- (void)backItem:(UIBarButtonItem *)item {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)tapAction:(UITapGestureRecognizer *)tap {
    SBImageViewController *imageViewController = [[SBImageViewController alloc] init];
    imageViewController.image = self.headerView.image;
    imageViewController.imageWidth = [_model.imageWidth floatValue];
    imageViewController.imageHeight = [_model.imageHeight floatValue];
    imageViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self.navigationController presentViewController:imageViewController animated:YES completion:nil];
}

- (void)loadData {
    WebServer *webServer = [[WebServer alloc] init];
    webServer.delegate = self;
    [webServer requestDataWithURL:[URL daPeiInfoURLWithParam:self.model.param]];
}

#pragma mark - WebServerDelegate

- (void)webServerDidReceiveDataSuccess:(id)responseObject {
    NSString *imageURL = responseObject[@"big_pic"];
    
    __weak DaPeiInfoViewController *blockSelf = self;
    [self.headerView setImageUsingProgressViewRingWithURL:[NSURL URLWithString:imageURL]
                                         placeholderImage:nil
                                                  options:SDWebImageRetryFailed
                                                 progress:nil
                                                completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                                    if (error) {
                                                        blockSelf.headerView.image = [UIImage imageNamed:@"loading"];
                                                    }
                                                }
                                     ProgressPrimaryColor:[UIColor lightGrayColor]
                                   ProgressSecondaryColor:nil
                                                 Diameter:60];
    
    if ([responseObject[@"goods"] isEqual:[NSNull null]]) {
        [self webServerDidReceiveDataFailure:nil];
        return;
    }
    
    @autoreleasepool {
        for (NSDictionary *dic in responseObject[@"goods"]) {
            DaPeiInfoModel *model = [DaPeiInfoModel infoModel];
            [model setValuesForKeysWithDictionary:dic];
            [self.dataArray addObject:model];
        }
    }
    
    [self removeActivityView];
    [self.tableView reloadData];
}

- (void)webServerDidReceiveDataFailure:(NSError *)error {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self loadData];
    });
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y < 5) {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 1 ? self.dataArray.count : 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        DaPeiInfoTableHeaderViewCell *cell = [tableView dequeueReusableCellWithIdentifier:headerViewIdentifier forIndexPath:indexPath];
        return cell;
        
    }else if (indexPath.section == 1) {
        DaPeiInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:daPeiCellIdentifier forIndexPath:indexPath];
        DaPeiInfoModel *model = self.dataArray[indexPath.row];
        [cell configuredCellWithModel:model];
        return cell;
        
    } else {
        DaPeiInfoTableFooterViewCell *cell = [tableView dequeueReusableCellWithIdentifier:footerViewIdentifier forIndexPath:indexPath];
        cell.label.text = [NSString stringWithFormat:@"%@个人喜欢", self.model.loveNumber];
        return cell;
    }
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.section == 1 ? 57 : 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        [self.navigationController setNavigationBarHidden:NO];
        DaPeiInfoModel *model = self.dataArray[indexPath.row];
        SBWebViewController *webViewController = [[SBWebViewController alloc] init];
        webViewController.url = model.url;
        webViewController.desc = model.title;
        webViewController.imageURL = model.smallImageURL;
        webViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:webViewController animated:YES];
    }
}

@end
