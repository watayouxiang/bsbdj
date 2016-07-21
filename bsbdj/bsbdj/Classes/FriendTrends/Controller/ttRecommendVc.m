//
//  ttRecommendVc.m
//  bsbdj
//
//  Created by 王涛 on 16/7/17.
//  Copyright © 2016年 wata. All rights reserved.
//

#import "ttRecommendVc.h"
#import "ttRecommendCategory.h"
#import "ttRecommendCategoryCell.h"
#import "ttRecommendUser.h"
#import "ttRecommendUserCell.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "MJRefresh.h"
#import "MJExtension.h"

//获取左侧类别
#define ttSelectedCategory self.categories[self.categoryTableView.indexPathForSelectedRow.row]

@interface ttRecommendVc ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;//左侧表格
@property (weak, nonatomic) IBOutlet UITableView *userTableView;//右侧表格
@property (nonatomic, strong) AFHTTPSessionManager *manager;//AFN请求管理者
@property (nonatomic, strong) NSMutableDictionary *params;//请求参数
@property (nonatomic, strong) NSArray *categories;//左侧类别数据
@end

@implementation ttRecommendVc

static NSString * const ttCategoryId = @"category";
static NSString * const ttUserId = @"user";

-(AFHTTPSessionManager *) manager{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    
    [self setupRefresh];
    
    [self loadCategories];
    
}

#pragma mark - 加载左侧数据
-(void)loadCategories{
    
    // 显示指示器
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    
    // 发送请求
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ttLog(@"左侧数据---> %@", responseObject);
        [responseObject writeToFile:@"/Users/TaoWang/Desktop/左侧数据.plist" atomically:YES];
        
        // 隐藏指示器
        [SVProgressHUD dismiss];
        
        // 服务器返回的JSON数据
        self.categories = [ttRecommendCategory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 刷新表格
        [self.categoryTableView reloadData];
        
        // 默认选中首行
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        
        // 让用户表格进入下拉刷新状态
        [self.userTableView.mj_header beginRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 显示失败信息
        [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败!"];
    }];
    
}

#pragma mark - 添加MJRefresh控件
-(void)setupRefresh{
    self.userTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
    
    self.userTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
    
    self.userTableView.mj_footer.hidden = YES;
}

/**
 *  刷新用户数据
 */
-(void)loadNewUsers{
    // 获取左侧类别
    ttRecommendCategory *rc = ttSelectedCategory;
    
    // 设置当前页码为1
    rc.currentPage = 1;
    
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(rc.id);
    params[@"page"] = @(rc.currentPage);
    self.params = params;
    
    // 发送请求给服务器, 刷新右侧的数据
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ttLog(@"右侧下拉刷新数据---> %@", responseObject);
        [responseObject writeToFile:@"/Users/TaoWang/Desktop/右侧下拉刷新数据.plist" atomically:YES];
        
        // 字典数组 -> 模型数组
        NSArray *users = [ttRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 清除所有旧数据
        [rc.users removeAllObjects];
        
        // 添加到当前类别对应的用户数组中
        [rc.users addObjectsFromArray:users];
        
        // 保存总数
        rc.total = [responseObject[@"total"] integerValue];
        
        // 不是最后一次请求
        if (self.params != params) return;
        
        // 刷新右边的表格
        [self.userTableView reloadData];
        
        // 结束刷新
        [self.userTableView.mj_header endRefreshing];
        
        // 让底部控件结束刷新
        [self checkFooterState];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 不是最后一次请求
        if (self.params != params) return;
        
        // 提醒
        [SVProgressHUD showErrorWithStatus:@"加载用户数据失败"];
        
        // 结束刷新
        [self.userTableView.mj_header endRefreshing];
    }];

}

/**
 *  加载更多用户数据
 */
