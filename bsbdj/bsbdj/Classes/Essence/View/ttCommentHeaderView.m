//
//  ttCommentHeaderView.m
//  bsbdj
//
//  Created by 王涛 on 16/7/29.
//  Copyright © 2016年 wata. All rights reserved.
//

#import "ttCommentHeaderView.h"

@interface ttCommentHeaderView ()
/** 文字标签 */
@property (nonatomic, weak) UILabel *label;
@end

@implementation ttCommentHeaderView

#pragma mark - 创建HeaderView
+ (instancetype)headerViewWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"header";
    ttCommentHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (header == nil) { // 缓存池中没有, 自己创建
        header = [[ttCommentHeaderView alloc] initWithReuseIdentifier:ID];
    }
    return header;
}

#pragma mark - 重写控件复用方法
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = ttGlobalBg;
        
        // 创建label
        UILabel *label = [[UILabel alloc] init];
        label.textColor = ttRGBColor(67, 67, 67);
        label.width = 200;
        label.x = ttTopicCellMargin;
        label.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [self.contentView addSubview:label];
        self.label = label;
    }
    return self;
}

#pragma mark - 重写title属性set方法
- (void)setTitle:(NSString *)title
{
    _title = [title copy];
    
    self.label.text = title;
}


@end
