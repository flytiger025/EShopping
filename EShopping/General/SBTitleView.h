//
//  SBTitleView.h
//  EShopping
//
//  Created by 任龙宇 on 15/3/10.
//  Copyright (c) 2015年 renlongyu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, SBTitleViewState) {
    SBTitleViewStateLeft,
    SBTitleViewStateRight,
};

@class SBTitleView;

@protocol SBTitleViewDelegate <NSObject>

- (void)titleViewDidClickedLeftButton:(SBTitleView *)titleView;
- (void)titleViewDidClickedRightButton:(SBTitleView *)titleView;

@end


@interface SBTitleView : UIView

@property (nonatomic, weak) id<SBTitleViewDelegate> delegate;

@property (nonatomic, copy) NSString *leftButtonTitle;
@property (nonatomic, copy) NSString *rightButtonTitle;

@property (nonatomic, assign) SBTitleViewState state;

@end
