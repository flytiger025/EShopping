//
//  WebServer.h
//  EShopping
//
//  Created by 任龙宇 on 15/3/9.
//  Copyright (c) 2015年 renlongyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WebServerDelegate <NSObject>

- (void)webServerDidReceiveDataSuccess:(id)responseObject;
- (void)webServerDidReceiveDataFailure:(NSError *)error;

@end

@interface WebServer : NSObject

@property (nonatomic, weak) id<WebServerDelegate> delegate;

- (void)requestDataWithURL:(NSURL *)url;

@end
