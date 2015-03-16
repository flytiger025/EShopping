//
//  BanJiaViewController.m
//  EShopping
//
//  Created by 任龙宇 on 15/3/11.
//  Copyright (c) 2015年 renlongyu. All rights reserved.
//

#import "BanJiaViewController.h"
#import "BanJiaTableViewCell.h"
#import "BanJiaTableViewCell+Configure.h"
#import "WebServer.h"
#import "URL.h"
#import "BanJiaModel.h"
#import "SBWebViewController.h"
#import "MJRefresh.h"

static NSString * const banJiaCellIdentifier = @"BanJiaTableViewCell";

@interface BanJiaViewController () <WebServerDelegate>

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) BOOL isHeaderRefreshing;

@end

@implementation BanJiaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;

    self.tableView.backgroundColor = [UIColor colorWithRed:0.949 green:0.949 blue:0.937 alpha:1];
    
    self.dataArray = [NSMutableArray array];

    [self.tableView registerNib:[UINib nibWithNibName:banJiaCellIdentifier bundle:nil] forCellReuseIdentifier:banJiaCellIdentifier];
    
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    [self.tableView addFooterWithTarget:self action:@selector(fooderRefreshing)];
    [self.tableView headerBeginRefreshing];
    
    WebServer *webServer = [[WebServer alloc] init];
    webServer.delegate = self;
    [webServer requestDataWithURL:[URL banJiaURL]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Refresh

- (void)webServerRequestData {
    WebServer *webServer = [[WebServer alloc] init];
    webServer.delegate = self;
    [webServer requestDataWithURL:[URL banJiaURL]];
}

- (void)headerRereshing {
    self.isHeaderRefreshing = YES;
    [self webServerRequestData];
}

- (void)fooderRefreshing {
    self.isHeaderRefreshing = NO;
//    [self webServerRequestData];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView footerEndRefreshing];
    });
}

- (void)headerFooterEndRefreshing {
    if (self.tableView.headerRefreshing) {
        [self.tableView headerEndRefreshing];
    }
    
    if (self.tableView.footerRefreshing) {
        [self.tableView footerEndRefreshing];
    }
}


#pragma mark - WebServerDelegate

- (void)webServerDidReceiveDataSuccess:(id)responseObject {
    if ([responseObject[@"list"] isEqual:[NSNull null]]) {
        [self webServerDidReceiveDataFailure:nil];
        return;
    }
    
    if (self.isHeaderRefreshing) {
        [self.dataArray removeAllObjects];
    }

    @autoreleasepool {
        for (NSDictionary *dic in responseObject[@"list"]) {
            BanJiaModel *model = [BanJiaModel model];
            [model setValuesForKeysWithDictionary:dic];
            [self.dataArray addObject:model];
        }
    }
    
    [self headerFooterEndRefreshing];
    [self.tableView reloadData];
}

- (void)webServerDidReceiveDataFailure:(NSError *)error {
    [self headerFooterEndRefreshing];
    [WebServer requestFailureAndShowAlert];
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BanJiaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:banJiaCellIdentifier forIndexPath:indexPath];
    BanJiaModel *model = self.dataArray[indexPath.row];
    [cell configureCellWithModel:model];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BanJiaModel *model = self.dataArray[indexPath.row];
    SBWebViewController *webViewController = [[SBWebViewController alloc] init];
    webViewController.url = [URL faxianURLWithNumID:model.numID];
    webViewController.desc = model.title;
    webViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:webViewController animated:YES];
}


@end
