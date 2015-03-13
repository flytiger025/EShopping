//
//  ParallaxHeaderView.h
//  SBParallaxView
//
//  Created by 任龙宇 on 15/3/13.
//  Copyright (c) 2015年 renlongyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ParallaxHeaderView : UIView

@property (nonatomic, strong) UIImage *headerImage;
@property (nonatomic, strong) UILabel *headerTitleLabel;

+ (ParallaxHeaderView *)parallaxHeaderViewWithImage:(UIImage *)image forSize:(CGSize)size;

- (void)layoutHeaderViewForScrollViewOffset:(CGPoint)offset;

@end
