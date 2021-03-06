//
//  LoginViewController.m
//  DAZD
//
//  Created by quanta on 15/9/23.
//  Copyright (c) 2015年 DIAN. All rights reserved.
//

#import "AppDelegate.h"

#import "LoginViewController.h"
#import "HomeViewController.h"
#import "QueryViewController.h"
#import "WorkViewController.h"
#import "ConfigViewController.h"

#import "SVProgressHUD.h"
#import "UserModel.h"
#import "GVUserDefaults.h"
#import "GVUserDefaults+User.h"


@interface LoginViewController () <UITextFieldDelegate> {

    UITextField *username;
    UITextField *password;
    NSString *user;
    NSString *pwd;

    NSUserDefaults *ud;
    UserModel *userM;
}

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initLoginView];
}

-(void) initLoginView {

    self.view.backgroundColor = DEFAULT_GREG_COLOR;
    self.navigationItem.title = NSLocalizedString(@"userlogin", nil) ; //@"用户登录";
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(screen_width*0.05, 100, screen_width*0.9, 100)];
    backView.backgroundColor = DEFAULT_WHITE_COLOR;
    backView.layer.cornerRadius = 10;
    backView.layer.borderWidth = 1.0;
    backView.layer.borderColor = DEFAULT_LINE_GRAY_COLOR.CGColor;
    [self.view addSubview:backView];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 50, screen_width*0.9, 1)];
    lineView.backgroundColor = DEFAULT_LINE_GRAY_COLOR;
    [backView addSubview:lineView];
    
    UIImageView *userImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 32, 32)];
    [userImage setImage:[UIImage imageNamed:@"icon-login-user"]];
    [backView addSubview:userImage];
    
    UIImageView *pwdImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 60, 32, 32)];
    [pwdImage setImage:[UIImage imageNamed:@"icon-login-password"]];
    [backView addSubview:pwdImage];
    
    username = [[UITextField alloc] initWithFrame:CGRectMake(60, 10, 150, 30)];
    username.placeholder = NSLocalizedString(@"username", nil); //@"用户名";
    username.delegate = self;
    [backView addSubview:username];
    
    password = [[UITextField alloc] initWithFrame:CGRectMake(60, 60, 150, 30)];
    password.placeholder = NSLocalizedString(@"password", nil); //@"密码";
    password.secureTextEntry = YES;
    password.delegate = self;
    [backView addSubview:password];
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = CGRectMake(screen_width*0.05, 200+60, screen_width*0.9, 40);
    loginBtn.titleLabel.font = [UIFont systemFontOfSize: 20];
    loginBtn.backgroundColor = DEFAULT_THEME_COLOR;
    loginBtn.layer.cornerRadius = 5;
    [loginBtn setTitle:NSLocalizedString(@"login", nil) forState:UIControlStateNormal];
    [loginBtn setTitleColor:DEFAULT_WHITE_COLOR forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(LoginBtnTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
    ud = [NSUserDefaults standardUserDefaults];
    username.text = [ud objectForKey:@"userid"];
    password.text = [ud objectForKey:@"password"];
}

-(void)LoginBtnTap:(UIButton *)sender{
    
    NSLog(@"%@",@"logining......");
    if ([username.text  isEqual: @""]) {
        AlertMessage(NSLocalizedString(@"info-input-name", nil));
    }else if ([password.text  isEqual: @""]){
        AlertMessage(NSLocalizedString(@"info-input-pwd", nil));
    }else{

        NSDictionary *parameters = @{@"userid":username.text,@"password":password.text};
        [[NetSingleton sharedManager] loginToServer:parameters url:urlLogin successBlock:^(id responseBody){
            
            NSInteger code = [[responseBody objectForKey:@"code"] integerValue];
            if (code==0) {
                NSMutableArray *dataDic = [responseBody objectForKey:@"data"];
                userM = [UserModel objectWithKeyValues:dataDic];
                [self saveUserInfo];
                
                if (_relogin == 1) {
                    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                    appDelegate.window.rootViewController =appDelegate.rootTabbarCtr;
                    appDelegate.rootTabbarCtr.selectedIndex = 0;
                }else {
                    [self initRootVC];
                }

            } else {
                AlertMessage([responseBody objectForKey:@"message"]);
            }
        } failureBlock:^(NSString *error){
            NSLog(@"登录失败：%@",error);
        }];
    }
}

-(void)saveUserInfo {
    userM.password = password.text;
    [ud setObject:@"1" forKey:@"loged"];
    [ud setObject:userM.userid forKey:@"userid"];
    [ud setObject:password.text forKey:@"username"];
    [ud setObject:userM.password forKey:@"password"];
    [ud setObject:IntToStr(userM.role) forKey:@"role"];
    [ud setObject:userM.companyname forKey:@"companyname"];
    
    [GVUserDefaults standardUserDefaults].userName = IsNilOrNull(userM.username)?@"":userM.username ;
    [GVUserDefaults standardUserDefaults].userId = userM.userid;
    [GVUserDefaults standardUserDefaults].password = userM.password;
    [GVUserDefaults standardUserDefaults].role = IntToStr(userM.role);
    [GVUserDefaults standardUserDefaults].companyname = IsNilOrNull(userM.companyname)?@"":userM.companyname;
    [GVUserDefaults standardUserDefaults].field = IsNilOrNull(userM.field)?@"":userM.field;
    [GVUserDefaults standardUserDefaults].position = IsNilOrNull(userM.position)?@"":userM.position;
    [GVUserDefaults standardUserDefaults].title = IsNilOrNull(userM.title)?@"":userM.title;
    [GVUserDefaults standardUserDefaults].type = IsNilOrNull(userM.type)?@"":userM.type;
    [GVUserDefaults standardUserDefaults].smscode = IsNilOrNull(userM.smscode)?@"":userM.smscode;
    [GVUserDefaults standardUserDefaults].address = IsNilOrNull(userM.address)?@"":userM.address;
    [GVUserDefaults standardUserDefaults].contactperson = IsNilOrNull(userM.contactperson)?@"":userM.contactperson;
    [GVUserDefaults standardUserDefaults].phone = IsNilOrNull(userM.phone)?@"":userM.phone;
    [GVUserDefaults standardUserDefaults].isLog = @"loged";
    
}

-(void)initRootVC{
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

    //1.
    HomeViewController *VC1 = [[HomeViewController alloc] init];
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:VC1];
    QueryViewController *VC2 = [[QueryViewController alloc] init];
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:VC2];
    WorkViewController *VC3 = [[WorkViewController alloc] init];
    UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:VC3];
    ConfigViewController *VC4 = [[ConfigViewController alloc] init];
    UINavigationController *nav4 = [[UINavigationController alloc] initWithRootViewController:VC4];
    
    //设置navigationbar的颜色
    [nav1.navigationBar setBarTintColor:DEFAULT_THEME_COLOR_UI];
    [nav2.navigationBar setBarTintColor:DEFAULT_THEME_COLOR_UI];
    [nav3.navigationBar setBarTintColor:DEFAULT_THEME_COLOR_UI];
    [nav4.navigationBar setBarTintColor:DEFAULT_THEME_COLOR_UI];
   
    VC1.title = TAB_ARRAY[0];
    VC2.title = TAB_ARRAY[1];
    VC3.title = TAB_ARRAY[2];
    VC4.title = TAB_ARRAY[3];
    NSArray *viewCtrs = @[nav1,nav2,nav3,nav4];
    
    [appDelegate.rootTabbarCtr setViewControllers:viewCtrs animated:YES];
    appDelegate.window.rootViewController = appDelegate.rootTabbarCtr;
    
    //2.
    UITabBar *tabbar = appDelegate.rootTabbarCtr.tabBar;
    UITabBarItem *item1 = [tabbar.items objectAtIndex:0];
    UITabBarItem *item2 = [tabbar.items objectAtIndex:1];
    UITabBarItem *item3 = [tabbar.items objectAtIndex:2];
    UITabBarItem *item4 = [tabbar.items objectAtIndex:3];
    appDelegate.rootTabbarCtr.selectedIndex = 0;
    
    item1.title = TAB_ARRAY[0];
    item2.title = TAB_ARRAY[1];
    item3.title = TAB_ARRAY[2];
    item4.title = TAB_ARRAY[3];
    
    item1.selectedImage = [[UIImage imageNamed:@"icon_tab_diag_on"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item1.image = [[UIImage imageNamed:@"icon_tab_diag_off"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item2.selectedImage = [[UIImage imageNamed:@"icon_tab_query_on"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item2.image = [[UIImage imageNamed:@"icon_tab_query_off"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item3.selectedImage = [[UIImage imageNamed:@"icon_tab_work_on"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item3.image = [[UIImage imageNamed:@"icon_tab_work_off"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item4.selectedImage = [[UIImage imageNamed:@"icon_tab_person_on"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item4.image = [[UIImage imageNamed:@"icon_tab_person_off"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

}

- (UIViewController *)appRootViewController
{
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}

-(void)viewDidDisappear:(BOOL)animated{
    [SVProgressHUD dismiss];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//点击空白处隐藏键盘
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [username resignFirstResponder];
    [password resignFirstResponder];
}

//点击RETURN隐藏键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


@end
