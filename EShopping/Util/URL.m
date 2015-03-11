//
//  API.m
//  EShopping
//
//  Created by 任龙宇 on 15/3/9.
//  Copyright (c) 2015年 renlongyu. All rights reserved.
//

#import "URL.h"

@implementation URL

#pragma mark -

+ (NSURL *)daPeiURL {
    return [NSURL URLWithString:@"http://zhekou.yijia.com/lws/view/ichuanyi/title_dapei.php"];
}

+ (NSURL *)daPeiCategoryURLWithCid:(NSString *)cid page:(NSInteger)page {
    NSString *urlString = [NSString stringWithFormat:@"http://zhekou.yijia.com/lws/view/ichuanyi/suit_list_data_get.php?cid=%@&page=%@", cid, @(page)];
    return [NSURL URLWithString:urlString];
}

+ (NSURL *)daPeiInfoURLWithParam:(NSNumber *)param {
    NSString *urlString = [NSString stringWithFormat:@"http://zhekou.yijia.com/lws/view/ichuanyi/suit_data_get.php?param=%@", param];
    return [NSURL URLWithString:urlString];
}


#pragma mark -

+ (NSURL *)danPinURL {
    return [NSURL URLWithString:@"http://zhekou.repai.com/lws/view/zhou_nvtit.php"];
}

+ (NSURL *)danPinCategoryURLWithCid:(NSString *)cid page:(NSInteger)page{
    NSString *urlString = [NSString stringWithFormat:@"http://zhekou.repai.com/lws/view/zhou_nvcon.php?page=%@&pagesize=30&catid=%@", @(page), cid];
    return [NSURL URLWithString:urlString];
}


#pragma mark -

+ (NSURL *)jiuKuaiJiuURL {
    return [NSURL URLWithString:@"http://jkjby.yijia.com/jkjby/view/list_api.php"];
}

+ (NSURL *)banJiaURL {
    return [NSURL URLWithString:@"http://jkjby.repai.com/jkjby/view/tmzk19_9_api.php?cid=0"];
}

#pragma mark - 

+ (NSURL *)faXianURLWithNumID:(NSString *)numID {
    NSString *urlString = [NSString stringWithFormat:@"http://cloud.yijia.com/goto/item.php?app_channel=appstore&id=%@&sche=aizhuangban", numID];
    return [NSURL URLWithString:urlString];
}

@end
