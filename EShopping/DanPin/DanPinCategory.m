//
//  DanPinCategory.m
//  EShopping
//
//  Created by 任龙宇 on 15/3/10.
//  Copyright (c) 2015年 renlongyu. All rights reserved.
//

#import "DanPinCategory.h"

@implementation DanPinCategory

- (NSDictionary *)undefineKeyMap {
    return @{@"catId": @"ID",
             @"catName": @"name",
             };
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    [super setValue:value forKey:[self undefineKeyMap][key]];
}

@end
