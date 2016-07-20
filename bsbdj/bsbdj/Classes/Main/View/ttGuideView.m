//
//  ttGuideView.m
//  bsbdj
//
//  Created by 王涛 on 16/7/20.
//  Copyright © 2016年 wata. All rights reserved.
//

#import "ttGuideView.h"

@implementation ttGuideView

+ (void)show
{
    NSString *key = @"CFBundleShortVersionString";
    
    // 获得当前软件的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    // 获得沙盒中存储的版本号
    NSString *sanboxVersion = [[NSUserDefaults standardUserDefaults] stringForKey:key];
    
    if (![currentVersion isEqualToString:sanboxVersion]) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        
        ttGuideView *guideView = [ttGuideView guideView];
        guideView.frame = window.bounds;
        [window addSubview:guideView];
        
        // 存储版本号
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

+ (instancetype)guideView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (IBAction)close {
    [self removeFromSuperview];
}


@end
