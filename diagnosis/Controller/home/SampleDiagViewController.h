//
//  SampleDiagViewController.h
//  diagnosis
//
//  Created by QUANTA on 16/6/4.
//  Copyright © 2016年 sysmex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebViewJavascriptBridge.h"

@interface SampleDiagViewController : UIViewController <UIWebViewDelegate>

@property (nonatomic, strong) NSDictionary *sample;

@property(nonatomic, strong) NSString *urlStr;

@property(nonatomic, strong) UIWebView *webView;
@property WebViewJavascriptBridge* bridge;

@end
