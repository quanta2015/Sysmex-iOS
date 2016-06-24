//
//  ConfigViewController.m
//  diagnosis
//
//  Created by QUANTA on 16/6/14.
//  Copyright © 2016年 sysmex. All rights reserved.
//

#import "ConfigViewController.h"
#import "ConfigInfoTableViewCell.h"
#import "ConfigMenuTableViewCell.h"
#import "SetPwdViewController.h"
#import "LoginViewController.h"
#import "AppDelegate.h"

@interface ConfigViewController ()

@end

@implementation ConfigViewController


-(void)viewWillAppear:(BOOL)animated {
    [_tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTableView];
}

-(void)initTableView{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0 , screen_width, screen_height) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else {
        return 3;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 100;
    }else {
        return 44;
    }

}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger row = [indexPath row];
    NSInteger section = [indexPath section];
    
    if (section == 0) {

        static NSString *cellIndentifier = @"ConfigTableViewCell";
        ConfigInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if (cell == nil) {
            cell = [[ConfigInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        }
        
        [cell setData];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.opaque = YES;
        return cell;

    }else{
        
        static NSString *cellIndentifier = @"ConfigTableViewCell";
        ConfigMenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if (cell == nil) {
            cell = [[ConfigMenuTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        }
        [cell setMenuData:row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.opaque = YES;
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = [indexPath row];
    NSInteger section = [indexPath section];
    
    if ((section == 1)&&(row == 0)) {
        SetPwdViewController *nextVC = [[SetPwdViewController alloc] init];
        [self.navigationController pushViewController:nextVC animated:NO];
    }else if((section == 1)&&(row == 2)) {
        LoginViewController *loginSession = [[LoginViewController alloc] init];
        loginSession.relogin = 1;
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        appDelegate.window.rootViewController = loginSession;
    }
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
