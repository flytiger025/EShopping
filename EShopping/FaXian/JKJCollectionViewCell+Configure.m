//
//  JKJCollectionViewCell+Configure.m
//  EShopping
//
//  Created by 任龙宇 on 15/3/11.
//  Copyright (c) 2015年 renlongyu. All rights reserved.
//

#import "JKJCollectionViewCell+Configure.h"
#import "JKJModel.h"
#import "UIImageView+WebCache.h"
#import "NSString+Strikethrough.h"

@implementation JKJCollectionViewCell (Configure)

- (void)configureWithModel:(JKJModel *)model {
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.picURL]
                      placeholderImage:nil
                               options:SDWebImageRetryFailed];
    
    self.nowPriceLabel.text = [NSString stringWithFormat:@"￥%.1f", [model.nowPrice floatValue]];
    NSString *string = [NSString stringWithFormat:@"￥%.1f", [model.originPrice floatValue]];
    self.originPriceLabel.attributedText = [string attributedStringWithStrikethrough];
}

@end
