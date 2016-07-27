//
//  ttRecommendTagsVc.m
//  bsbdj
//
//  Created by 王涛 on 16/7/19.
//  Copyright © 2016年 wata. All rights reserved.
//

#import "ttRecommendTagsVc.h"
#import "ttRecommendTag.h"
#import "ttRecommendTagCell.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import <MJExtension.h>

@interface ttRecommendTagsVc ()
@property (nonatomic, strong) NSArray *tags;//标签数据

@end

static NSString * const ttTagsId = @"tag";

@implementation ttRecommendTagsVc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    
    [self loadTags];
}

#pragma mark - 加载数据
- (void)loadTags {
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"tag_recommend";
    params[@"action"] = @"sub";
    params[@"c"] = @"topic";
    // 发送请求
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        ttLog(@"NSProgress: %@", downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ttLog(@"网络返回数据: %@", responseObject);
        
        self.tags = [ttRecommendTag mj_objectArrayWithKeyValuesArray:responseObject];
        [self.tableView reloadData];
        
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载标签数据失败!"];
    }];
    
}

#pragma mark - 初始化TableView
- (void)setupTableView {
    
    self.title = @"推荐标签";
    //加载xib
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ttRecommendTagCell class]) bundle:nil] forCellReuseIdentifier:ttTagsId];
    
    //设置行高
    self.tableView.rowHeight = 70;
    
    //设置分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //设置背景色
    self.tableView.backgroundColor = ttGlobalBg;
    
}

#pragma mark - <TableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tags.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ttRecommendTagCell *cell = [tableView dequeueReusableCellWithIdentifier:ttTagsId];
    cell.recommendTag = self.tags[indexPath.row];
    
    return cell;
}

@end
