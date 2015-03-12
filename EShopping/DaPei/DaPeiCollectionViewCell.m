//
//  DaPeiCollectionViewCell.m
//  EShopping
//
//  Created by 任龙宇 on 15/3/9.
//  Copyright (c) 2015年 renlongyu. All rights reserved.
//

#import "DaPeiCollectionViewCell.h"

@interface DaPeiCollectionViewCell ()
{
    BOOL isloveButtonRed;
}
@end

@implementation DaPeiCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (IBAction)loveButtonAction:(UIButton *)button {
    if (isloveButtonRed) { //红心状态
        [button setImage:[UIImage imageNamed:@"goodsDislike"] forState:UIControlStateNormal];
        NSNumber *loveNumber = [NSNumber numberWithInt:[self.loveLabel.text intValue] - 1];
        self.loveLabel.text = [NSString stringWithFormat:@"%@", loveNumber];
        isloveButtonRed = NO;
        [self animationForButton:button];
    } else {
        [button setImage:[UIImage imageNamed:@"goodsLike"] forState:UIControlStateNormal];
        NSNumber *loveNumber = [NSNumber numberWithInt:[self.loveLabel.text intValue] + 1];
        self.loveLabel.text = [NSString stringWithFormat:@"%@", loveNumber];
        isloveButtonRed = YES;
        [self animationForButton:button];
    }
}

- (void)animationForButton:(UIButton *)button {
    CGRect originBounds = button.bounds;
    CGRect bigBounds = CGRectMake(0, 0, originBounds.size.width * 1.6, originBounds.size.width * 1.6);
    button.imageView.bounds = bigBounds;
    [UIView animateWithDuration:0.35 animations:^{
        button.imageView.bounds = originBounds;
    } completion:^(BOOL finished) {
        CGRect smallBounds = CGRectMake(0, 0, originBounds.size.width * 0.8, originBounds.size.height * 0.8);
        button.imageView.bounds = smallBounds;
        [UIView animateWithDuration:0.15 animations:^{
            button.imageView.bounds = originBounds;
        }];
    }];
}

@end
