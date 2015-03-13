//
//  WoDeViewController.m
//  EShopping
//
//  Created by 任龙宇 on 15/3/7.
//  Copyright (c) 2015年 renlongyu. All rights reserved.
//

#import "WoDeViewController.h"
#import "ParallaxHeaderView.h"
#import "WoDeTableViewCell.h"
#import "SDImageCache.h"
#import "M13ProgressHUD.h"
#import "M13ProgressViewRing.h"
#import "Macro.h"
#import "AppDelegate.h"
#import "DXAlertView.h"


@interface WoDeViewController () <UIScrollViewDelegate>

@property (nonatomic, weak) ParallaxHeaderView *parallaxHeaderView;
@property (nonatomic, weak) M13ProgressHUD *hud;

@end

static NSString * const WDCellIdentifier = @"WoDeTableViewCell";

@implementation WoDeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"设置";
    self.view.backgroundColor = [UIColor whiteColor];

    ParallaxHeaderView *headerView = [ParallaxHeaderView parallaxHeaderViewWithImage:[UIImage imageNamed:@"Header_bgd"] forSize:CGSizeMake(self.view.frame.size.width, 140)];
    headerView.headerTitleLabel.text = @"喵! 欢迎来到e购";
    _parallaxHeaderView = headerView;
    self.tableView.tableHeaderView = _parallaxHeaderView;
    
    [self.tableView registerNib:[UINib nibWithNibName:WDCellIdentifier bundle:nil] forCellReuseIdentifier:WDCellIdentifier];
    self.tableView.tableFooterView = [UIView new];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (M13ProgressHUD *)hud {
    if (!_hud) {
        M13ProgressHUD *hud = [[M13ProgressHUD alloc] initWithProgressView:[[M13ProgressViewRing alloc] init]];
        hud.progressViewSize = CGSizeMake(60, 60);
        hud.animationPoint = CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2);
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        [window addSubview:_hud = hud];
    }
    return _hud;
}

#pragma mark - UIScrollViewDelegate 

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.tableView) {
        [_parallaxHeaderView layoutHeaderViewForScrollViewOffset:scrollView.contentOffset];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WoDeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:WDCellIdentifier forIndexPath:indexPath];
    
    switch (indexPath.row) {
        case 0: {
            cell.titleLabel.text = [NSString stringWithFormat:@"清除缓存(%@)", [self imageCacheSize]];
            break;
        }
            
        case 1: {
            cell.iconView.image = [UIImage imageNamed:@"myProfile_6"];
            cell.titleLabel.text = @"升级到最新版本";
            break;
        }

            
        case 2: {
            cell.iconView.image = [UIImage imageNamed:@"myProfile_7"];
            cell.titleLabel.text = @"喜欢就去评个分吧";
            break;
        }
            
        case 3: {
            cell.iconView.image = [UIImage imageNamed:@"myProfile_5"];
            cell.titleLabel.text = @"关于我们";
            break;
        }
            
        default:
            break;
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0: { //清除缓存
            [self clearCache];
            break;
        }
            
        case 1: { //版本升级
            [self unsupported];
            break;
        }
            
        case 2: { //应用评价
            [self unsupported];
            break;
        }
            
        case 3: { //关于我们
            [self aboutUs];
            break;
        }
            
        default:
            break;
    }
}


#pragma mark - Action

- (NSString *)imageCacheSize {
    CGFloat size = [[SDImageCache sharedImageCache] getSize];
    
    NSInteger notation = 0;
    while (size >= 1024) {
        size /= 1024;
        notation++;
    }
    
    switch (notation) {
        case 0: //B
            return [NSString stringWithFormat:@"%.2fB", size];
            
        case 1: //KB
            return [NSString stringWithFormat:@"%.2fKB", size];
            
        case 2: //MB
            return [NSString stringWithFormat:@"%.2fMB", size];
        
        default: //GB+
            return [NSString stringWithFormat:@"%.2fGB", size];
    }
}

- (void)clearCache {
    __weak WoDeViewController *weakSelf = self;
    DXAlertView *alertView = [[DXAlertView alloc] initWithTitle:@"提示" contentText:@"真的要清除缓存么,\n下次打开会很费流量欸(>﹏<)" leftButtonTitle:nil rightButtonTitle:@"狠下心来清除"];
    alertView.rightBlock = dispatch_block_create(DISPATCH_BLOCK_ASSIGN_CURRENT, ^{
        [[SDImageCache sharedImageCache] clearDisk];
        [weakSelf.hud show:YES];
        [weakSelf performSelector:@selector(setQuarter) withObject:Nil afterDelay:0.7];
    });
    [alertView show];
}

- (void)aboutUs {
    DXAlertView *alertView = [[DXAlertView alloc] initWithTitle:@"喵呜~" contentText:@"Q群: 391123593" leftButtonTitle:nil rightButtonTitle:@"好的哦,亲~ `(*∩_∩*)′ "];
    [alertView show];
}

- (void)unsupported {
    DXAlertView *alertView = [[DXAlertView alloc] initWithTitle:@"啊哦~" contentText:@"暂时好像不管用诶눈_눈" leftButtonTitle:nil rightButtonTitle:@"╭（╯_╰）╭"];
    [alertView show];
}

#pragma mark - HUD

- (void)setQuarter
{
    [self.hud setProgress:.25 animated:YES];
    [self performSelector:@selector(setTwoThirds) withObject:nil afterDelay:1.2];
}

- (void)setTwoThirds
{
    [self.hud setProgress:.66 animated:YES];
    [self performSelector:@selector(setThreeQuarters) withObject:nil afterDelay:0.3];
}

- (void)setThreeQuarters
{
    [self.hud setProgress:.75 animated:YES];
    [self performSelector:@selector(setOne) withObject:nil afterDelay:0.5];
}

- (void)setOne
{
    [self.hud setProgress:1.0 animated:YES];
    [self performSelector:@selector(setComplete) withObject:nil afterDelay:self.hud.animationDuration + .1];
}

- (void)setComplete
{
    [self.tableView reloadData];
    [self.hud performAction:M13ProgressViewActionSuccess animated:YES];
    [self performSelector:@selector(reset) withObject:nil afterDelay:0.8];
}

- (void)reset
{
    [self.hud hide:YES];
    [self.hud setProgress:0 animated:NO];
    [self.hud performAction:M13ProgressViewActionNone animated:NO];
    if (!self.hud) {
        [self.hud removeFromSuperview];
        self.hud = nil;
    }
}

@end
