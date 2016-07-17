//
//  ttMeVc.m
//  bsbdj
//
//  Created by 王涛 on 16/7/17.
//  Copyright © 2016年 wata. All rights reserved.
//

#import "ttMeVc.h"

@interface ttMeVc ()

@end

@implementation ttMeVc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = ttGlobalBg;
    //设置导航栏标题
    self.navigationItem.title = @"我的";
    
    //设置导航栏右边的按钮
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithImage:@"mine-setting-icon" highImage:@"mine-setting-icon-click" target:self action:@selector(settingClick)];
    UIBarButtonItem *moonItem = [UIBarButtonItem itemWithImage:@"mine-moon-icon" highImage:@"mine-moon-icon-click" target:self action:@selector(moonClick)];
    self.navigationItem.rightBarButtonItems = @[settingItem, moonItem];
    
}

-(void)settingClick{
    ttLogFunc;
}

-(void)moonClick{
    ttLogFunc;
}


@end
