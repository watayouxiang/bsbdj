//
//  ttRecommendCategoryCell.m
//  bsbdj
//
//  Created by 王涛 on 16/7/18.
//  Copyright © 2016年 wata. All rights reserved.
//

#import "ttRecommendCategoryCell.h"
#import "ttRecommendCategory.h"

@interface ttRecommendCategoryCell ()
@property (weak, nonatomic) IBOutlet UIView *indicatorView;

@end

@implementation ttRecommendCategoryCell

- (void)awakeFromNib {
    //[super awakeFromNib];
    self.backgroundColor = ttRGBColor(244, 244, 244);
    self.indicatorView.backgroundColor = ttRGBColor(219, 21, 26);
    
}

//重写category的set方法
-(void)setCategory:(ttRecommendCategory *)category{
    _category = category;
    self.textLabel.text = category.name;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    //调整内部的textLabel的frame
    self.textLabel.y = 2;
    self.textLabel.height = self.contentView.height - 2 * self.textLabel.y;
}

//选中cell调用的方法
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    //如果没选中就隐藏indicatorView
    self.indicatorView.hidden = !selected;
    self.textLabel.textColor = selected ? self.indicatorView.backgroundColor : ttRGBColor(78, 78, 78);
}

@end
