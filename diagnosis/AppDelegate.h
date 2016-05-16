//
//  AppDelegate.h
//  diagnosis
//
//  Created by QUANTA on 16/5/16.
//  Copyright © 2016年 sysmex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    NSUserDefaults *ud;
}

@property (strong, nonatomic) UIWindow *window;
@property(nonatomic, strong) UITabBarController *rootTabbarCtr;


@end

