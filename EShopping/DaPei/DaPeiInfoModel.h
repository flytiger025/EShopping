//
//  DaPeiInfoModel.h
//  EShopping
//
//  Created by 任龙宇 on 15/3/9.
//  Copyright (c) 2015年 renlongyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DaPeiInfoModel : NSObject

@property (nonatomic, copy) NSString *nowPrice;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *smallImageURL;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *url;

+ (DaPeiInfoModel *)infoModel;

@end
