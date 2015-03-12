//
//  BanJiaTableViewCell+Configure.m
//  EShopping
//
//  Created by 任龙宇 on 15/3/11.
//  Copyright (c) 2015年 renlongyu. All rights reserved.
//

#import "BanJiaTableViewCell+Configure.h"
#import "BanJiaModel.h"
#import "UIImageView+WebCache.h"
#import "NSString+Strikethrough.h"

@implementation BanJiaTableViewCell (Configure)

- (void)configureCellWithModel:(BanJiaModel *)model {
    [self.picView sd_setImageWithURL:[NSURL URLWithString:model.picURL] placeholderImage:nil options:SDWebImageRetryFailed];
    self.titleLabel.text = model.title;
    self.nowPriceLabel.text = [NSString stringWithFormat:@"￥%.1f", [model.nowPrice floatValue]];
    NSString *string = [NSString stringWithFormat:@"￥%.1f", [model.originPrice floatValue]];
    self.originPriceLabel.attributedText = [string attributedStringWithStrikethrough];
    self.discountLabel.text = [NSString stringWithFormat:@"%@折", model.discount];
}

@end
