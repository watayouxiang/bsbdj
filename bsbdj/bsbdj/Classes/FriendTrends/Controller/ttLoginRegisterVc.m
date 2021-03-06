//
//  ttLoginRegisterVc.m
//  bsbdj
//
//  Created by 王涛 on 16/7/21.
//  Copyright © 2016年 wata. All rights reserved.
//

#import "ttLoginRegisterVc.h"

@interface ttLoginRegisterVc ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginViewLeftMargin;

@end

@implementation ttLoginRegisterVc

- (void)viewDidLoad{
    [super viewDidLoad];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    /**
     配置文件里设置: View controller-based status bar appearance = NO
     这样状态栏的颜色就不再是由ViewController处理了, 而是由UIApplication来处理
     */
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

/**
 *  登录或注册
 */
- (IBAction)loginOrRegisterBtn:(id)sender {
    UIButton *button = (UIButton *)sender;
    
    // 退出键盘
    [self.view endEditing:YES];
    
    if (self.loginViewLeftMargin.constant == 0) { // 显示注册界面
        self.loginViewLeftMargin.constant = - self.view.width;
        button.selected = YES;
    } else { // 显示登录界面
        self.loginViewLeftMargin.constant = 0;
        button.selected = NO;
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];//立即刷新布局
    }];
}

/**
 *  点击退出键盘
 */
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

/**
 *  返回
 */
- (IBAction)back:(UIButton *)sender {
    /**
     配置文件里设置: View controller-based status bar appearance = NO
     这样状态栏的颜色就不再是由ViewController处理了, 而是由UIApplication来处理
     */
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
    // 退出键盘
    [self.view endEditing:YES];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
