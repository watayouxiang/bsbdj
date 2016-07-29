//
//  ttTopicCell.h
//  bsbdj
//
//  Created by 王涛 on 16/7/25.
//  Copyright © 2016年 wata. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ttTopic;

@interface ttTopicCell : UITableViewCell

/** 帖子数据 */
@property (nonatomic, strong) ttTopic *topic;

+ (instancetype)cell;

@end
