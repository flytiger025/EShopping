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

static NSString * const JKJCellIdentifier = @"JKJCollectionViewCell";

@interface JKJViewController () <UICollectionViewDataSource, UICollectionViewDelegate, WaterfallCollectionViewLayoutDelegate, WebServerDelegate>

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation JKJViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataArray = [NSMutableArray array];
    
    self.waterfallView.dataSource = self;
    self.waterfallView.delegate = self;
    WaterfallCollectionViewLayout *layout = (WaterfallCollectionViewLayout *)self.waterfallView.collectionViewLayout;
    layout.delegate = self;
    
    [self.waterfallView registerNib:[UINib nibWithNibName:JKJCellIdentifier bundle:nil] forCellWithReuseIdentifier:JKJCellIdentifier];
    
    WebServer *webServer = [[WebServer alloc] init];
    webServer.delegate = self;
    [webServer requestDataWithURL:[URL jiuKuaiJiuURL]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - WebServerDelegate

- (void)webServerDidReceiveDataSuccess:(id)responseObject {
    @autoreleasepool {
        for (NSDictionary *dic in responseObject[@"list"]) {
            JKJModel *model = [JKJModel model];
            [model setValuesForKeysWithDictionary:dic];
            [self.dataArray addObject:model];
        }
    }
    
    [self.waterfallView reloadData];
}

- (void)webServerDidReceiveDataFailure:(NSError *)error {
    //TODO: 网络连接错误
    NSLog(@"网络连接错误");
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
