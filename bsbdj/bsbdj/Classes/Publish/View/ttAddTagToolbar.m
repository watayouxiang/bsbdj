//
//  ttAddTagToolbar.m
//  bsbdj
//
//  Created by 王涛 on 16/8/9.
//  Copyright © 2016年 wata. All rights reserved.
//

#import "ttAddTagToolbar.h"
#import "ttAddTagVc.h"

@interface ttAddTagToolbar ()
/** 顶部控件 */
@property (weak, nonatomic) IBOutlet UIView *topView;
/** 添加按钮 */
@property (weak, nonatomic) UIButton *addButton;
/** 存放所有的标签label */
@property (nonatomic, strong) NSMutableArray *tagLabels;
@end

@implementation ttAddTagToolbar

- (NSMutableArray *)tagLabels {
    if (!_tagLabels) {
        _tagLabels = [NSMutableArray array];
    }
    return _tagLabels;
}

- (void)awakeFromNib {
    UIButton *addBtn = [[UIButton alloc] init];
    [addBtn addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [addBtn setImage:[UIImage imageNamed:@"tag_add_icon"] forState:UIControlStateNormal];
    addBtn.size = addBtn.currentImage.size;
    addBtn.x = ttTagMargin;
    [self.topView addSubview:addBtn];
    self.addButton = addBtn;
    
    //init with two btn
    [self createTagLabels:@[@"吐槽",@"臭事"]];
}

-(void)createTagLabels:(NSArray *)tags{
    [self.tagLabels makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.tagLabels removeAllObjects];
    
    for (int i=0; i<tags.count; i++) {
        UILabel *tagLabel = [[UILabel alloc] init];
        [self.tagLabels addObject:tagLabel];
        tagLabel.backgroundColor = ttTagBg;
        tagLabel.textAlignment = NSTextAlignmentCenter;
        tagLabel.text = tags[i];
        tagLabel.font = ttTagFont;
        //先设置文字和字体，再进行计算
        [tagLabel sizeToFit];
        tagLabel.width += 2 * ttTagMargin;
        tagLabel.height = ttTagH;
        tagLabel.textColor = [UIColor whiteColor];
        [self.topView addSubview:tagLabel];
    }
    
    //重新布局子控件
    [self setNeedsLayout];
}

-(void)addButtonClick{
    ttAddTagVc *vc = [[ttAddTagVc alloc] init];
    __weak typeof(self) weakSelf = self;
    [vc setTagsBlock:^(NSArray *tags) {
        [weakSelf createTagLabels:tags];
    }];
    vc.tags = [self.tagLabels valueForKeyPath:@"text"];
    UIViewController *root = [UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController *nav = (UINavigationController *)root.presentedViewController;
    [nav pushViewController:vc animated:YES];

}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    for (int i = 0; i<self.tagLabels.count; i++) {
        UILabel *tagLabel = self.tagLabels[i];
        
        // 设置位置
        if (i == 0) { // 最前面的标签
            tagLabel.x = 0;
            tagLabel.y = 0;
        } else { // 其他标签
            UILabel *lastTagLabel = self.tagLabels[i - 1];
            // 计算当前行左边的宽度
            CGFloat leftWidth = CGRectGetMaxX(lastTagLabel.frame) + ttTagMargin;
            // 计算当前行右边的宽度
            CGFloat rightWidth = self.topView.width - leftWidth;
            if (rightWidth >= tagLabel.width) { // 按钮显示在当前行
                tagLabel.y = lastTagLabel.y;
                tagLabel.x = leftWidth;
            } else { // 按钮显示在下一行
                tagLabel.x = 0;
                tagLabel.y = CGRectGetMaxY(lastTagLabel.frame) + ttTagMargin;
            }
        }
    }
    
    // 最后一个标签
    UILabel *lastTagLabel = [self.tagLabels lastObject];
    CGFloat leftWidth = CGRectGetMaxX(lastTagLabel.frame) + ttTagMargin;
    
    // 更新textField的frame
    if (self.topView.width - leftWidth >= self.addButton.width) {
        self.addButton.y = lastTagLabel.y;
        self.addButton.x = leftWidth;
    } else {
        self.addButton.x = 0;
        self.addButton.y = CGRectGetMaxY(lastTagLabel.frame) + ttTagMargin;
    }
    
    // 整体的高度
    CGFloat oldH = self.height;
    self.height = CGRectGetMaxY(self.addButton.frame) + 45;
    self.y -= self.height - oldH;
}


@end


















