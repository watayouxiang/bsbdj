//
//  UIImageView+ttExtension.m
//  bsbdj
//
//  Created by 王涛 on 16/7/29.
//  Copyright © 2016年 wata. All rights reserved.
//

#import "UIImageView+ttExtension.h"
#import <UIImageView+WebCache.h>

@implementation UIImageView (ttExtension)

- (void)setHeader:(NSString *)url {
    
    UIImage *placeholder = [[UIImage imageNamed:@"defaultUserIcon"] circleImage];
    
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.image = image ? [image circleImage] : placeholder;
    }];
    
}

@end
