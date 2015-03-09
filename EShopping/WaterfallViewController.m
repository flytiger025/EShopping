//
//  WaterfallViewController.m
//  EShopping
//
//  Created by 任龙宇 on 15/3/7.
//  Copyright (c) 2015年 renlongyu. All rights reserved.
//

#import "WaterfallViewController.h"
#import "WaterfallCollectionViewLayout.h"
#import "WaterfallCollectionViewCell.h"

static NSString *cellIdentifier = @"WaterfallCollectionViewCell";

@interface WaterfallViewController () <UICollectionViewDelegate, UICollectionViewDataSource, WaterfallCollectionViewLayoutDelegate>

@property (nonatomic, weak) UICollectionView *waterfallView;

@end

@implementation WaterfallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)loadView {
    [super loadView];
    if (_waterfallView == nil) {
        WaterfallCollectionViewLayout *layout = [[WaterfallCollectionViewLayout alloc] init];
        layout.columnCount = 2;
        layout.itemWidth = ([UIScreen mainScreen].bounds.size.width - 30) / 2;
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        layout.delegate = self;
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:[[UIScreen mainScreen] bounds] collectionViewLayout:layout];
        collectionView.backgroundColor = [UIColor colorWithRed:0.949 green:0.949 blue:0.937 alpha:1];
        collectionView.dataSource = self;
        _waterfallView.delegate = self;
        [collectionView registerNib:[UINib nibWithNibName:cellIdentifier bundle:nil] forCellWithReuseIdentifier:cellIdentifier];
        _waterfallView = collectionView;
        self.view = collectionView;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - WaterfallCollectionViewLayoutDelegate

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(WaterfallCollectionViewLayout *)collectionViewLayout heightForItemAtIndexPath:(NSIndexPath *)indexPath {
    return arc4random() % 150 + 100;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 30;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WaterfallCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 255. green:arc4random() % 256 / 255. blue:arc4random() % 256 / 255. alpha:1.];
    return cell;
}

#pragma mark - UICollectionViewDelegate

@end
