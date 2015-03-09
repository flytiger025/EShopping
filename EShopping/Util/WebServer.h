//
//  WebServer.h
//  EShopping
//
//  Created by 任龙宇 on 15/3/9.
//  Copyright (c) 2015年 renlongyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WebServer : NSObject

+ (void)requestDataWithURL:(NSString *)url success:(void(^)(NSArray *data))success failure:(void(^)(NSError *error))failure;

@end
