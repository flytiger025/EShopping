//
//  JKJModel.m
//  EShopping
//
//  Created by 任龙宇 on 15/3/10.
//  Copyright (c) 2015年 renlongyu. All rights reserved.
//

#import "BanJiaModel.h"

@implementation BanJiaModel

- (NSDictionary *)undefinedKeyMap {
    return @{@"deal_num": @"dealNumber",
             @"is_onsale": @"isOnsale",
             @"is_vip_price": @"isVipPrice",
             @"now_price": @"nowPrice",
             @"num_iid": @"numID",
             @"origin_price": @"originPrice",
             @"pic_url": @"picURL",
             @"show_time": @"showTime",
             @"start_discount": @"startDiscount",
             @"total_love_number": @"loveNumber"
             };
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    [self setValue:value forKey:[self undefinedKeyMap][key]];
}

+ (BanJiaModel *)model {
    return [[BanJiaModel alloc] init];
}

@end
