//
//  DaPeiModel.m
//  EShopping
//
//  Created by 任龙宇 on 15/3/9.
//  Copyright (c) 2015年 renlongyu. All rights reserved.
//

#import "DaPeiModel.h"

@implementation DaPeiModel

- (NSDictionary *)undefineKeyMap {
    return @{@"goods_num": @"goodsNumber",
             @"love_num": @"loveNumber",
             @"pic_height": @"imageHeight",
             @"pic_width": @"imageWidth",
             @"pic_url": @"imageURL"
             };
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    [self setValue:value forKey:[self undefineKeyMap][key]];    
}


@end
