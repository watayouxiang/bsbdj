//
//  ttPostWordVc.m
//  bsbdj
//
//  Created by 王涛 on 16/8/9.
//  Copyright © 2016年 wata. All rights reserved.
//

#import "ttPostWordVc.h"
#import "ttPlaceholderTextView.h"
#import "ttAddTagToolbar.h"

@interface ttPostWordVc ()<UITextViewDelegate>
/** 文本输入控件 */
@property (nonatomic, weak) ttPlaceholderTextView *textView;
/** 工具条 */
@property (nonatomic, weak) ttAddTagToolbar *toolbar;
@end

@implementation ttPostWordVc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    [self setupTextView];
    [self setupToolbar];
}

#pragma mark - 重写的方法
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // 先退出之前的键盘
    [self.view endEditing:YES];
    // 再叫出键盘
    [self.textView becomeFirstResponder];
}

#pragma mark - set toolBar
- (void)setupToolbar {
    ttAddTagToolbar *toolbar = [ttAddTagToolbar viewFromXib];
    toolbar.width = self.view.width;
    toolbar.y = self.view.height - toolbar.height;
    [self.view addSubview:toolbar];
    self.toolbar = toolbar;
    
    [ttNoteCenter addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

/**
 * 监听键盘的弹出和隐藏
 */
- (void)keyboardWillChangeFrame:(NSNotification *)note {
    // 键盘最终的frame
    CGRect keyboardF = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // 动画时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        self.toolbar.transform = CGAffineTransformMakeTranslation(0,  keyboardF.origin.y - ttScreenH);
    }];
}

#pragma mark - set NavigationController
-(void)setupNav{
    self.title = @"表达文字";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发表" style:UIBarButtonItemStyleDone target:self action:@selector(post)];
    
    self.navigationItem.rightBarButtonItem.enabled = NO;
    //强制布局，否则item依旧可以点击
    [self.navigationController.navigationBar layoutIfNeeded];
}

- (void)cancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)post {
    ttLogFunc;
}

#pragma mark - set textView
-(void)setupTextView{
    ttPlaceholderTextView *textView = [[ttPlaceholderTextView alloc] init];
    textView.placeholder = @"把好玩的图片，好笑的段子或糗事发到这里，接受千万网友膜拜吧！发布违反国家法律内容的，我们将依法提交给有关部门处理。";
    textView.frame = self.view.bounds;
    textView.delegate = self;
    [self.view addSubview:textView];
    self.textView = textView;
}

#pragma mark - <UITextViewDelegate>
-(void)textViewDidChange:(UITextView *)textView{
    self.navigationItem.rightBarButtonItem.enabled = textView.hasText;
}

#pragma mark - <UIScrollViewDelegate>
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

@end
