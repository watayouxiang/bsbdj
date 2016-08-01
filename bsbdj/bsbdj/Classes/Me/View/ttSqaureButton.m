//
//  ttSqaureButton.m
//  bsbdj
//
//  Created by 王涛 on 16/8/1.
//  Copyright © 2016年 wata. All rights reserved.
//

#import "ttSqaureButton.h"
#import "ttSquare.h"
#import <UIButton+WebCache.h>

@implementation ttSqaureButton

- (void)awakeFromNib {
    [self setup];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    [self setBackgroundImage:[UIImage imageNamed:@"mainCellBackground"] forState:UIControlStateNormal];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 调整图片
    self.imageView.y = self.height * 0.15;
    self.imageView.width = self.width * 0.5;
    self.imageView.height = self.imageView.width;
    self.imageView.centerX = self.width * 0.5;
    
    // 调整文字
    self.titleLabel.x = 0;
    self.titleLabel.y = CGRectGetMaxY(self.imageView.frame);
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y;
}

- (void)setSquare:(ttSquare *)square {
    _square = square;
    
    [self setTitle:square.name forState:UIControlStateNormal];
    // 利用SDWebImage给按钮设置image
    [self sd_setImageWithURL:[NSURL URLWithString:square.icon] forState:UIControlStateNormal];
}

@end
