//
//  ttTagTextField.h
//  bsbdj
//
//  Created by 王涛 on 16/8/9.
//  Copyright © 2016年 wata. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ttTagTextField : UITextField
/** 按了删除键后的回调 */
@property (nonatomic, copy) void (^deleteBlock)();
@end
