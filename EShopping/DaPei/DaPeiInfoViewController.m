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


static NSString * const daPeiCellIdentifier = @"DaPeiInfoTableViewCell";
static NSString * const footerViewIdentifier = @"DaPeiInfoTableFooterViewCell";
static NSString * const headerViewIdentifier = @"DaPeiInfoTableHeaderViewCell";


@interface DaPeiInfoViewController () <WebServerDelegate>

@property (nonatomic, strong) UIImageView *headerView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation DaPeiInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"搭配信息";

    self.dataArray = [NSMutableArray array];
    
    self.navigationController.hidesBarsOnSwipe = YES;
    
    UIImage *image = [[UIImage imageNamed:@"newBack"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:image
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(backItem:)];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;

    [self.tableView registerNib:[UINib nibWithNibName:daPeiCellIdentifier bundle:nil] forCellReuseIdentifier:daPeiCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:footerViewIdentifier bundle:nil] forCellReuseIdentifier:footerViewIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:headerViewIdentifier bundle:nil] forCellReuseIdentifier:headerViewIdentifier];
    
    self.headerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64)];
    self.tableView.tableHeaderView = _headerView;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    WebServer *webServer = [[WebServer alloc] init];
    webServer.delegate = self;
    [webServer requestDataWithURL:[URL daPeiInfoURLWithParam:self.param]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)backItem:(UIBarButtonItem *)item {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.navigationController.isNavigationBarHidden) {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
}

#pragma mark - WebServerDelegate

- (void)webServerDidReceiveDataSuccess:(id)responseObject {
    NSString *imageURL = responseObject[@"big_pic"];
    
    __weak DaPeiInfoViewController *blockSelf = self;
    [self.headerView setImageUsingProgressViewRingWithURL:[NSURL URLWithString:imageURL] placeholderImage:nil options:SDWebImageRetryFailed progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (error) {
            blockSelf.headerView.image = [UIImage imageNamed:@"loading"];
        }
    } ProgressPrimaryColor:[UIColor lightGrayColor] ProgressSecondaryColor:nil Diameter:60];
    
    @autoreleasepool {
        for (NSDictionary *dic in responseObject[@"goods"]) {
            DaPeiInfoModel *model = [DaPeiInfoModel infoModel];
            [model setValuesForKeysWithDictionary:dic];
            [self.dataArray addObject:model];
        }
    }
    
    [self.tableView reloadData];
}

- (void)webServerDidReceiveDataFailure:(NSError *)error {
    //TODO: 网络连接失败
    NSLog(@"网络连接失败");
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
        cell.label.text = [NSString stringWithFormat:@"%@个人喜欢", self.loveNumber];
        return cell;
    }
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.section == 1 ? 57 : 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        DaPeiInfoModel *model = self.dataArray[indexPath.row];
        SBWebViewController *webViewController = [[SBWebViewController alloc] init];
        webViewController.url = [NSURL URLWithString:model.url];
        webViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:webViewController animated:YES];
    }
}

@end
