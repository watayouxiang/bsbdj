//
//  ttTagTextField.m
//  bsbdj
//
//  Created by 王涛 on 16/8/9.
//  Copyright © 2016年 wata. All rights reserved.
//

#import "ttTagTextField.h"

@implementation ttTagTextField

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.placeholder = @"多个标签用逗号或者换行隔开";
        // 设置了占位文字内容以后, 才能设置占位文字的颜色
        [self setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
        self.height = ttTagH;
    }
    return self;
}

- (void)deleteBackward {
    //block有值就执行
    !self.deleteBlock ? : self.deleteBlock();
    
    [super deleteBackward];
}

@end
