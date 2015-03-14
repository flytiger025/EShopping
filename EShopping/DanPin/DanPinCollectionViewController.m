//
//  DanPinCollectionViewController.m
//  EShopping
//
//  Created by 任龙宇 on 15/3/10.
//  Copyright (c) 2015年 renlongyu. All rights reserved.
//

#import "DanPinCollectionViewController.h"
#import "WaterfallCollectionViewLayout.h"
#import "Macro.h"
#import "DanPinCollectionViewCell+Configure.h"
#import "WebServer.h"
#import "URL.h"
#import "DanPinModel.h"
#import "SBWebViewController.h"
#import "MJRefresh.h"

static NSString * const danPinCellIdentifier = @"DanPinCollectionViewCell";

@interface DanPinCollectionViewController () <UICollectionViewDataSource, UICollectionViewDelegate, WaterfallCollectionViewLayoutDelegate, WebServerDelegate>

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, assign) BOOL isHeaderRefreshing;
@property (nonatomic, strong) NSMutableArray *cellHeightArray;

@end

@implementation DanPinCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dataArray = [NSMutableArray array];
    self.currentPage = 1;
    
    self.waterfallView.dataSource = self;
    self.waterfallView.delegate = self;
    WaterfallCollectionViewLayout *layout = (WaterfallCollectionViewLayout *)self.waterfallView.collectionViewLayout;
    layout.delegate = self;
    
    CGRect frame = self.waterfallView.frame;
    frame.size.height -= NAV_TAB_BAR_HEIGHT;
    self.waterfallView.frame = frame;
    
    [self.waterfallView registerNib:[UINib nibWithNibName:danPinCellIdentifier bundle:nil] forCellWithReuseIdentifier:danPinCellIdentifier];
    
    [self.waterfallView addHeaderWithTarget:self action:@selector(headerRereshing)];
    [self.waterfallView addFooterWithTarget:self action:@selector(fooderRefreshing)];

    [self webServerRequestData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Refresh

- (void)webServerRequestData {
    WebServer *webServer = [[WebServer alloc] init];
    webServer.delegate = self;
    [webServer requestDataWithURL:[URL danPinCategoryURLWithCid:self.category page:_currentPage]];
}

- (void)headerRereshing {
    self.isHeaderRefreshing = YES;
    self.currentPage = 1;
    [self webServerRequestData];
}

- (void)fooderRefreshing {
    self.isHeaderRefreshing = NO;
    self.currentPage++;
    [self webServerRequestData];
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
    if ([responseObject[@"data"] isEqual:[NSNull null]]) {
        [self webServerDidReceiveDataFailure:nil];
        return;
    }
    
    if (self.isHeaderRefreshing) {
        [self.dataArray removeAllObjects];
    }

    @autoreleasepool {
        for (NSDictionary *dic in responseObject[@"data"]) {
            DanPinModel *model = [DanPinModel model];
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
    return width + width/3.0 + arc4random() % (width / 3);
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DanPinCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:danPinCellIdentifier forIndexPath:indexPath];
    
    DanPinModel *model = self.dataArray[indexPath.row];
    [cell configureCellWithModel:model];
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    DanPinModel *model = self.dataArray[indexPath.row];
    SBWebViewController *webViewController = [[SBWebViewController alloc] init];
    webViewController.url = [NSURL URLWithString:model.url];
    webViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:webViewController animated:YES];
}

@end
