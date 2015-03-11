//
//  DanPinCollectionViewCell+Configure.m
//  EShopping
//
//  Created by 任龙宇 on 15/3/10.
//  Copyright (c) 2015年 renlongyu. All rights reserved.
//

#import "DanPinCollectionViewCell+Configure.h"
#import "DanPinModel.h"
#import "UIImageView+SDWebImage_M13ProgressSuite.h"


@implementation DanPinCollectionViewCell (Configure)

- (void)configureCellWithModel:(DanPinModel *)model {
    [self.picView setImageUsingProgressViewRingWithURL:[NSURL URLWithString:model.img] placeholderImage:nil options:SDWebImageRetryFailed progress:nil completed:nil ProgressPrimaryColor:[UIColor grayColor] ProgressSecondaryColor:nil Diameter:40];
    
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@", model.price];
}

@end
