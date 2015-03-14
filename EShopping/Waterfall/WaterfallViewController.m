//
//  WaterfallViewController.m
//  EShopping
//
//  Created by 任龙宇 on 15/3/7.
//  Copyright (c) 2015年 renlongyu. All rights reserved.
//

#import "WaterfallViewController.h"
#import "WaterfallCollectionViewLayout.h"
#import "DaPeiCollectionViewController.h"
#import "Macro.h"

static NSString * const daPeiCell = @"DaPeiCollectionViewCell";
static NSString * const danPinCell = @"DanPinCollectionViewCell";
static NSString * const faXianCell = @"FaXianCollectionViewCell";

@interface WaterfallViewController () <UIScrollViewDelegate>

@property (nonatomic, assign) ViewControllerType type;

@property (nonatomic, weak, readwrite) UICollectionView *waterfallView;

@end

@implementation WaterfallViewController

+ (WaterfallViewController *)viewControllerWithType:(ViewControllerType)type {
    switch (type) {
        case ViewControllerTypeDaPei:
        {
            DaPeiCollectionViewController *viewController = [[DaPeiCollectionViewController alloc] init];
            viewController.type = type;
            return viewController;
        }
            
        case ViewControllerTypeDanPin:
        {
            DaPeiCollectionViewController *viewController = [[DaPeiCollectionViewController alloc] init];
            viewController.type = type;
            return viewController;
        }
            
        case ViewControllerTypeFaXian:
        {
            DaPeiCollectionViewController *viewController = [[DaPeiCollectionViewController alloc] init];
            viewController.type = type;
            return viewController;
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor colorWithRed:0.949 green:0.949 blue:0.937 alpha:1];
    
    [self waterfallView];    
}

- (UICollectionView *)waterfallView {
    if (_waterfallView == nil) {
        WaterfallCollectionViewLayout *layout = [[WaterfallCollectionViewLayout alloc] init];
        layout.columnCount = COLLECTION_COLUMN_COUNT;
        layout.itemWidth = COLLECTION_CELL_WIDTH;
        layout.sectionInset = UIEdgeInsetsMake(5, 10, 15, 10);
        CGRect frame = self.view.frame;
        frame.size.height -= (UI_NAVIGATION_HEIGHT + UI_TABBAR_HEIGHT);
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
        collectionView.backgroundColor = [UIColor colorWithRed:0.949 green:0.949 blue:0.937 alpha:1];
        [self.view addSubview:_waterfallView = collectionView];
        [collectionView registerNib:[UINib nibWithNibName:[self cellIdentifier] bundle:nil] forCellWithReuseIdentifier:[self cellIdentifier]];
    }
    return _waterfallView;
}

- (NSString *)cellIdentifier {
    switch (_type) {
        case ViewControllerTypeDaPei:
            return daPeiCell;
            
        case ViewControllerTypeDanPin:
            return danPinCell;
            
        case ViewControllerTypeFaXian:
            return faXianCell;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
