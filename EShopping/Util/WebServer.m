//
//  WebServer.m
//  EShopping
//
//  Created by 任龙宇 on 15/3/9.
//  Copyright (c) 2015年 renlongyu. All rights reserved.
//

#import "WebServer.h"
#import "AFNetworking.h"
#import "NZAlertView.h"

@implementation WebServer

- (void)requestDataWithURL:(NSURL *)url {
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    operation.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([_delegate respondsToSelector:@selector(webServerDidReceiveDataSuccess:)]) {
            [_delegate webServerDidReceiveDataSuccess:responseObject];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if ([_delegate respondsToSelector:@selector(webServerDidReceiveDataFailure:)]) {
            [_delegate webServerDidReceiveDataFailure:error];
        }
    }];
    
    [operation start];
}

+ (void)requestFailureAndShowAlert {
    NZAlertView *alertView = [[NZAlertView alloc] initWithStyle:NZAlertStyleError title:@"网络连接失败" message:@"请检查您的网络连接,并重新尝试"];
    [alertView show];
}


@end
