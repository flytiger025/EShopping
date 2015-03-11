//
//  DaPeiCollectionViewController.m
//  EShopping
//
//  Created by 任龙宇 on 15/3/9.
//  Copyright (c) 2015年 renlongyu. All rights reserved.
//

#import "DaPeiCollectionViewController.h"
#import "WaterfallCollectionViewLayout.h"
#import "DaPeiCollectionViewCell+Configure.h"
#import "WebServer.h"
#import "URL.h"
#import "DaPeiModel.h"
#import "Macro.h"
#import "DaPeiInfoViewController.h"

@interface DaPeiCollectionViewController () <UICollectionViewDataSource, UICollectionViewDelegate, WaterfallCollectionViewLayoutDelegate, WebServerDelegate>

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) NSInteger currentPage;

@end

@implementation DaPeiCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        
    self.dataArray = [NSMutableArray array];
    self.currentPage = 1;

    self.waterfallView.dataSource = self;
    self.waterfallView.delegate = self;
    WaterfallCollectionViewLayout *layout = (WaterfallCollectionViewLayout *)self.waterfallView.collectionViewLayout;
    layout.delegate = self;
    
    WebServer *webServer = [[WebServer alloc] init];
    webServer.delegate = self;
    [webServer requestDataWithURL:[URL daPeiCategoryURLWithCid:self.category page:_currentPage]];    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.navigationController.isNavigationBarHidden) {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        self.navigationController.hidesBarsOnSwipe = NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - WebServerDelegate

- (void)webServerDidReceiveDataSuccess:(id)responseObject {
    @autoreleasepool {
        for (NSDictionary *dic in responseObject[@"content"]) {
            DaPeiModel *model = [DaPeiModel model];
            [model setValuesForKeysWithDictionary:dic];
            [self.dataArray addObject:model];
        }
    }
    
    [self.waterfallView reloadData];
}

- (void)webServerDidReceiveDataFailure:(NSError *)error {
    NSLog(@"%@", error);
    //TODO: 网络错误处理
}

#pragma mark - WaterfallCollectionViewLayoutDelegate

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(WaterfallCollectionViewLayout *)collectionViewLayout heightForItemAtIndexPath:(NSIndexPath *)indexPath {
    DaPeiModel *model = self.dataArray[indexPath.row];
    CGFloat imageHeight = model.imageHeight.floatValue / model.imageWidth.floatValue * COLLECTION_CELL_WIDTH;
    return imageHeight + 64;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DaPeiCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[self cellIdentifier] forIndexPath:indexPath];
    DaPeiModel *model = self.dataArray[indexPath.row];
    [cell configureCellWithDaPeiModel:model];
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    DaPeiInfoViewController *viewController = [[DaPeiInfoViewController alloc] init];
    viewController.hidesBottomBarWhenPushed = YES;
    DaPeiModel *model = self.dataArray[indexPath.row];
    viewController.param = model.param;
    viewController.loveNumber = model.loveNumber;
    [self.navigationController pushViewController:viewController animated:YES];
}


@end
