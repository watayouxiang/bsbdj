//
//  ttRecommendUserCell.m
//  bsbdj
//
//  Created by 王涛 on 16/7/18.
//  Copyright © 2016年 wata. All rights reserved.
//

#import "ttRecommendUserCell.h"
#import "ttRecommendUser.h"
#import "UIImageView+WebCache.h"

@interface ttRecommendUserCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *fansCountLabel;

@end

@implementation ttRecommendUserCell

-(void)setUser:(ttRecommendUser *)user{
    _user = user;
    self.screenNameLabel.text = user.screen_name;
    
    NSString *fansCount = nil;
    if (user.fans_count < 10000) {
        fansCount = [NSString stringWithFormat:@"%zd人关注", user.fans_count];
    }else{
        fansCount = [NSString stringWithFormat:@"%.1f万人关注", user.fans_count / 10000.0];
    }
    self.fansCountLabel.text = fansCount;
    
    //给URL直接设置图片, 如果无图则显示默认图片"defaultUserIcon"
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:user.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
}

@end
