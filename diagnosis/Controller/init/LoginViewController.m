//
//  LoginViewController.m
//  DAZD
//
//  Created by quanta on 15/9/23.
//  Copyright (c) 2015年 DIAN. All rights reserved.
//

#import "AppDelegate.h"

#import "LoginViewController.h"

#import "SVProgressHUD.h"
#import "UserModel.h"


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
    self.navigationItem.title = @"用户登录";
    
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
    username.placeholder = @"用户名";
    username.delegate = self;
    [backView addSubview:username];
    
    password = [[UITextField alloc] initWithFrame:CGRectMake(60, 60, 150, 30)];
    password.placeholder = @"密码";
    password.secureTextEntry = YES;
    password.delegate = self;
    [backView addSubview:password];
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = CGRectMake(screen_width*0.05, 200+60, screen_width*0.9, 40);
    loginBtn.titleLabel.font = [UIFont systemFontOfSize: 20];
    loginBtn.backgroundColor = DEFAULT_THEME_COLOR;
    loginBtn.layer.cornerRadius = 5;
    [loginBtn setTitle:@"登 录" forState:UIControlStateNormal];
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
        AlertMessage(@"请输入用户名！");
    }else if ([password.text  isEqual: @""]){
        AlertMessage(@"请输入密码！");
    }else{

        NSDictionary *parameters = @{@"userid":username.text,@"password":password.text};
        [[NetSingleton sharedManager] loginToServer:parameters url:urlLogin successBlock:^(id responseBody){
            
            NSInteger code = [[responseBody objectForKey:@"code"] integerValue];
            if (code==0) {
                NSMutableArray *dataDic = [responseBody objectForKey:@"data"];
                userM = [UserModel objectWithKeyValues:dataDic];
                [self saveUserInfo];
                [self initRootVC];
            } else {
                AlertMessage([responseBody objectForKey:@"message"]);
            }
        } failureBlock:^(NSString *error){
            NSLog(@"登录失败：%@",error);
        }];
    }
}

-(void)saveUserInfo {
    [ud setObject:@"1" forKey:@"loged"];
    [ud setObject:userM.userid forKey:@"userid"];
    [ud setObject:userM.username forKey:@"username"];
    [ud setObject:userM.password forKey:@"password"];
    [ud setObject:IntToStr(userM.role) forKey:@"role"];
    [ud setObject:userM.companyname forKey:@"companyname"];
}


-(void)initRootVC{
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

    //1.
    UIViewController *VC1 = [[UIViewController alloc] init];
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:VC1];
    UIViewController *VC2 = [[UIViewController alloc] init];
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:VC2];
    UIViewController *VC3 = [[UIViewController alloc] init];
    UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:VC3];
    UIViewController *VC4 = [[UIViewController alloc] init];
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
    
    item1.selectedImage = [[UIImage imageNamed:@"icon_tabbar_home_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item1.image = [[UIImage imageNamed:@"icon_tabbar_home"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item2.selectedImage = [[UIImage imageNamed:@"icon_tabbar_knowledge_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item2.image = [[UIImage imageNamed:@"icon_tabbar_knowledge"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item3.selectedImage = [[UIImage imageNamed:@"icon_tabbar_society_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item3.image = [[UIImage imageNamed:@"icon_tabbar_society"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item4.selectedImage = [[UIImage imageNamed:@"icon_tabbar_my_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item4.image = [[UIImage imageNamed:@"icon_tabbar_my"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

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
