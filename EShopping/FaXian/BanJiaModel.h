//
//  JKJModel.h
//  EShopping
//
//  Created by 任龙宇 on 15/3/10.
//  Copyright (c) 2015年 renlongyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BanJiaModel : NSObject

@property (nonatomic, copy) NSString *dealNumber;
@property (nonatomic, strong) NSNumber *discount;
@property (nonatomic, strong) NSNumber *isOnsale;
@property (nonatomic, strong) NSNumber *isVipPrice;
@property (nonatomic, strong) NSNumber *nowPrice;
@property (nonatomic, strong) NSString *numID;
@property (nonatomic, strong) NSNumber *originPrice;
@property (nonatomic, copy) NSString *picURL;
@property (nonatomic, copy) NSString *showTime;
@property (nonatomic, copy) NSString *startDiscount;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSNumber *loveNumber;

+ (BanJiaModel *)model;

@end
