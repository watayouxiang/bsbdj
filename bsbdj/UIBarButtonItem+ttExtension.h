//
//  UIBarButtonItem+ttExtension.h
//  bsbdj
//
//  Created by 王涛 on 16/7/17.
//  Copyright © 2016年 wata. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (ttExtension)

+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;

@end
