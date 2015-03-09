//
//  API.m
//  EShopping
//
//  Created by 任龙宇 on 15/3/9.
//  Copyright (c) 2015年 renlongyu. All rights reserved.
//

#import "API.h"

@implementation API

+ (NSURL *)daPeiURL {
    return [NSURL URLWithString:@"http://zhekou.yijia.com/lws/view/ichuanyi/title_dapei.php"];
}

+ (NSURL *)daPeiCatagoryURLWithCid:(NSString *)cid page:(NSInteger)page {
    NSString *urlString = [NSString stringWithFormat:@"http://zhekou.yijia.com/lws/view/ichuanyi/suit_list_data_get.php?cid=%@&page=%d", cid, page];
    return [NSURL URLWithString:urlString];
}

+ (NSURL *)daPeiInfoURLWithParam:(NSNumber *)param {
    NSString *urlString = [NSString stringWithFormat:@"http://zhekou.yijia.com/lws/view/ichuanyi/suit_data_get.php?param=%@", param];
    return [NSURL URLWithString:urlString];
}

@end
