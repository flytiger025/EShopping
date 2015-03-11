//
//  SBTabBar.m
//  EShopping
//
//  Created by 任龙宇 on 15/3/7.
//  Copyright (c) 2015年 renlongyu. All rights reserved.
//

#import "SBTabBar.h"
#import "Macro.h"

#define SBColor [UIColor colorWithRed:0.988 green:0.388 blue:0.671 alpha:1]
#define ButtonTitleColor [UIColor colorWithRed:0.588 green:0.588 blue:0.588 alpha:1]

@interface SBTabBar ()

@property (nonatomic, strong) UIScrollView *navigateionTabBar;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) NSArray *itemsWidth;
@property (nonatomic, assign) CGFloat contentWidth;

@end

@implementation SBTabBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.borderColor = [UIColor colorWithRed:0.816 green:0.816 blue:0.816 alpha:1].CGColor;
        self.layer.borderWidth = 0.5f;
        
        self.items = [NSMutableArray array];
        
        self.navigateionTabBar = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NAV_TAB_BAR_HEIGHT)];
        _navigateionTabBar.showsHorizontalScrollIndicator = NO;
        [self addSubview:_navigateionTabBar];

    }
    return self;
}

- (void)showLineWithButtonWidth:(CGFloat)width {
    self.line = [[UIView alloc] initWithFrame:CGRectMake(2.0, NAV_TAB_BAR_HEIGHT - 2, width - 4, 2)];
    _line.backgroundColor = SBColor;
    [_navigateionTabBar addSubview:_line];
}

- (CGFloat )contentWidthAndAddNavTabBarItemsWithButtonWidth:(NSArray *)widths {
    CGFloat buttonX = 0;
    for (int i = 0; i < _itemsTitle.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(buttonX, 0, [widths[i] floatValue], NAV_TAB_BAR_HEIGHT);
        [button setTitle:_itemsTitle[i] forState:UIControlStateNormal];
        [button setTitleColor:ButtonTitleColor forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button addTarget:self action:@selector(itemPressed:) forControlEvents:UIControlEventTouchUpInside];
        [_navigateionTabBar addSubview:button];
        [_items addObject:button];
        buttonX += [widths[i] floatValue];
    }
    [self showLineWithButtonWidth:[widths[0] floatValue]];
    return buttonX;
}

- (NSArray *)getButtonsWidthWithTitles:(NSArray *)titles {
    NSMutableArray *widths = [NSMutableArray array];
    for (NSString *title in titles) {
        CGSize size = [title sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15]}];
        NSNumber *width = [NSNumber numberWithFloat:size.width + 40.0];
        [widths addObject:width];
    }
    return widths;
}

- (void)itemPressed:(UIButton *)button {
    NSInteger index = [_items indexOfObject:button];
    [self setCurrentIndex:index];
    [_delegate tabBar:self didSelectItemWithIndex:index];
}

- (void)updateData {
    _itemsWidth = [self getButtonsWidthWithTitles:_itemsTitle];
    if (_itemsWidth.count > 0) {
        self.contentWidth = [self contentWidthAndAddNavTabBarItemsWithButtonWidth:_itemsWidth];
        _navigateionTabBar.contentSize = CGSizeMake(self.contentWidth, NAV_TAB_BAR_HEIGHT);
    }
}

- (void)setCurrentIndex:(NSInteger)currentIndex {
    UIButton *oldButton = _items[_currentIndex];
    oldButton.titleLabel.textColor = ButtonTitleColor;
    _currentIndex = currentIndex;
    UIButton *button = _items[_currentIndex];
    button.titleLabel.textColor = SBColor;
    CGFloat offsetX = button.frame.origin.x + button.frame.size.width;
    if (offsetX > SCREEN_WIDTH * 2 / 3) {
        offsetX -= SCREEN_WIDTH * 2 / 3;
        if (_currentIndex < _items.count - 1) {
            offsetX += 40;
        }
        if (offsetX > _contentWidth - SCREEN_WIDTH) {
            offsetX = _contentWidth - SCREEN_WIDTH;
        }
        
        [_navigateionTabBar setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    } else {
        [_navigateionTabBar setContentOffset:CGPointZero animated:YES];
    }
    
    [UIView animateWithDuration:0.2 animations:^{
        _line.frame = CGRectMake(button.frame.origin.x + 2.0f, _line.frame.origin.y, [_itemsWidth[_currentIndex] floatValue] - 4.0f, _line.frame.size.height);
    }];
}

@end
