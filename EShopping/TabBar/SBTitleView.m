//
//  SBTitleView.m
//  EShopping
//
//  Created by 任龙宇 on 15/3/10.
//  Copyright (c) 2015年 renlongyu. All rights reserved.
//

#import "SBTitleView.h"

#define SELECT_COLOR [UIColor whiteColor]
#define UNSELECT_COLOR [UIColor grayColor]

@interface SBTitleView ()

@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation SBTitleView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width / 2, frame.size.height)];
        _imageView.image = [UIImage imageNamed:@"commentSend"];
        [self addSubview:_imageView];

        self.leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftButton.frame = _imageView.frame;
        [_leftButton setTitle:@"left" forState:UIControlStateNormal];
        [_leftButton setTitleColor:SELECT_COLOR forState:UIControlStateNormal];
        [_leftButton addTarget:self action:@selector(leftButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_leftButton];
        
        self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightButton.frame = CGRectMake(frame.size.width / 2, 0, frame.size.width / 2, frame.size.height);
        [_rightButton setTitle:@"right" forState:UIControlStateNormal];
        [_rightButton setTitleColor:UNSELECT_COLOR forState:UIControlStateNormal];
        [_rightButton addTarget:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_rightButton];
        
        _state = SBTitleViewStateLeft;
    }
    return self;
}

#pragma mark -

- (void)setLeftButtonTitle:(NSString *)title {
    [self.leftButton setTitle:title forState:UIControlStateNormal];
}

- (void)setRightButtonTitle:(NSString *)title {
    [self.rightButton setTitle:title forState:UIControlStateNormal];
}

#pragma mark -

- (void)leftButtonAction:(UIButton *)button {
    self.state = SBTitleViewStateLeft;
    [_delegate titleViewDidClickedLeftButton:self];
}

- (void)rightButtonAction:(UIButton *)button {
    self.state = SBTitleViewStateRight;
    [_delegate titleViewDidClickedRightButton:self];
}

#pragma mark -

- (void)setState:(SBTitleViewState)state {
    if (self.state == SBTitleViewStateLeft && state == SBTitleViewStateRight) {
        [self changeStateAnimationWithNewState:state];
        [self.leftButton setTitleColor:UNSELECT_COLOR forState:UIControlStateNormal];
        [self.rightButton setTitleColor:SELECT_COLOR forState:UIControlStateNormal];
        _state = state;
        
    } else if (self.state == SBTitleViewStateRight && state == SBTitleViewStateLeft) {
        [self changeStateAnimationWithNewState:state];
        [self.leftButton setTitleColor:SELECT_COLOR forState:UIControlStateNormal];
        [self.rightButton setTitleColor:UNSELECT_COLOR forState:UIControlStateNormal];
        _state = state;
    }
}

- (void)changeStateAnimationWithNewState:(SBTitleViewState)state {
    CGRect frame = self.imageView.frame;
    frame.origin.x = state == SBTitleViewStateLeft ? 0 : self.frame.size.width / 2;
    [UIView animateWithDuration:0.3 animations:^{
        self.imageView.frame = frame;
    }];
}

@end
