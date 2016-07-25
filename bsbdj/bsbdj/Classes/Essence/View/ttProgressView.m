//
//  ttProgressView.m
//  bsbdj
//
//  Created by 王涛 on 16/7/25.
//  Copyright © 2016年 wata. All rights reserved.
//

#import "ttProgressView.h"

@implementation ttProgressView

- (void)awakeFromNib {
    self.roundedCorners = 2;
    self.progressLabel.textColor = [UIColor whiteColor];
}

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated {
    [super setProgress:progress animated:animated];
    
    NSString *text = [NSString stringWithFormat:@"%.0f%%", progress * 100];
    self.progressLabel.text = [text stringByReplacingOccurrencesOfString:@"-" withString:@""];
}

@end
