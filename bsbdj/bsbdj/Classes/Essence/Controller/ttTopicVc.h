//
//  ttTopicVc.h
//  bsbdj
//
//  Created by 王涛 on 16/7/25.
//  Copyright © 2016年 wata. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    ttTopicTypeAll = 1,
    ttTopicTypePicture = 10,
    ttTopicTypeWord = 29,
    ttTopicTypeVoice = 31,
    ttTopicTypeVideo = 41
} ttTopicType;

@interface ttTopicVc : UITableViewController
/** 帖子类型 */
@property (nonatomic, assign) ttTopicType type;
@end
