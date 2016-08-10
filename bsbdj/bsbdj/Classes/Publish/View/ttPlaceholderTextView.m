//
//  ttPlaceholderTextView.m
//  bsbdj
//
//  Created by 王涛 on 16/8/9.
//  Copyright © 2016年 wata. All rights reserved.
//

/**
 * setNeedsDisplay方法 : 会在恰当的时刻自动调用drawRect:方法
 * setNeedsLayout方法 : 会在恰当的时刻调用layoutSubviews方法
 */

#import "ttPlaceholderTextView.h"

@interface ttPlaceholderTextView ()
/** 占位文字label */
@property (nonatomic, weak) UILabel *placeholderLabel;
@end

@implementation ttPlaceholderTextView

-(UILabel *)placeholderLabel{
    if (!_placeholderLabel) {
        //添加一个现实占位文字的label
        UILabel *placeholderLabel = [[UILabel alloc] init];
        placeholderLabel.numberOfLines = 0;
        placeholderLabel.x = 4;
        placeholderLabel.y = 7;
        [self addSubview:placeholderLabel];
        _placeholderLabel = placeholderLabel;
    }
    return _placeholderLabel;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //垂直方向始终有弹簧效果
        self.alwaysBounceVertical = YES;
        self.font = [UIFont systemFontOfSize:15];
        self.placeholderColor = [UIColor grayColor];
        //监听文字改变
        [ttNoteCenter addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}

-(void)textDidChange{
    //只要有文字改变就隐藏占位文字
    self.placeholderLabel.hidden = self.hasText;
}

-(void)dealloc{
    [ttNoteCenter removeObserver:self];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    //更新文字的尺寸
    self.placeholderLabel.width = self.width - 2 * self.placeholderLabel.x;
    [self.placeholderLabel sizeToFit];
}

#pragma mark - rewrite setter
-(void)setPlaceholderColor:(UIColor *)placeholderColor{
    _placeholderColor = placeholderColor;
    
    self.placeholderLabel.textColor = placeholderColor;
}

-(void)setPlaceholder:(NSString *)placeholder{
    _placeholder = [placeholder copy];
    
    self.placeholderLabel.text = placeholder;
    [self setNeedsLayout];
}

-(void)setFont:(UIFont *)font{
    [super setFont:font];
    
    self.placeholderLabel.font = font;
    [self setNeedsLayout];
}

-(void)setText:(NSString *)text{
    [super setText:text];
    
    [self textDidChange];
}

-(void)setAttributedText:(NSAttributedString *)attributedText{
    [super setAttributedText:attributedText];
    
    [self textDidChange];
}

@end











