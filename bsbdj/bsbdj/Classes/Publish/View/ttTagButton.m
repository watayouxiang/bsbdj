//
//  ttTagButton.m
//  bsbdj
//
//  Created by 王涛 on 16/8/9.
//  Copyright © 2016年 wata. All rights reserved.
//

#import "ttTagButton.h"

@implementation ttTagButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setImage:[UIImage imageNamed:@"chose_tag_close_icon"] forState:UIControlStateNormal];
        self.backgroundColor = ttTagBg;
        self.titleLabel.font = ttTagFont;
    }
    return self;
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state {
    [super setTitle:title forState:state];
    
    [self sizeToFit];
    
    self.width += 3 * ttTagMargin;
    self.height = ttTagH;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.titleLabel.x = ttTagMargin;
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame) + ttTagMargin;
}

@end
