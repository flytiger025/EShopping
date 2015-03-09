//
//  DaPeiModel.h
//  EShopping
//
//  Created by 任龙宇 on 15/3/9.
//  Copyright (c) 2015年 renlongyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DaPeiModel : NSObject

@property (nonatomic, strong) NSNumber *goodsNumber;
@property (nonatomic, strong) NSNumber *loveNumber;
@property (nonatomic, strong) NSNumber *param;
@property (nonatomic, strong) NSNumber *imageHeight;
@property (nonatomic, strong) NSNumber *imageWidth;
@property (nonatomic, copy) NSString *imageURL;
@property (nonatomic, copy) NSString *title;

+ (DaPeiModel *)model;

@end
