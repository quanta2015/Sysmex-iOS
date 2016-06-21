//
//  SampleDiagViewController.m
//  diagnosis
//
//  Created by QUANTA on 16/6/4.
//  Copyright © 2016年 sysmex. All rights reserved.
//

#import "SampleDiagViewController.h"


@interface SampleDiagViewController () {
    
    UIActivityIndicatorView *_activityView;
    NSUserDefaults *ud;
}

@end

@implementation SampleDiagViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initViews];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}

-(void)initViews{
    
    
    ud = [NSUserDefaults standardUserDefaults];
    NSString* usr = [ud objectForKey:@"userid"];
    NSString* pwd = [ud objectForKey:@"password"];
    NSString* barcode = [_sample objectForKey:@"barcode"];
    NSString* imgId = [_sample objectForKey:@"id"];
    NSString* height = [_sample objectForKey:@"height"];
    NSString* width = [_sample objectForKey:@"width"];
    NSString* maxzoom = [_sample objectForKey:@"maxzoom"];
    
    _urlStr = [NSString stringWithFormat:urlLoginToDiag, usr, pwd, barcode, imgId, height, width, maxzoom ];
    
    
    NSLog(@"%@",_urlStr);
    
    _webView.backgroundColor = DEFAULT_DARK_GRAY_COLOR;
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, screen_width, screen_height)];
    _webView.delegate = self;
    _webView.scalesPageToFit = YES;
    
    NSString *urlStr = [self.urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    [_webView loadRequest:request];
    [self.view addSubview: _webView];
    
    
    self.bridge = [WebViewJavascriptBridge bridgeForWebView:_webView];
    [_bridge registerHandler:@"testObjcCallback" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"testObjcCallback called: %@", data);
        [self.navigationController popViewControllerAnimated:NO];
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
