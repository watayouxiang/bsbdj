//
//  ttTopic.m
//  bsbdj
//
//  Created by 王涛 on 16/7/25.
//  Copyright © 2016年 wata. All rights reserved.
//

#import "ttTopic.h"
#import <MJExtension.h>
#import "ttComment.h"
#import "ttUser.h"

@implementation ttTopic
{
    CGFloat _cellHeight;
    CGRect _pictureF;
}

#pragma mark - 修改属性名字
+ (NSDictionary *)replacedKeyFromPropertyName {
    /**
     来自: MJExtension.h
     作用: 改名
     image0改为small_image
     image1改为large_image
     image2改为middle_image
     */
    return @{
             @"small_image" : @"image0",
             @"large_image" : @"image1",
             @"middle_image" : @"image2",
             @"ID" : @"id",
             @"top_cmt" : @"top_cmt[0]"
             };
}

#pragma mark - 重写create_time方法
- (NSString *)create_time {
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    // 帖子的创建时间
    NSDate *create = [fmt dateFromString:_create_time];
    
    if (create.isThisYear) { // 今年
        if (create.isToday) { // 今天
            NSDateComponents *cmps = [[NSDate date] deltaFrom:create];
            
            if (cmps.hour >= 1) { // 时间差距 >= 1小时
                return [NSString stringWithFormat:@"%zd小时前", cmps.hour];
            } else if (cmps.minute >= 1) { // 1小时 > 时间差距 >= 1分钟
                return [NSString stringWithFormat:@"%zd分钟前", cmps.minute];
            } else { // 1分钟 > 时间差距
                return @"刚刚";
            }
        } else if (create.isYesterday) { // 昨天
            fmt.dateFormat = @"昨天 HH:mm:ss";
            return [fmt stringFromDate:create];
        } else { // 其他
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt stringFromDate:create];
        }
    } else { // 非今年
        return _create_time;
    }
    
}

#pragma mark - 计算cell的高度
- (CGFloat)cellHeight {
    if (!_cellHeight) {
        
        // 计算文字的高度
        CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 4 * ttTopicCellMargin, MAXFLOAT);
        CGFloat textH = [self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.height;
        
        /**  cell的高度 */
        
        //1. 文字部分的高度
        _cellHeight = ttTopicCellTextY + textH + ttTopicCellMargin;
        
        //2. 根据段子的类型来计算cell的高度
        if (self.type == ttTopicTypePicture) { // 图片帖子
            // 图片显示出来的宽度
            CGFloat pictureW = maxSize.width;
            // 显示显示出来的高度
            CGFloat pictureH = pictureW * self.height / self.width;
            if (pictureH >= ttTopicCellPictureMaxH) { // 图片高度过长
                pictureH = ttTopicCellPictureBreakH;
                self.bigPicture = YES; // 说明是大图
            }
            
            // 计算图片控件的frame
            CGFloat pictureX = ttTopicCellMargin;
            CGFloat pictureY = ttTopicCellTextY + textH + ttTopicCellMargin;
            _pictureF = CGRectMake(pictureX, pictureY, pictureW, pictureH);
            
            _cellHeight += pictureH + ttTopicCellMargin;
        } else if (self.type == ttTopicTypeVoice) { // 声音帖子
            CGFloat voiceX = ttTopicCellMargin;
            CGFloat voiceY = ttTopicCellTextY + textH + ttTopicCellMargin;
            CGFloat voiceW = maxSize.width;
            CGFloat voiceH = voiceW * self.height / self.width;
            _voiceF = CGRectMake(voiceX, voiceY, voiceW, voiceH);
            
            _cellHeight += voiceH + ttTopicCellMargin;
        } else if (self.type == ttTopicTypeVideo) { // 视频帖子
            CGFloat videoX = ttTopicCellMargin;
            CGFloat videoY = ttTopicCellTextY + textH + ttTopicCellMargin;
            CGFloat videoW = maxSize.width;
            CGFloat videoH = videoW * self.height / self.width;
            _videoF = CGRectMake(videoX, videoY, videoW, videoH);
            
            _cellHeight += videoH + ttTopicCellMargin;
        }
        
        // 3. 如果有最热评论
        if (self.top_cmt) {
            NSString *content = [NSString stringWithFormat:@"%@ : %@", self.top_cmt.user.username, self.top_cmt.content];
            CGFloat contentH = [content boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13]} context:nil].size.height;
            _cellHeight += ttTopicCellTopCmtTitleH + contentH + ttTopicCellMargin;
        }
        
        //4. 底部工具条的高度
        CGFloat cellBottonBarH = ttTopicCellBottomBarH + ttTopicCellMargin;
        
        // cell的最终高度
        _cellHeight += cellBottonBarH;
    }
    return _cellHeight;
}


@end
