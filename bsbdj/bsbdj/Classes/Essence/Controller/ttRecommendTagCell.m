//
//  ttRecommendTagCell.m
//  bsbdj
//
//  Created by 王涛 on 16/7/19.
//  Copyright © 2016年 wata. All rights reserved.
//

#import "ttRecommendTagCell.h"
#import "ttRecommendTag.h"
#import "UIImageView+WebCache.h"

@interface ttRecommendTagCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageListImageView;
@property (weak, nonatomic) IBOutlet UILabel *themeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *subNumberLabel;
@end

@implementation ttRecommendTagCell

-(void)setRecommendTag:(ttRecommendTag *)recommendTag{
    _recommendTag = recommendTag;
    
    [self.imageListImageView sd_setImageWithURL:[NSURL URLWithString:recommendTag.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.themeNameLabel.text = recommendTag.theme_name;
    NSString *subNumber = nil;
    if (recommendTag.sub_number < 10000) {
        subNumber = [NSString stringWithFormat:@"%zd人订阅", recommendTag.sub_number];
    } else { // 大于等于10000
        subNumber = [NSString stringWithFormat:@"%.1f万人订阅", recommendTag.sub_number / 10000.0];
    }
    self.subNumberLabel.text = subNumber;
}

#pragma mark - 重新布局cell
- (void)setFrame:(CGRect)frame {
    frame.origin.x = 5;
    frame.size.width -= 2 * frame.origin.x;
    frame.size.height -= 2;
    
    [super setFrame:frame];
}

@end
