//
//  SetPwdViewController.m
//  diagnosis
//
//  Created by QUANTA on 16/6/21.
//  Copyright © 2016年 sysmex. All rights reserved.
//

#import "SetPwdViewController.h"
#import "GVUserDefaults.h"
#import "GVUserDefaults+User.h"
#import "LoginViewController.h"
#import "AppDelegate.h"

@interface SetPwdViewController () {

    UITextField *password;
    UITextField *repwd;
    UILabel *userLabel;
    UILabel *userIdLabel;
    UILabel *pwdLabel;
    UILabel *repwdLabel;
}

@end

@implementation SetPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initSetPwdView];
    
    
}

- (void) initSetPwdView {
    
    self.title = NSLocalizedString(@"info-reset-pwd", nil);
    self.view.backgroundColor = DEFAULT_LIGHT_GRAY_COLOR;
    
    UIView *pwdView = [[UIView alloc] initWithFrame:CGRectMake(0, NAV_HEIGHT+50, screen_width, 135)];
    pwdView.backgroundColor = DEFAULT_WHITE_COLOR;
    [self.view addSubview:pwdView];
    
    for (int i =0; i<4; i++) {
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 45*i, screen_width, LINE_HEIGHT)];
        lineView.backgroundColor = DEFAULT_SEPARATER_COLOR;
        [pwdView addSubview:lineView];
    }
    
    INIT_LABEL(userLabel, M_MARGIN, 10, 100, 24, 16, DEFAULT_FONT_MID_COLOR , NSLocalizedString(@"username", nil), pwdView);
    INIT_LABEL_L(userIdLabel, 120, 10, screen_width - 120, 24, 16, DEFAULT_FONT_MID_COLOR, [GVUserDefaults standardUserDefaults].userId, pwdView);
    INIT_LABEL(pwdLabel, M_MARGIN, 10+45, 100, 24, 16, DEFAULT_FONT_MID_COLOR , NSLocalizedString(@"password", nil), pwdView);
    INIT_LABEL(pwdLabel, M_MARGIN, 10+45*2, 100, 24, 16, DEFAULT_FONT_MID_COLOR , NSLocalizedString(@"repwd", nil), pwdView);
    
    INIT_FIELD_P(password, 120, 10+45  , screen_width-120, 24, 16, NSLocalizedString(@"info-setpwd", nil), 0, DEFAULT_FONT_MID_COLOR, pwdView);
    INIT_FIELD_P(repwd,    120, 10+45*2, screen_width-120, 24, 16, NSLocalizedString(@"info-reenter", nil), 0, DEFAULT_FONT_MID_COLOR, pwdView);
    
    
    //查询按钮
    UIButton *queryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    queryBtn.frame = CGRectMake(L_MARGIN, NAV_HEIGHT + 200, screen_width-L_MARGIN*2, 40);
    queryBtn.titleLabel.font = [UIFont systemFontOfSize: 16];
    queryBtn.backgroundColor = DEFAULT_THEME_COLOR;
    queryBtn.layer.cornerRadius = 5;
    [queryBtn setAdjustsImageWhenDisabled:YES];
    [queryBtn setTitle:NSLocalizedString(@"confirm", nil) forState:UIControlStateNormal];
    [queryBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [queryBtn addTarget:self action:@selector(queryTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:queryBtn];
}


-(BOOL) pwdVaild {
    
    if (password.text.length == 0) {
        AlertMessage(NSLocalizedString(@"info-input-pwd", nil));
        return false;
    }
    
    if (repwd.text.length == 0) {
        AlertMessage(NSLocalizedString(@"info-input-repwd", nil));
        return false;
    }
    
    if (![password.text isEqualToString:repwd.text]) {
        AlertMessage(NSLocalizedString(@"info-pwd-not-equal", nil));
        return false;
    }
    return true;
}


- (void)queryTap:(UIButton *)sender{
    
    if ([self pwdVaild]) {
        [self getAjaxData];
    }
    
}




-(void)getAjaxData{

    NSDictionary *parameters = @{@"password":password.text};
    [[NetSingleton sharedManager] postDateToServer:parameters url:urlChangePwd successBlock:^(id responseBody){
        
        NSInteger code = [[responseBody objectForKey:@"code"] integerValue];
        if (code==0) {
            AlertMessage(NSLocalizedString(@"info-pwd-modify-success", nil));
            
            LoginViewController *loginSession = [[LoginViewController alloc] init];
            loginSession.relogin = 1;
            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            appDelegate.window.rootViewController = loginSession;
        } else {
            AlertMessage([responseBody objectForKey:@"message"]);
        }
    } failureBlock:^(NSString *error){
        NSLog(@"：%@",error);
        AlertMessage(error);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
