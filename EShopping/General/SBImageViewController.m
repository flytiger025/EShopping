//
//  SBImageViewController.m
//  
//
//  Created by 任龙宇 on 15/3/12.
//
//

#import "SBImageViewController.h"
#import "Macro.h"

@interface SBImageViewController ()

@end

@implementation SBImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.85];
    // Do any additional setup after loading the view from its nib.
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.view addGestureRecognizer:tap];

    CGFloat height = _imageHeight / _imageWidth * SCREEN_WIDTH;
    UIImageView *imageView = [[UIImageView alloc] initWithImage:self.image];
    imageView.frame = CGRectMake(0, 0, SCREEN_WIDTH, height);
    imageView.center = self.view.center;
    [self.view addSubview:imageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tapAction:(UITapGestureRecognizer *)tap {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
