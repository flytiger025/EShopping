//
//  UINavigationBar+BackgroundColor.m
//  EShopping
//
//  Created by 任龙宇 on 15/3/13.
//  Copyright (c) 2015年 renlongyu. All rights reserved.
//

#import "UINavigationBar+BackgroundColor.h"
#import <objc/runtime.h>

static void * const overlayKey = @"BackgroundOverlay";

@implementation UINavigationBar (BackgroundColor)

- (UIView *)overlay {
    return objc_getAssociatedObject(self, overlayKey);
}

- (void)setOverlay:(UIView *)overlay {
    return objc_setAssociatedObject(self, overlayKey, overlay, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (void)useBackgroundColor:(UIColor *)backgroundColor {
    if (!self.overlay) {
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        [self setShadowImage:[UIImage new]];
        self.overlay = [[UIView alloc] initWithFrame:CGRectMake(0, -20, [UIScreen mainScreen].bounds.size.width, 64)];
        [self insertSubview:self.overlay atIndex:0];
    }
    self.overlay.backgroundColor = backgroundColor;
}

- (void)reset {
    [self setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self setShadowImage:nil];
    [self.overlay removeFromSuperview];
    self.overlay = nil;
}

@end
