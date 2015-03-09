//
//  WaterfallCollectionViewLayout.h
//  Waterfall
//
//  Created by 任龙宇 on 15/3/7.
//  Copyright (c) 2015年 renlongyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WaterfallCollectionViewLayout;

@protocol WaterfallCollectionViewLayoutDelegate <UICollectionViewDelegate>

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(WaterfallCollectionViewLayout *)collectionViewLayout heightForItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface WaterfallCollectionViewLayout : UICollectionViewLayout

@property (nonatomic, assign) id<WaterfallCollectionViewLayoutDelegate> delegate;
@property (nonatomic, assign) NSInteger columnCount;
@property (nonatomic, assign) CGFloat itemWidth;
@property (nonatomic, assign) UIEdgeInsets sectionInset;

@end
