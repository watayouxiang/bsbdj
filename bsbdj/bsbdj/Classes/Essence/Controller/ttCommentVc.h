//
//  ttCommentVc.h
//  bsbdj
//
//  Created by 王涛 on 16/7/29.
//  Copyright © 2016年 wata. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ttTopic;

@interface ttCommentVc : UIViewController
/** 帖子模型 */
@property (nonatomic, strong) ttTopic *topic;
@end
