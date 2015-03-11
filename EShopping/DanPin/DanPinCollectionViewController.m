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

static NSString * const danPinCellIdentifier = @"DanPinCollectionViewCell";

@interface DanPinCollectionViewController () <UICollectionViewDataSource, UICollectionViewDelegate, WaterfallCollectionViewLayoutDelegate, WebServerDelegate>

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) NSInteger currentPage;

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
    
    [self.waterfallView registerNib:[UINib nibWithNibName:danPinCellIdentifier bundle:nil] forCellWithReuseIdentifier:danPinCellIdentifier];
    
    WebServer *webServer = [[WebServer alloc] init];
    webServer.delegate = self;
    [webServer requestDataWithURL:[URL danPinCategoryURLWithCid:self.category page:_currentPage]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - WebServerDelegate

- (void)webServerDidReceiveDataSuccess:(id)responseObject {
    @autoreleasepool {
        for (NSDictionary *dic in responseObject[@"data"]) {
            DanPinModel *model = [DanPinModel model];
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
    //TODO: 单品cell点击事件
    NSLog(@"-----");
}
@end
