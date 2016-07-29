//
//  ttCommentCell.m
//  bsbdj
//
//  Created by 王涛 on 16/7/29.
//  Copyright © 2016年 wata. All rights reserved.
//

#import "ttCommentCell.h"
#import "ttComment.h"
#import <UIImageView+WebCache.h>
#import "ttUser.h"

@interface ttCommentCell ()
/** 头像 */
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
/** 性别 */
@property (weak, nonatomic) IBOutlet UIImageView *sexView;
/** 评论内容 */
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
/** 用户名 */
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
/** 热度 */
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;
/** 语音评论 */
@property (weak, nonatomic) IBOutlet UIButton *voiceButton;
@end

@implementation ttCommentCell

- (void)awakeFromNib {
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;
}

- (void)setComment:(ttComment *)comment {
    _comment = comment;
    
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:comment.user.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.sexView.image = [comment.user.sex isEqualToString:ttUserSexMale] ? [UIImage imageNamed:@"Profile_manIcon"] : [UIImage imageNamed:@"Profile_womanIcon"];
    self.contentLabel.text = comment.content;
    self.usernameLabel.text = comment.user.username;
    self.likeCountLabel.text = [NSString stringWithFormat:@"%zd", comment.like_count];
    
    if (comment.voiceuri.length) {
        self.voiceButton.hidden = NO;
        [self.voiceButton setTitle:[NSString stringWithFormat:@"%zd''", comment.voicetime] forState:UIControlStateNormal];
    } else {
        self.voiceButton.hidden = YES;
    }
}

- (void)setFrame:(CGRect)frame {
    frame.origin.x = ttTopicCellMargin;
    frame.size.width -= 2 * ttTopicCellMargin;
    
    [super setFrame:frame];
}

@end
