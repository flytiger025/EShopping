//
//  DaPeiInfoViewController.m
//  EShopping
//
//  Created by 任龙宇 on 15/3/9.
//  Copyright (c) 2015年 renlongyu. All rights reserved.
//

#import "DaPeiInfoViewController.h"
#import "DaPeiInfoTableViewCell.h"
#import "DaPeiInfoTableFooterView.h"
#import "UIImageView+WebCache.h"
#import "DaPeiInfoModel.h"
#import "WebServer.h"
#import "URL.h"

static NSString *cellIdentifier = @"DaPeiInfoTableViewCell";
static NSString *footerViewIdentifier = @"DaPeiInfoTableViewCell";

@interface DaPeiInfoViewController () <WebServerDelegate>

@property (nonatomic, strong) UIImageView *headerView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation DaPeiInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.dataArray = [NSMutableArray array];

    [self.tableView registerNib:[UINib nibWithNibName:cellIdentifier bundle:nil] forCellReuseIdentifier:cellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:footerViewIdentifier bundle:nil] forCellReuseIdentifier:footerViewIdentifier];
    
    self.headerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64)];
    self.tableView.tableHeaderView = _headerView;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    WebServer *webServer = [[WebServer alloc] init];
    webServer.delegate = self;
    [webServer requestDataWithURL:[URL daPeiInfoURLWithParam:self.param]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - WebServerDelegate

- (void)webServerDidReceiveDataSuccess:(id)responseObject {
    NSString *imageURL = responseObject[@"big_pic"];
    [self.headerView sd_setImageWithURL:[NSURL URLWithString:imageURL]];
    
    for (NSDictionary *dic in responseObject[@"goods"]) {
        DaPeiInfoModel *model = [DaPeiInfoModel infoModel];
        [model setValuesForKeysWithDictionary:dic];
        [self.dataArray addObject:model];
    }
    
    [self.tableView reloadData];
}

- (void)webServerDidReceiveDataFailure:(NSError *)error {
    //TODO: 网络连接失败
    NSLog(@"网络连接失败");
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    DaPeiInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    DaPeiInfoModel *model = self.dataArray[indexPath.row];
    [cell.picView sd_setImageWithURL:[NSURL URLWithString:model.smallImageURL]];
    cell.titleLabel.text = model.title;
    cell.priceLabel.text = model.nowPrice;

    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return section == 0 ? @"单品购买链接": nil;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 57;
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
//    
//}


@end
