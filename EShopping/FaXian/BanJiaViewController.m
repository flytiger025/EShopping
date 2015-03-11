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

static NSString * const banJiaCellIdentifier = @"BanJiaTableViewCell";

@interface BanJiaViewController () <WebServerDelegate>

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation BanJiaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor colorWithRed:0.949 green:0.949 blue:0.937 alpha:1];
    
    self.dataArray = [NSMutableArray array];

    [self.tableView registerNib:[UINib nibWithNibName:banJiaCellIdentifier bundle:nil] forCellReuseIdentifier:banJiaCellIdentifier];
    
    WebServer *webServer = [[WebServer alloc] init];
    webServer.delegate = self;
    [webServer requestDataWithURL:[URL banJiaURL]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - WebServerDelegate

- (void)webServerDidReceiveDataSuccess:(id)responseObject {
    @autoreleasepool {
        for (NSDictionary *dic in responseObject[@"list"]) {
            BanJiaModel *model = [BanJiaModel model];
            [model setValuesForKeysWithDictionary:dic];
            [self.dataArray addObject:model];
        }
    }
    [self.tableView reloadData];
}

- (void)webServerDidReceiveDataFailure:(NSError *)error {
    //TODO: 半价网络错误处理
    NSLog(@"网络错误");
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
    webViewController.url = [URL faXianURLWithNumID:model.numID];
    webViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:webViewController animated:YES];
}


@end
