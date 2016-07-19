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

@interface ttRecommendVc ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;//左侧表格
@property (weak, nonatomic) IBOutlet UITableView *userTableView;//右侧表格
@property (nonatomic, strong) NSMutableDictionary *params;//请求参数
@property (nonatomic, strong) AFHTTPSessionManager *manager;//AFN请求管理者
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

#pragma mark - 加载左侧类别数据
-(void)loadCategories{
    
    // 显示指示器
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    // 发送请求
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        // 隐藏指示器
        [SVProgressHUD dismiss];
        
        // 服务器返回的JSON数据
        ttLog(@"======%@",responseObject);
        self.categories = [ttRecommendCategory objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 刷新表格
        [self.categoryTableView reloadData];
        
        // 默认选中首行
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        
        // 让用户表格进入下拉刷新状态
        [self.userTableView.header beginRefreshing];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        // 显示失败信息
        [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败!"];
        
    }];
    
}

#pragma mark - 添加MJRefresh控件
-(void)setupRefresh{
    self.userTableView.header = [MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
    
    self.userTableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
    
    self.userTableView.footer.hidden = YES;
}

/**
 *  加载用户数据
 */
-(void)loadNewUsers{
    ttRecommendCategory *rc = self.categories[self.categoryTableView.indexPathForSelectedRow.row];
    
    // 设置当前页码为1
    rc.currentPage = 1;
    
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(rc.id);
    params[@"page"] = @(rc.currentPage);
    self.params = params;
    
    // 发送请求给服务器, 加载右侧的数据
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
       
        // 字典数组 -> 模型数组
        NSArray *users = [ttRecommendUser objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
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
        [self.userTableView.header endRefreshing];
        
        // 让底部控件结束刷新
        [self checkFooterState];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        // 不是最后一次请求
        if (self.params != params) return;
        
        // 提醒
        [SVProgressHUD showErrorWithStatus:@"加载用户数据失败"];
        
        // 结束刷新
        [self.userTableView.header endRefreshing];
        
    }];
}

/**
 *  加载更多用户数据
 */
-(void)loadMoreUsers{
    // 获取选中cell的数据
    ttRecommendCategory *category = self.categories[self.categoryTableView.indexPathForSelectedRow.row];
    
    // 发送请求给服务器, 加载右侧的数据
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(category.id);
    params[@"page"] = @(++category.currentPage);
    self.params = params;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        // 字典数组 -> 模型数组
        NSArray *users = [ttRecommendUser objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 添加到当前类别对应的用户数组中
        [category.users addObjectsFromArray:users];
        
        // 不是最后一次请求
        if (self.params != params) return;
        
        // 刷新右边的表格
        [self.userTableView reloadData];
        
        // 让底部控件结束刷新
        [self checkFooterState];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        // 不是最后一次请求
        if (self.params != params) return;
        
        // 提醒
        [SVProgressHUD showErrorWithStatus:@"加载用户数据失败"];
        
        // 让底部控件结束刷新
        [self.userTableView.footer endRefreshing];
        
    }];

}

#pragma mark - 初始化控件
-(void)setupTableView{
    //注册xib
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([ttRecommendCategoryCell class])  bundle:nil] forCellReuseIdentifier:ttCategoryId];
    [self.userTableView registerNib:[UINib nibWithNibName:NSStringFromClass([ttRecommendUserCell class]) bundle:nil] forCellReuseIdentifier:ttUserId];
    
    //设置内边距
    self.automaticallyAdjustsScrollViewInsets = NO;//不要系统自动设置内边距
    self.categoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTableView.contentInset = self.categoryTableView.contentInset;
    self.userTableView.rowHeight = 70;
    
    //设置标题
    self.title = @"推荐关注";
    
    //设置背景色
    self.view.backgroundColor = ttGlobalBg;
}

#pragma mark - 时刻检测footer的状态
-(void)checkFooterState{
    // 获取选中的cell对应的右侧数据
    ttRecommendCategory *rc = self.categories[self.categoryTableView.indexPathForSelectedRow.row];
    
    // 每次刷新右边数据时, 都控制footer显示或者隐藏
    self.userTableView.footer.hidden = (rc.users.count == 0);
    
    // 让底部控件结束刷新
    if (rc.users.count == rc.total) { // 全部数据已经加载完毕
        [self.userTableView.footer noticeNoMoreData];
    } else { // 还没有加载完毕
        [self.userTableView.footer endRefreshing];
    }
    
}

#pragma mark - <UITableViewDataSource>
//每组有几行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    //左侧表格数据
    if (tableView == self.categoryTableView) {
        return self.categories.count;
    }
    
    return 0;
}

//cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}

#pragma mark - <UITableViewDelegate>
//选中cell时调用
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark - 控制器销毁
-(void)dealloc{
    
}

@end











