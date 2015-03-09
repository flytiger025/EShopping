//
//  API.h
//  EShopping
//
//  Created by 任龙宇 on 15/3/9.
//  Copyright (c) 2015年 renlongyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface URL : NSObject

+ (NSURL *)daPeiURL;

+ (NSURL *)daPeiCatagoryURLWithCid:(NSString *)cid page:(NSInteger)page;

+ (NSURL *)daPeiInfoURLWithParam:(NSNumber *)param;

@end
