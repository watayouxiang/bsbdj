//
//  ttRecommendVc.m
//  bsbdj
//
//  Created by 王涛 on 16/7/17.
//  Copyright © 2016年 wata. All rights reserved.
//

#import "ttRecommendVc.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"

@interface ttRecommendVc ()<UITableViewDelegate, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;//左侧表格
@property (weak, nonatomic) IBOutlet UITableView *userTableView;//右侧表格
@property (nonatomic, strong) NSMutableDictionary *param;//请求参数
@property (nonatomic, strong) AFHTTPSessionManager *manager;//AFN请求管理者
@end

@implementation ttRecommendVc

static NSString * const nspCategoryId = @"category";
static NSString * const nspUserId = @"user";

-(AFHTTPSessionManager *) manager{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    
}

/**
 *  初始化控件
 */
-(void)setupTableView{
    
}



@end
