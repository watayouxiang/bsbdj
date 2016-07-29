//
//  ttCommentCell.h
//  bsbdj
//
//  Created by 王涛 on 16/7/29.
//  Copyright © 2016年 wata. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ttComment;

@interface ttCommentCell : UITableViewCell
/** 评论 */
@property (nonatomic, strong) ttComment *comment;
@end
