//
//  DaPeiInfoModel.m
//  EShopping
//
//  Created by 任龙宇 on 15/3/9.
//  Copyright (c) 2015年 renlongyu. All rights reserved.
//

#import "DaPeiInfoModel.h"

@implementation DaPeiInfoModel

- (NSDictionary *)undefineKeyMap {
    return @{@"now_price": @"nowPrice",
             @"num_iid": @"ID",
             @"small_pic": @"smallImageURL",
             };
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    [self setValue:value forKey:[self undefineKeyMap][key]];
}

@end
