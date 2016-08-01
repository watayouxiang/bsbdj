//
//  ttMeFooterView.m
//  bsbdj
//
//  Created by 王涛 on 16/8/1.
//  Copyright © 2016年 wata. All rights reserved.
//

#import "ttMeFooterView.h"
#import <AFNetworking.h>
#import "ttSquare.h"
#import <MJExtension.h>
#import "ttSqaureButton.h"
#import "ttWebVc.h"

@implementation ttMeFooterView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        
        // 参数
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"a"] = @"square";
        params[@"c"] = @"topic";
        
        // 发送请求
        [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSArray *sqaures = [ttSquare mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
            
            // 创建方块
            [self createSquares:sqaures];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
    }
    return self;
}

#pragma mark - 创建方块
- (void)createSquares:(NSArray *)sqaures {
    // 一行最多4列
    int maxCols = 4;
    
    // 宽度和高度
    CGFloat buttonW = ttScreenW / maxCols;
    CGFloat buttonH = buttonW;
    
    for (int i = 0; i<sqaures.count; i++) {
        // 创建按钮
        ttSqaureButton *button = [ttSqaureButton buttonWithType:UIButtonTypeCustom];
        // 监听点击
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        // 传递模型
        button.square = sqaures[i];
        [self addSubview:button];
        
        // 计算frame
        int col = i % maxCols;
        int row = i / maxCols;
        
        button.x = col * buttonW;
        button.y = row * buttonH;
        button.width = buttonW;
        button.height = buttonH;
    }
    
    
    // 总页数 == (总个数 + 每页的最大数 - 1) / 每页最大数
    NSUInteger rows = (sqaures.count + maxCols - 1) / maxCols;
    
    // 计算footer的高度
    self.height = rows * buttonH;
    
    // 重新设置tableView的contentSize
    UITableView *tableView = (UITableView *)self.superview;
    tableView.contentSize = CGSizeMake(0, CGRectGetMaxY(self.frame));
    
    // 重绘
    [self setNeedsDisplay];
}

- (void)buttonClick:(ttSqaureButton *)button {
    ttLog(@"%s, url = %@", __func__, button.square.url);
    
    if (![button.square.url hasPrefix:@"http"]) return;
    
    ttWebVc *web = [[ttWebVc alloc] init];
    web.url = button.square.url;
    web.title = button.square.name;
    
    // 取出当前的导航控制器
    UITabBarController *tabBarVc = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController *nav = (UINavigationController *)tabBarVc.selectedViewController;
    [nav pushViewController:web animated:YES];
}

@end


