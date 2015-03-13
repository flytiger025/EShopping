//
//  ParallaxHeaderView.m
//  SBParallaxView
//
//  Created by 任龙宇 on 15/3/13.
//  Copyright (c) 2015年 renlongyu. All rights reserved.
//

#import "ParallaxHeaderView.h"

@interface ParallaxHeaderView ()

@property (nonatomic, weak) UIScrollView *imageScrollView;
@property (nonatomic, weak) UIImageView *imageView;

@end


#define kDefaultHeaderFrame CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)

static CGFloat kParallaxDeltaFactor = 0.5f;
static CGFloat kLabelPaddingDist = 8.0f;


@implementation ParallaxHeaderView

+ (ParallaxHeaderView *)parallaxHeaderViewWithImage:(UIImage *)image forSize:(CGSize)size {
    ParallaxHeaderView *headerView = [[ParallaxHeaderView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    headerView.headerImage = image;
    [headerView initialSetupForDefaultHeader];
    return headerView;
}

- (void)initialSetupForDefaultHeader {
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    _imageScrollView = scrollView;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:_imageScrollView.bounds];
    imageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin |
                                 UIViewAutoresizingFlexibleWidth |
                                 UIViewAutoresizingFlexibleRightMargin |
                                 UIViewAutoresizingFlexibleTopMargin |
                                 UIViewAutoresizingFlexibleHeight |
                                 UIViewAutoresizingFlexibleBottomMargin;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.image = _headerImage;
    _imageView = imageView;
    [_imageScrollView addSubview:_imageView];
    
    [self addSubview:_imageScrollView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:
                      CGRectMake(0, 0,
                                 _imageScrollView.frame.size.width - 2 * kLabelPaddingDist,
                                 _imageScrollView.frame.size.height - 2 * kLabelPaddingDist)];
    
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.autoresizingMask = _imageView.autoresizingMask;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont boldSystemFontOfSize:15];
    self.headerTitleLabel = label;
    
    [self addSubview:_headerTitleLabel];
}

- (void)layoutHeaderViewForScrollViewOffset:(CGPoint)offset {
    CGRect frame = _imageScrollView.frame;
    if (offset.y > 0) {
        frame.origin.y = offset.y * kParallaxDeltaFactor;
        _imageScrollView.frame = frame;
        self.clipsToBounds = YES;
    } else {
        CGFloat delta = 0.0f;
        CGRect rect = kDefaultHeaderFrame;
        delta = fabsf(offset.y);
        rect.origin.y -= delta;
        rect.size.height += delta;
        _imageScrollView.frame = rect;
        self.clipsToBounds = NO;
    }
}

- (void)setHeaderImage:(UIImage *)headerImage {
    _headerImage = headerImage;
    _imageView.image = _headerImage;
}


@end
