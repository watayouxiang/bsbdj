//
//  ttFriendTrendsVc.m
//  bsbdj
//
//  Created by 王涛 on 16/7/17.
//  Copyright © 2016年 wata. All rights reserved.
//

#import "ttFriendTrendsVc.h"
#import "ttRecommendVc.h"
#import "ttLoginRegisterVc.h"

@interface ttFriendTrendsVc ()

@end

@implementation ttFriendTrendsVc

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = ttGlobalBg;
    self.navigationItem.title = @"我的关注";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" highImage:@"friendsRecommentIcon-click" target:self action:@selector(friendsClick)];
}

- (void)friendsClick {
    ttRecommendVc *vc = [[ttRecommendVc alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)loginRegister {
    ttLoginRegisterVc *login = [[ttLoginRegisterVc alloc] init];
    [self presentViewController:login animated:YES completion:nil];
}

@end
