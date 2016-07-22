//
//  ttTextField.m
//  bsbdj
//
//  Created by 王涛 on 16/7/22.
//  Copyright © 2016年 wata. All rights reserved.
//
/**
 * 运行时(Runtime):
 * 苹果官方一套C语言库
 * 能做很多底层操作(比如访问隐藏的一些成员变量\成员方法....)
 */

#import "ttTextField.h"

static NSString * const ttPlacerholderColorKeyPath = @"_placeholderLabel.textColor";

@implementation ttTextField


- (void)awakeFromNib {
    
    // 设置光标颜色和文字颜色一致
    self.tintColor = self.textColor;
    
    // 不成为第一响应者
    [self resignFirstResponder];
}

/**
 * 当前文本框聚焦时就会调用
 */
- (BOOL)becomeFirstResponder {
    // 修改占位文字颜色
    [self setValue:self.textColor forKeyPath:ttPlacerholderColorKeyPath];
    return [super becomeFirstResponder];
}

/**
 * 当前文本框失去焦点时就会调用
 */
- (BOOL)resignFirstResponder {
    // 修改占位文字颜色
    [self setValue:[UIColor grayColor] forKeyPath:ttPlacerholderColorKeyPath];
    return [super resignFirstResponder];
}

@end
