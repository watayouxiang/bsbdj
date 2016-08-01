//
//  ttWebVc.m
//  bsbdj
//
//  Created by 王涛 on 16/8/1.
//  Copyright © 2016年 wata. All rights reserved.
//

#import "ttWebVc.h"
#import <NJKWebViewProgress.h>

@interface ttWebVc ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goBackItem;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goForwardItem;
@property (nonatomic, strong) NJKWebViewProgress *progress;
@end

@implementation ttWebVc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //create NJWebViewProgress
    self.progress = [[NJKWebViewProgress alloc] init];
    self.webView.delegate = self.progress;
    
    //setting NJWebViewProgress progress
    __weak typeof(self) weakSelf = self;
    self.progress.progressBlock = ^(float progress) {
        weakSelf.progressView.progress = progress;
        
        weakSelf.progressView.hidden = (progress == 1.0);
    };
    
    //NJWebViewProgress progress
    self.progress.webViewProxyDelegate = self;
    
    //loading webview page
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
}

- (IBAction)refresh:(id)sender {
    [self.webView reload];
}

- (IBAction)goBack:(id)sender {
    [self.webView goBack];
}

- (IBAction)goForward:(id)sender {
    [self.webView goForward];
}

#pragma mark - <UIWebViewDelegate>
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    self.goBackItem.enabled = webView.canGoBack;
    self.goForwardItem.enabled = webView.canGoForward;
}

@end
