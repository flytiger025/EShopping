//
//  DaPeiInfoTableViewCell+Configure.m
//  EShopping
//
//  Created by 任龙宇 on 15/3/11.
//  Copyright (c) 2015年 renlongyu. All rights reserved.
//

#import "DaPeiInfoTableViewCell+Configure.h"
#import "DaPeiInfoModel.h"
#import "UIImageView+WebCache.h"

@implementation DaPeiInfoTableViewCell (Configure)

- (void)configuredCellWithModel:(DaPeiInfoModel *)model {
    [self.picView sd_setImageWithURL:[NSURL URLWithString:model.smallImageURL] placeholderImage:nil options:SDWebImageRetryFailed];
    self.titleLabel.text = model.title;
    self.priceLabel.text = [NSString stringWithFormat:@"￥%.f", [model.nowPrice floatValue]];
}

@end
