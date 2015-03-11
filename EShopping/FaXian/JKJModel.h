//
//  BanJiaModel.h
//  EShopping
//
//  Created by 任龙宇 on 15/3/10.
//  Copyright (c) 2015年 renlongyu. All rights reserved.
//

#import "BanJiaModel.h"

@interface JKJModel : BanJiaModel

@property (nonatomic, strong) NSNumber *isBuySale;
@property (nonatomic, strong) NSNumber *lingValue;
@property (nonatomic, copy) NSString *qiangPai;
@property (nonatomic, strong) NSNumber *hateNumber;

+ (JKJModel *)model;

@end
