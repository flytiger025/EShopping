//
//  DaPeiCollectionViewCell+Configure.m
//  EShopping
//
//  Created by 任龙宇 on 15/3/9.
//  Copyright (c) 2015年 renlongyu. All rights reserved.
//

#import "DaPeiCollectionViewCell+Configure.h"
#import "DaPeiModel.h"
#import "UIImageView+WebCache.h"
#import "UIImageView+SDWebImage_M13ProgressSuite.h"


@implementation DaPeiCollectionViewCell (Configure)

- (void)configureCellWithDaPeiModel:(DaPeiModel *)daPeiModel {
    [self.imageView setImageUsingProgressViewRingWithURL:[NSURL URLWithString:daPeiModel.imageURL] placeholderImage:nil options:SDWebImageRetryFailed progress:nil completed:nil ProgressPrimaryColor:[UIColor grayColor] ProgressSecondaryColor:nil Diameter:40];
    
    self.goodsLabel.text = [NSString stringWithFormat:@"%@", daPeiModel.goodsNumber];
    self.loveLabel.text = [NSString stringWithFormat:@"%@", daPeiModel.loveNumber];
    self.titleLabel.text = [NSString stringWithFormat:@"%@", daPeiModel.title];
}

@end
