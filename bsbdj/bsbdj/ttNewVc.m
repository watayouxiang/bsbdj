//
//  ttNewVc.m
//  bsbdj
//
//  Created by 王涛 on 16/7/17.
//  Copyright © 2016年 wata. All rights reserved.
//

#import "ttNewVc.h"

@interface ttNewVc ()

@end

@implementation ttNewVc

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = ttGlobalBg;
    
    //设置导航栏标题(标题是图片)
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    //设置导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
}

- (void)tagClick{
    ttLogFunc;
}

@end
