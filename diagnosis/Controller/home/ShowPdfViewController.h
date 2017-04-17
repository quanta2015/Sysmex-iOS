//
//  ShowPdfViewController.h
//  diagnosis
//
//  Created by QUANTA on 16/10/31.
//  Copyright © 2016年 sysmex. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowPdfViewController : UIViewController


@property(nonatomic, strong) NSString *barcode;
@property(nonatomic, strong) NSString *urlStr;
@property(nonatomic, strong) UIWebView *webView;

@end
