//
//  WebServer.m
//  EShopping
//
//  Created by 任龙宇 on 15/3/9.
//  Copyright (c) 2015年 renlongyu. All rights reserved.
//

#import "WebServer.h"
#import "AFNetworking.h"

@implementation WebServer

+ (void)requestDataWithURL:(NSString *)url success:(void(^)(NSArray *data))success failure:(void(^)(NSError *error))failure {
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] init];
    operation.
}

@end
