//
//  DanPinModel.h
//  EShopping
//
//  Created by 任龙宇 on 15/3/10.
//  Copyright (c) 2015年 renlongyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DanPinModel : NSObject

@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSNumber *itemId;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *url;

+ (DanPinModel *)model;

@end
