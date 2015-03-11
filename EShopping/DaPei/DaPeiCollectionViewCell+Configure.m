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



@implementation DaPeiCollectionViewCell (Configure)

- (void)configureCellWithDaPeiModel:(DaPeiModel *)daPeiModel {
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:daPeiModel.imageURL] placeholderImage:nil options:SDWebImageRetryFailed];
    self.goodsLabel.text = [NSString stringWithFormat:@"%@", daPeiModel.goodsNumber];
    self.loveLabel.text = [NSString stringWithFormat:@"%@", daPeiModel.loveNumber];
    self.titleLabel.text = [NSString stringWithFormat:@"%@", daPeiModel.title];
}

@end
