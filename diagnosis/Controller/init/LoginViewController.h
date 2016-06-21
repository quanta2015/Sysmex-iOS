//
//  LoginViewController.h
//  DAZD
//
//  Created by quanta on 15/9/23.
//  Copyright (c) 2015年 DIAN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIView *lnputView;
@property (strong, nonatomic) IBOutlet UITextField *username;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UIButton *loginBtn;
@property (nonatomic) int relogin;



@end
