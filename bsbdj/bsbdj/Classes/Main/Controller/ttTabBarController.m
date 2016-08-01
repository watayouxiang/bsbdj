//
//  ttTabBarController.m
//  bsbdj
//
//  Created by 王涛 on 16/7/17.
//  Copyright © 2016年 wata. All rights reserved.
//

#import "ttTabBarController.h"
#import "ttMeVc.h"
#import "ttNewVc.h"
#import "ttEssenceVc.h"
#import "ttFriendTrendsVc.h"
#import "ttNavigationController.h"
#import "ttTabBar.h"

@interface ttTabBarController ()

@end

@implementation ttTabBarController

//类创建仅调用一次的方法
+(void)initialize{
    //默认tabBar的字号和颜色
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    //选中tabBar的字号和颜色
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    //通过appearance设置全局tabBar
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加子控制器
    [self setupChildVc:[[ttEssenceVc alloc] init] title:@"精华" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    [self setupChildVc:[[ttNewVc alloc] init] title:@"新帖" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
    [self setupChildVc:[[ttFriendTrendsVc alloc] init] title:@"关注" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
    [self setupChildVc:[[ttMeVc alloc] initWithStyle:UITableViewStyleGrouped] title:@"我" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
    
    //更换自定义tabBar
    [self setValue:[[ttTabBar alloc] init] forKeyPath:@"tabBar"];
}


- (void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage {
    
    //导航栏标题
    vc.navigationItem.title = title;
    //tabBar标题和图片
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //包装一个导航控制器, 添加到tabbarcontroller中
    ttNavigationController *nav = [[ttNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
}

@end
