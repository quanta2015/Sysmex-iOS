//
//  AppDelegate.m
//  diagnosis
//
//  Created by QUANTA on 16/5/16.
//  Copyright © 2016年 sysmex. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (){
    UINavigationController *nav;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self initTabBar];
    [self initLoginView];
    
    return YES;
    
}

-(void) initTabBar {
    
    [[UIApplication sharedApplication] setStatusBarHidden:true];
    
    self.rootTabbarCtr = [[UITabBarController alloc] init];
    self.window.backgroundColor = [UIColor whiteColor];
    [_window makeKeyAndVisible];
}

-(void) initLoginView {
    
    LoginViewController *next = [[LoginViewController alloc] init];
    nav = [[UINavigationController alloc]initWithRootViewController:next];
    //设置navigationbar的颜色
    [nav.navigationBar setBarTintColor:RGBA(38,154,222,1)];
    //设置navigationbar的 TITLE颜色
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                          [UIFont boldSystemFontOfSize:14.0f], NSFontAttributeName,[UIColor whiteColor], UITextAttributeTextColor,nil]];
    self.window.rootViewController = nav;
}

- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
}

- (void)applicationWillTerminate:(UIApplication *)application {
}

@end
