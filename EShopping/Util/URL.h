//
//  API.h
//  EShopping
//
//  Created by 任龙宇 on 15/3/9.
//  Copyright (c) 2015年 renlongyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface URL : NSObject

#pragma mark - DaPei

+ (NSURL *)daPeiURL;

+ (NSURL *)daPeiCategoryURLWithCid:(NSString *)cid page:(NSInteger)page;

+ (NSURL *)daPeiInfoURLWithParam:(NSNumber *)param;


#pragma mark - DanPin

+ (NSURL *)danPinURL;

+ (NSURL *)danPinCategoryURLWithCid:(NSString *)cid page:(NSInteger)page;


#pragma mark - FaXian

+ (NSURL *)jiuKuaiJiuURL;
+ (NSURL *)banJiaURL;

+ (NSString *)faxianURLWithNumID:(NSString *)numID;

@end
