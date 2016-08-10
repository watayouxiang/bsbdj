//
//  ttAddTagVc.h
//  bsbdj
//
//  Created by 王涛 on 16/8/9.
//  Copyright © 2016年 wata. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ttAddTagVc : UIViewController
/** 获取tags的block */
@property (nonatomic, copy) void (^tagsBlock)(NSArray *tags);
/** 所有的标签 */
@property (nonatomic, strong) NSArray *tags;
@end
