//
//  DanPinCollectionViewCell+Configure.m
//  EShopping
//
//  Created by 任龙宇 on 15/3/10.
//  Copyright (c) 2015年 renlongyu. All rights reserved.
//

#import "DanPinCollectionViewCell+Configure.h"
#import "DanPinModel.h"
#import "UIImageView+WebCache.h"


@implementation DanPinCollectionViewCell (Configure)

- (void)configureCellWithModel:(DanPinModel *)model {
    __weak DanPinCollectionViewCell *weakSelf = self;
    [self.picView sd_setImageWithURL:[NSURL URLWithString:model.img]
                    placeholderImage:nil
                             options:SDWebImageRetryFailed
                           completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
    {
        weakSelf.priceLabel.text = [NSString stringWithFormat:@"￥%@", model.price];
    }];
}

@end
