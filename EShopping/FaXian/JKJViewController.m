//
//  JKJViewController.m
//  EShopping
//
//  Created by 任龙宇 on 15/3/10.
//  Copyright (c) 2015年 renlongyu. All rights reserved.
//

#import "JKJViewController.h"
#import "WaterfallCollectionViewLayout.h"
#import "WebServer.h"
#import "URL.h"
#import "JKJCollectionViewCell+Configure.h"
#import "JKJModel.h"
#import "Macro.h"
#import "SBWebViewController.h"
#import "MJRefresh.h"

static NSString * const JKJCellIdentifier = @"JKJCollectionViewCell";

@interface JKJViewController () <UICollectionViewDataSource, UICollectionViewDelegate, WaterfallCollectionViewLayoutDelegate, WebServerDelegate>

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) BOOL isHeaderRefreshing;

@end

@implementation JKJViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    // Do any additional setup after loading the view.
    self.dataArray = [NSMutableArray array];
    
    self.waterfallView.dataSource = self;
    self.waterfallView.delegate = self;
    WaterfallCollectionViewLayout *layout = (WaterfallCollectionViewLayout *)self.waterfallView.collectionViewLayout;
    layout.delegate = self;
    
    [self.waterfallView registerNib:[UINib nibWithNibName:JKJCellIdentifier bundle:nil] forCellWithReuseIdentifier:JKJCellIdentifier];
    
    [self.waterfallView addHeaderWithTarget:self action:@selector(headerRereshing)];
    [self.waterfallView addFooterWithTarget:self action:@selector(fooderRefreshing)];
    [self.waterfallView headerBeginRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Refresh

- (void)webServerRequestData {
    WebServer *webServer = [[WebServer alloc] init];
    webServer.delegate = self;
    [webServer requestDataWithURL:[URL jiuKuaiJiuURL]];
}

- (void)headerRereshing {
    self.isHeaderRefreshing = YES;
    [self webServerRequestData];
}

- (void)fooderRefreshing {
    self.isHeaderRefreshing = NO;
//    [self webServerRequestData];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.waterfallView footerEndRefreshing];
    });
}

- (void)headerFooterEndRefreshing {
    if (self.waterfallView.headerRefreshing) {
        [self.waterfallView headerEndRefreshing];
    }
    
    if (self.waterfallView.footerRefreshing) {
        [self.waterfallView footerEndRefreshing];
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
            JKJModel *model = [JKJModel model];
            [model setValuesForKeysWithDictionary:dic];
            [self.dataArray addObject:model];
        }
    }
    
    [self headerFooterEndRefreshing];
    [self.waterfallView reloadData];
}

- (void)webServerDidReceiveDataFailure:(NSError *)error {
    [self headerFooterEndRefreshing];
    [WebServer requestFailureAndShowAlert];
}


#pragma mark - WaterfallCollectionViewLayoutDelegate

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(WaterfallCollectionViewLayout *)collectionViewLayout heightForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger width = COLLECTION_CELL_WIDTH;
    return 1.6 * width;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JKJCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:JKJCellIdentifier forIndexPath:indexPath];
    JKJModel *model = self.dataArray[indexPath.row];
    [cell configureWithModel:model];
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    JKJModel *model = self.dataArray[indexPath.row];
    SBWebViewController *webViewController = [[SBWebViewController alloc] init];
    webViewController.url = [URL faXianURLWithNumID:model.numID];
    webViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:webViewController animated:YES];
}


@end
