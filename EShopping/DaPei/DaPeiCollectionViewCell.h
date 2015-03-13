//
//  DaPeiCollectionViewCell.h
//  EShopping
//
//  Created by 任龙宇 on 15/3/9.
//  Copyright (c) 2015年 renlongyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DaPeiCollectionViewCell : UICollectionViewCell
{
    BOOL isloveButtonRed;
}

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *goodsLabel;
@property (weak, nonatomic) IBOutlet UILabel *loveLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
