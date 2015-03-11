//
//  BanJiaModel.m
//  EShopping
//
//  Created by 任龙宇 on 15/3/10.
//  Copyright (c) 2015年 renlongyu. All rights reserved.
//

#import "BanJiaModel.h"

@implementation BanJiaModel

- (NSDictionary *)undefinedKeyMap {
    return @{@"is_buy_sale": @"isBuySale",
             @"ling_value": @"lingValue",
             @"qiangpai": @"qiangPai",
             @"total_hate_number": @"hateNumber"
             };
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    [self setValue:value forKey:[self undefinedKeyMap][key]];
}

@end
