//
//  ShowPdfViewController.m
//  diagnosis
//
//  Created by QUANTA on 16/10/31.
//  Copyright © 2016年 sysmex. All rights reserved.
//

#import "ShowPdfViewController.h"

@interface ShowPdfViewController ()

@end

@implementation ShowPdfViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
}


- (void)initView {
    
    HIDDEN_SCROLLVIEW;
    self.title = NSLocalizedString(@"diag-advise", nil);
    self.navigationController.navigationBar.backItem.title = @"";
    
    _webView.backgroundColor = DEFAULT_DARK_GRAY_COLOR;
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, screen_width, screen_height)];
    _webView.delegate = self;
    _webView.scalesPageToFit = YES;
    
    _urlStr = [NSString stringWithFormat:urlPrintPdf, _barcode];
    
    NSString *urlStr = [self.urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    [_webView loadRequest:request];
    [self.view addSubview: _webView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
