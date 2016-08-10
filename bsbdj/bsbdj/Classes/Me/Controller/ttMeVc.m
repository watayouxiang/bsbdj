//
//  ttMeVc.m
//  bsbdj
//
//  Created by 王涛 on 16/7/17.
//  Copyright © 2016年 wata. All rights reserved.
//

#import "ttMeVc.h"
#import "ttMeCell.h"
#import "ttMeFooterView.h"
#import "ttSettingVc.h"

@interface ttMeVc ()

@end

@implementation ttMeVc

static NSString *ttMeId = @"me";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    [self setupTableView];
    
}

#pragma mark - 设置tableView
-(void)setupTableView{
    //background color
    self.tableView.backgroundColor = ttGlobalBg;
    
    //delete tableview underline
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[ttMeCell class] forCellReuseIdentifier:ttMeId];
    
    //resetting Header & Footer
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = ttTopicCellMargin;
    
    //resetting inset
    self.tableView.contentInset = UIEdgeInsetsMake(ttTopicCellMargin-35, 0, 0, 0);
    
    //setting FooterView
    self.tableView.tableFooterView = [[ttMeFooterView alloc] init];
    
}

#pragma mark - 设置导航栏
-(void)setupNav{
    //设置导航栏标题
    self.navigationItem.title = @"我的";
    
    //设置导航栏右边的按钮
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithImage:@"mine-setting-icon" highImage:@"mine-setting-icon-click" target:self action:@selector(settingClick)];
    UIBarButtonItem *moonItem = [UIBarButtonItem itemWithImage:@"mine-moon-icon" highImage:@"mine-moon-icon-click" target:self action:@selector(moonClick)];
    self.navigationItem.rightBarButtonItems = @[settingItem, moonItem];
}

-(void)settingClick{
    [self.navigationController pushViewController:[[ttSettingVc alloc] initWithStyle:UITableViewStyleGrouped] animated:YES];
}

-(void)moonClick{
    ttLogFunc;
}

#pragma mark - tableView delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ttMeCell *cell = [tableView dequeueReusableCellWithIdentifier:ttMeId];
    
    if (indexPath.section == 0) {
        cell.imageView.image = [UIImage imageNamed:@"mine_icon_nearby"];
        cell.textLabel.text = @"登陆／注册";
    } else if(indexPath.section == 1){
        cell.textLabel.text = @"离线下载";
    }
    return cell;
}

@end
