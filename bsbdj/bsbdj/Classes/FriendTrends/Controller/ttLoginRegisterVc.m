//
//  ttLoginRegisterVc.m
//  bsbdj
//
//  Created by 王涛 on 16/7/21.
//  Copyright © 2016年 wata. All rights reserved.
//

#import "ttLoginRegisterVc.h"

@interface ttLoginRegisterVc ()

@end

@implementation ttLoginRegisterVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 * 让当前控制器对应的状态栏是白色
 */
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
