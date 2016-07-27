//
//  ttTopicCell.m
//  bsbdj
//
//  Created by 王涛 on 16/7/25.
//  Copyright © 2016年 wata. All rights reserved.
//

#import "ttTopicCell.h"
#import "ttTopic.h"
#import <UIImageView+WebCache.h>
#import "ttTopicPictureView.h"

@interface ttTopicCell ()
/** 头像 */
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
/** 昵称 */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/** 时间 */
@property (weak, nonatomic) IBOutlet UILabel *createTimeLabel;
/** 顶 */
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
/** 踩 */
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
/** 分享 */
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
/** 评论 */
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
/** 新浪加V */
@property (weak, nonatomic) IBOutlet UIImageView *sinaVView;
/** 帖子的文字内容 */
@property (weak, nonatomic) IBOutlet UILabel *text_label;
/** 图片帖子中间的内容 */
@property (nonatomic, weak) ttTopicPictureView *pictureView;
@end

@implementation ttTopicCell

#pragma mark - 懒加载pictureView
- (ttTopicPictureView *)pictureView {
    if (!_pictureView) {
        ttTopicPictureView *pictureView = [ttTopicPictureView pictureView];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}

#pragma mark - 加载xib
- (void)awakeFromNib {
    [super awakeFromNib];
    
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;
}

#pragma mark - 重写setTopic
- (void)setTopic:(ttTopic *)topic {
    _topic = topic;
    
    // 新浪加V
    self.sinaVView.hidden = !topic.isSina_v;
    
    // 设置头像
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    // 设置名字
    self.nameLabel.text = topic.name;
    
    // 设置帖子的创建时间
    self.createTimeLabel.text = topic.create_time;
    
    // 设置按钮文字
    [self setupButtonTitle:self.dingButton count:topic.ding placeholder:@"顶"];
    [self setupButtonTitle:self.caiButton count:topic.cai placeholder:@"踩"];
    [self setupButtonTitle:self.shareButton count:topic.repost placeholder:@"分享"];
    [self setupButtonTitle:self.commentButton count:topic.comment placeholder:@"评论"];
    
    // 设置帖子的文字内容
    self.text_label.text = topic.text;
    
    // 根据帖子类型添加对应的内容到cell的中间
    if (topic.type == ttTopicTypePicture) { // 图片帖子
        self.pictureView.topic = topic;
        self.pictureView.frame = topic.pictureF;
    } else if (topic.type == ttTopicTypeVoice) { // 声音帖子
        
        //...
    }
}

#pragma mark - 设置底部按钮文字
- (void)setupButtonTitle:(UIButton *)button count:(NSInteger)count placeholder:(NSString *)placeholder {
    if (count > 10000) {
        placeholder = [NSString stringWithFormat:@"%.1f万", count / 10000.0];
    } else if (count > 0) {
        placeholder = [NSString stringWithFormat:@"%zd", count];
    }
    [button setTitle:placeholder forState:UIControlStateNormal];
}

#pragma mark - 重新设置cell的frame
- (void)setFrame:(CGRect)frame {
    
    frame.origin.x = ttTopicCellMargin;
    frame.size.width -= 2 * ttTopicCellMargin;
    frame.size.height -= ttTopicCellMargin;
    frame.origin.y += ttTopicCellMargin;
    
    [super setFrame:frame];
}


@end
