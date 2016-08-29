//
//  DiagnosisViewController.m
//  diagnosis
//
//  Created by QUANTA on 16/8/29.
//  Copyright © 2016年 sysmex. All rights reserved.
//

#import "DiagnosisViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface DiagnosisViewController()<UITextFieldDelegate>

@end

@implementation DiagnosisViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
}

- (void)initView {
    
    HIDDEN_SCROLLVIEW;
    
    self.title = @"诊断";
    self.navigationController.navigationBar.backItem.title = @"";
    
    _diagTextView = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, screen_width - 20, screen_height-NAV_HEIGHT-80)];
    _diagTextView.backgroundColor=DEFAULT_WHITE_COLOR;
    _diagTextView.editable = YES;
    _diagTextView.delegate = self;
    _diagTextView.layer.borderColor = DEFAULT_LINE_GRAY_COLOR.CGColor;
    _diagTextView.layer.borderWidth =1.0;
    _diagTextView.layer.cornerRadius =5.0;
    _diagTextView.font=[UIFont fontWithName:@"Arial" size:18.0]; //设置字体名字和字体大小;
    [self.view addSubview:_diagTextView];
    
    //查询按钮
    UIButton *diagBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    diagBtn.frame = CGRectMake(M_MARGIN, screen_height - NAV_HEIGHT - 55, screen_width-M_MARGIN*2, 40);
    diagBtn.titleLabel.font = [UIFont systemFontOfSize: 16];
    diagBtn.backgroundColor = DEFAULT_THEME_COLOR;
    diagBtn.layer.cornerRadius = 5;
    [diagBtn setAdjustsImageWhenDisabled:YES];
    [diagBtn setTitle:@"确定" forState:UIControlStateNormal];
    [diagBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [diagBtn addTarget:self action:@selector(diagTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:diagBtn];
    
    [self getDiagInfo];
}

- (void)getDiagInfo{
    
    NSDictionary *parameters = @{@"barcode":_barcode,@"experterid":@"0"};
    [[NetSingleton sharedManager] getDateFormServer:parameters url:urlGetDiagnoseInfo successBlock:^(id responseBody){
        
        NSInteger code = [[responseBody objectForKey:@"code"] integerValue];
        if (code==0) {
            
            NSDictionary *data = [responseBody objectForKey:@"data"];
            _diagTextView.text = [data objectForKey:@"expertdiagnose"];
        } else {
            AlertMessage([responseBody objectForKey:@"message"]);
        }
    } failureBlock:^(NSString *error){
        NSLog(@"：%@",error);
        AlertMessage(error);
    }];
}



- (void)diagTap:(UIButton *)sender{
    
    NSDictionary *parameters = @{@"barcode":_barcode, @"diagnoseinfo":_diagTextView.text};
    [[NetSingleton sharedManager] postDateToServer:parameters url:urlSaveDiagnoseInfo successBlock:^(id responseBody){
        
        NSInteger code = [[responseBody objectForKey:@"code"] integerValue];
        if (code==0) {
            [self.navigationController popViewControllerAnimated:NO];
        } else {
            AlertMessage([responseBody objectForKey:@"message"]);
        }
    } failureBlock:^(NSString *error){
        NSLog(@"：%@",error);
        AlertMessage(error);
    }];
    
}

//回车关闭键盘
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
