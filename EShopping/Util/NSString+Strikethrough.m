//
//  NSString+Strikethrough.m
//  EShopping
//
//  Created by 任龙宇 on 15/3/11.
//  Copyright (c) 2015年 renlongyu. All rights reserved.
//

#import "NSString+Strikethrough.h"
#import <UIKit/UIKit.h>

@implementation NSString (Strikethrough)

- (NSMutableAttributedString *)attributedStringWithStrikethrough {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self];
    NSDictionary *attributes = @{NSStrikethroughStyleAttributeName: @(NSUnderlineStyleSingle),
                                 NSStrikethroughColorAttributeName: [UIColor redColor]};
    [attributedString setAttributes:attributes range:NSMakeRange(0, self.length)];
    return attributedString;
}

@end
