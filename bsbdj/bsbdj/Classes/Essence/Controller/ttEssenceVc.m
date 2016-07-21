//
//  ttEssenceVc.m
//  bsbdj
//
//  Created by 王涛 on 16/7/17.
//  Copyright © 2016年 wata. All rights reserved.
//

#import "ttEssenceVc.h"
#import "ttRecommendTagsVc.h"
#import "ttAllVc.h"
#import "ttVideoVc.h"
#import "ttVoiceVc.h"
#import "ttWordVc.h"
#import "ttPictureVc.h"

@interface ttEssenceVc ()<UIScrollViewDelegate>
/** 标签栏底部的红色指示器 */
@property (nonatomic, weak) UIView *indicatorView;
/** 当前选中的按钮 */
@property (nonatomic, weak) UIButton *selectedButton;
/** 顶部的所有标签 */
@property (nonatomic, weak) UIView *titlesView;
/** 底部的所有内容 */
@property (nonatomic, weak) UIScrollView *contentScrollView;
@end

@implementation ttEssenceVc

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 设置导航栏
    [self setupNav];
    
    // 初始化子控制器
    [self setupChildVces];
    
    // 设置顶部的标签栏
    [self setupTitlesView];
    
    // 底部的scrollView
    [self setupContentView];
}

#pragma mark - 底部的scrollView
- (void)setupContentView
{
    // 不要自动调整inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;//开启分页效果
    [self.view insertSubview:scrollView atIndex:0];//添加到当前控制器view的最底层
    scrollView.contentSize = CGSizeMake(scrollView.width * self.childViewControllers.count, 0);
    self.contentScrollView = scrollView;
    
    // 添加第一个控制器的view
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

#pragma mark - 设置顶部的标签栏
- (void)setupTitlesView
{
    // 标签栏整体
    UIView *titlesView = [[UIView alloc] init];
    titlesView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
    titlesView.width = self.view.width;
    titlesView.height = 35;
    titlesView.y = 64;//导航栏高度是64
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    
    // 内部的子标签
    NSArray *titles = @[@"全部", @"视频", @"声音", @"图片", @"段子"];
    CGFloat width = titlesView.width / titles.count;
    CGFloat height = titlesView.height;
    for (NSInteger i = 0; i<titles.count; i++) {
        
        UIButton *button = [[UIButton alloc] init];
        button.tag = i;
        
        button.height = height;
        button.width = width;
        button.x = i * width;
        
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [titlesView addSubview:button];
        
        // 默认点击了第一个按钮
        if (i == 0) {
            button.enabled = NO;
            self.selectedButton = button;
            
            // 让按钮内部的label根据文字内容来计算尺寸
            [button.titleLabel sizeToFit];
            self.indicatorView.width = button.titleLabel.width;
            self.indicatorView.centerX = button.centerX;
        }
    }
    
    // 底部的红色指示器
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = [UIColor redColor];
    indicatorView.height = 2;
    indicatorView.tag = -1;
    indicatorView.y = titlesView.height - indicatorView.height;
    self.indicatorView = indicatorView;
    [titlesView addSubview:indicatorView];
    
}

/**
 *  点击标题栏事件
 */
- (void)titleClick:(UIButton *)button
{
    // 修改按钮状态
    button.enabled = NO;
    self.selectedButton.enabled = YES;
    self.selectedButton = button;
    
    // 红色指示器动画
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.width = button.titleLabel.width;
        self.indicatorView.centerX = button.centerX;
    }];
    
    // 切换子控制器
    CGPoint offset = self.contentScrollView.contentOffset;
    offset.x = button.tag * self.contentScrollView.width;
    [self.contentScrollView setContentOffset:offset animated:YES];
}

#pragma mark - 初始化子控制器
- (void)setupChildVces
{
    ttAllVc *all = [[ttAllVc alloc] init];
    [self addChildViewController:all];
    
    ttVideoVc *video = [[ttVideoVc alloc] init];
    [self addChildViewController:video];
    
    ttVoiceVc *voice = [[ttVoiceVc alloc] init];
    [self addChildViewController:voice];
    
    ttPictureVc *picture = [[ttPictureVc alloc] init];
    [self addChildViewController:picture];
    
    ttWordVc *word = [[ttWordVc alloc] init];
    [self addChildViewController:word];
}

#pragma mark - 设置导航栏
- (void)setupNav
{
    // 设置导航栏标题
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    // 设置导航栏左边的按钮(UIBarButtonItem)
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
    
    // 设置背景色
    self.view.backgroundColor = ttGlobalBg;
}

- (void)tagClick
{
    ttRecommendTagsVc *tags = [[ttRecommendTagsVc alloc] init];
    [self.navigationController pushViewController:tags animated:YES];
}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    // 当前的索引
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    
    // 取出子控制器
    UITableViewController *vc = self.childViewControllers[index];
    vc.view.x = scrollView.contentOffset.x;
    vc.view.y = 0; // 设置控制器view的y值为0(默认是20)
    vc.view.height = scrollView.height; // 设置控制器view的height值为整个屏幕的高度(默认是比屏幕高度少个20)
    
    // 设置内边距
    CGFloat bottomInset = self.tabBarController.tabBar.height;
    CGFloat topInset = CGRectGetMaxY(self.titlesView.frame);
    vc.tableView.contentInset = UIEdgeInsetsMake(topInset, 0, bottomInset, 0);
    
    // 设置滚动条的内边距
    vc.tableView.scrollIndicatorInsets = vc.tableView.contentInset;
    [scrollView addSubview:vc.view];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    // 选中 "标题栏" 和 "红色指示器"
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    [self titleClick:self.titlesView.subviews[index]];
}


@end