-(void)loadMoreUsers{
    // 获取选中cell的数据
    ttRecommendCategory *category = ttSelectedCategory;
    
    // 发送请求给服务器, 加载右侧的数据
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(category.id);
    params[@"page"] = @(++category.currentPage);
    self.params = params;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ttLog(@"右侧加载更多数据---> %@", responseObject);
        [responseObject writeToFile:@"/Users/TaoWang/Desktop/右侧加载更多数据.plist" atomically:YES];
        
        // 字典数组 -> 模型数组
        NSArray *users = [ttRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 添加到当前类别对应的用户数组中
        [category.users addObjectsFromArray:users];
        
        // 不是最后一次请求
        if (self.params != params) return;
        
        // 刷新右边的表格
        [self.userTableView reloadData];
        
        // 让底部控件结束刷新
        [self checkFooterState];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 不是最后一次请求
        if (self.params != params) return;
        
        // 提醒
        [SVProgressHUD showErrorWithStatus:@"加载用户数据失败"];
        
        // 让底部控件结束刷新
        [self.userTableView.mj_footer endRefreshing];
    }];
    
}

/**
 *  时刻检测footer的状态
 */
-(void)checkFooterState{
    // 获取选中的类别
    ttRecommendCategory *rc = ttSelectedCategory;
    
    // 每次刷新右边数据时, 都控制footer显示或者隐藏
    self.userTableView.mj_footer.hidden = (rc.users.count == 0);
    
    // 让底部控件结束刷新
    if (rc.users.count == rc.total) { // 全部数据已经加载完毕
        [self.userTableView.mj_footer endRefreshingWithNoMoreData];
    } else { // 还没有加载完毕
        [self.userTableView.mj_footer endRefreshing];
    }
    
}

#pragma mark - 初始化控件
-(void)setupTableView{
    //注册xib
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([ttRecommendCategoryCell class])  bundle:nil] forCellReuseIdentifier:ttCategoryId];
    self.categoryTableView.dataSource = self;
    self.categoryTableView.delegate = self;
    
    [self.userTableView registerNib:[UINib nibWithNibName:NSStringFromClass([ttRecommendUserCell class]) bundle:nil] forCellReuseIdentifier:ttUserId];
    self.userTableView.dataSource = self;
    self.userTableView.delegate = self;
    
    //设置内边距
    self.automaticallyAdjustsScrollViewInsets = NO;//不要系统自动调节内边距
    self.categoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTableView.contentInset = self.categoryTableView.contentInset;
    self.userTableView.rowHeight = 70;
    
    //设置标题
    self.title = @"推荐关注";
    
    //设置背景色
    self.view.backgroundColor = ttGlobalBg;
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // 左边的类别表格
    if (tableView == self.categoryTableView) return self.categories.count;
    
    // 监测footer的状态
    [self checkFooterState];
    
    // 右边的用户表格
    return [ttSelectedCategory users].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.categoryTableView) { // 左边的类别表格
        ttRecommendCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:ttCategoryId];
        cell.category = self.categories[indexPath.row];
        return cell;
    } else { // 右边的用户表格
        ttRecommendUserCell *cell = [tableView dequeueReusableCellWithIdentifier:ttUserId];
        cell.user = [ttSelectedCategory users][indexPath.row];
        return cell;
    }
}

#pragma mark - <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 结束刷新
    [self.userTableView.mj_header endRefreshing];
    [self.userTableView.mj_footer endRefreshing];
    
    ttRecommendCategory *c = self.categories[indexPath.row];
    if (c.users.count) {
        // 显示曾经的数据
        [self.userTableView reloadData];
    } else {
        // 赶紧刷新表格,目的是: 马上显示当前category的用户数据, 不让用户看见上一个category的残留数据
        [self.userTableView reloadData];
        
        // 进入下拉刷新状态
        [self.userTableView.mj_header beginRefreshing];
    }
}

#pragma mark - 控制器销毁
-(void)dealloc{
    // 停止所有操作
    [self.manager.operationQueue cancelAllOperations];
}

@end











