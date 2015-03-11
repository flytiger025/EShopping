//
//  BanJiaModel.m
//  EShopping
//
//  Created by 任龙宇 on 15/3/10.
//  Copyright (c) 2015年 renlongyu. All rights reserved.
//

#import "JKJModel.h"

@implementation JKJModel

+ (JKJModel *)model {
    return [[JKJModel alloc] init];
}

- (NSDictionary *)jkj_undefinedKeyMap {
    return @{@"is_buy_sale": @"isBuySale",
             @"ling_value": @"lingValue",
             @"qiangpai": @"qiangPai",
             @"total_hate_number": @"hateNumber"
             };
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)undefinedKey {
    NSString *key = [self jkj_undefinedKeyMap][undefinedKey];
    if (key) {
        [self setValue:value forKey:key];
    } else {
        [super setValue:value forUndefinedKey:undefinedKey];
    }    
}

@end
