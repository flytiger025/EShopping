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
    [self.picView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:nil options:SDWebImageRetryFailed];
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@", model.price];
}

@end
